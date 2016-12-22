#!/bin/env ruby
require "yaml"

class Configuration
  GIT_PREFIX = "git@github.com:".freeze

  def self.load
    new.run
  end

  def run
    load_dependencies
    rcup
  end

  private

  def dependencies
    YAML.load_file([dotfiles_root, "dependencies.yml"].join("/"))
  end

  def load_dependencies
    dependencies["git_repositories"].each do |name, details|
      base_path = details.dig("base_path")
      repo_location = details.dig("repo_location")
      tag = details.dig("tag")
      copy_details = details.dig("copy")
      dependency_folder_location =
        [dotfiles_root, tag, base_path, name].compact.join("/")

      unless folder_exists?(dependency_folder_location)
        clone_repo(repo_location, dependency_folder_location)
      end

      update(dependency_folder_location)
      copy_files(dependency_folder_location, copy_details)
      append_entry_to_gitignore(dependency_folder_location)
    end
  end

  def append_entry_to_gitignore(entry)
    unless gitignore_entries.any? { |line| line[relative_path_for(entry)] }
      File.open(gitignore_file, "a") do |file|
        file.puts relative_path_for(entry)
      end
    end
  end

  def gitignore_entries
    File.foreach(gitignore_file)
  end

  def gitignore_file
    [dotfiles_root, ".gitignore"].join("/")
  end

  def relative_path_for(entry)
    entry.gsub("#{dotfiles_root}/", "")
  end

  def folder_exists?(folder)
    File.directory?(folder)
  end

  def clone_repo(repo, folder)
    system("git clone #{GIT_PREFIX}#{repo} #{folder}")
  end

  def copy_files(dependency_folder_location, copy_details)
    copy_details &&
      system(make_directory_command(dependency_folder_location)) &&
      system(copy_command(dependency_folder_location, copy_details)) &&
      append_entry_to_gitignore(absolute_path_to_destination_file(copy_details))
  end

  def absolute_path_to_destination_file(copy_details)
    [dotfiles_root, copy_details["destination_path"], copy_details["filename"]].
      join("/")
  end

  def update(folder)
    system("cd #{folder} && git checkout master && git pull")
  end

  def rcup
    system("export RCRC='#{dotfiles_root}/host-#{hostname}/rcrc'")
    system("rcup")
  end

  def home_path
    ENV.fetch("HOME")
  end

  def dotfiles_root
    [home_path, "dotfiles"].join("/").freeze
  end

  def hostname
    `hostname`.chomp
  end

  def copy_command(dependency_folder_location, copy_details)
    "cp "\
      "#{dependency_folder_location}/#{copy_details['filename']} "\
      "#{dotfiles_root}/#{copy_details['destination_path']}/"
  end

  def make_directory_command(dependency_folder_location)
    "mkdir -p #{dependency_folder_location}"
  end
end

Configuration.load
