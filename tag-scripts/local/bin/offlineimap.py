#!/usr/bin/python

import os
import re
import subprocess

mapping = { 'INBOX':              'inbox'
          , '[Gmail]/All Mail':   'archive'
          , '[Gmail]/Drafts':     'drafts'
          , '[Gmail]/Important':  'important'
          , '[Gmail]/Sent Mail':  'send'
          , '[Gmail]/Spam':       'spam'
          , '[Gmail]/Starred':    'starred'
          , '[Gmail]/Trash':      'trash'
          }

r_mapping = { val: key for key, val in mapping.items() }

def nt_remote(folder):
    return mapping.get(folder, folder)

def nt_local(folder):
    return r_mapping.get(folder, folder)

def get_secret(email_address):
    pw = subprocess.check_output(["/home/justin/.local/bin/getnetrc", email_address])
    return str(pw).strip()
