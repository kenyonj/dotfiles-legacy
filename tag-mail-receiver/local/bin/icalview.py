#!/usr/bin/env python2

import sys
import ics
import arrow

cal = ics.Calendar(sys.stdin.read().decode('utf-8'))
tz = arrow.now().tzinfo
tzformat = 'ddd DD MMM HH:mm'

for event in cal.events:
    extra = {}

    for item in event._unused:
        if not isinstance(item, ics.parse.ContentLine):
            continue
        try:
            extra[item.name.lower()] = item.value
        except:
            print item
            raise

    print "Event:    ", event.name
    print "Status:   ", extra['status'].title()
    print "Organiser:", extra['organizer']
    print "Starts:   ", event.begin.to(tz).format(tzformat), "(local time)"
    print "Ends:     ", event.end.to(tz).format(tzformat)
    print "Location: ", event.location
    print "Description:"
    print (event.description or u'').encode('utf-8')
    print
