#!/usr/bin/env ruby

require "rubygems"
require "icalendar"
require "date"

cals = Icalendar.parse($<)
cals.each do |cal|
  cal.events.each do |event|
    puts "Organizer: #{event.organizer}"
    puts "Event:     #{event.summary}"
    puts "Starts:    #{event.dtstart.strftime("%A, %b %d, %Y - %l:%M %p")}"
    puts "Ends:      #{event.dtend.strftime("%A, %b %d, %Y - %l:%M %p")}"
    puts "Location:  #{event.location}"
    puts "Description:\n#{event.description}"
    puts ""
    end
end
