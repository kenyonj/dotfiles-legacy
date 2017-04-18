#!/bin/bash

email_dirs=(
  "$HOME/mail/work/inbox/new"
  "$HOME/mail/gmail/inbox/new"
  "$HOME/mail/fastmail/INBOX/new"
)
message=""

for email_dir in ${email_dirs[*]}; do
  num_mail=$(ls $email_dir|wc -l)

  if [[ $num_mail -gt 0 ]]; then
    for email in $email_dir/*; do
      message="$message\n$(grep -m1 '^From: ' $email|sed 's/From: //'|sed 's/ <[^>]*>//')\n$(grep -m1 '^Subject: ' $email|sed 's/Subject: //')\n"
    done
  fi
done

previous_notification=`cat /tmp/new-message-notifications`

if [ -n "$message" ] && [[ "$previous_notification" != "$message" ]]; then
  notify-send "New Mail" "$message" -i "$HOME/.scripts/mailicon.png" -t 5000 &
  echo "$message" > /tmp/new-message-notifications
fi

notmuch new &
