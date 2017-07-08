ffh-site-adjust-migrate
=======================

This package migrates a freifunk router to a ```district``` by
asking a webserver periodically every hour.

When you want to begin using the concept of districts in your
mesh, you normally have a lot of routers already configured
but without a configured district.

So there are now two choices:
1. Every router owner has to set the ```district``` manually
2. We migrate the routers centralized by an upgrade process

We decided to opt for the second choice and migrate the routers
using this helper package. It currently queries
```http://web.ffh.zone/migrate/${node_id}``` and the webserver
returns the new district as plain ascii.

The script will be triggered hourly disregarding whether there
is already a district set. The minute is randomly chosen
at the first boot after upgrading.

Dependencies
------------

This package was designed to work without the other
ffh-site-adjust* packages, so you can migrate the routers
without making actual changes at the ```site.conf```. So
you can install this package and wait until every router
has properly configured a district value before you
change the ```site.conf```.

If the file ```/lib/gluon/site-upgrade``` exists and is
executable, it will be called after changing the district
and a reboot is fired. So other packages can provide this
file and do stuff when the district was changed. (e.g.
adjust the ```site.conf```)

Pseudo Code
-----------

```
new_district = ask_webserver(node_id)

if curr_district == new_district:
   do nothing!

else:
   set_district(new_district)

   if exists(/lib/gluon/site-upgrade):
       execute(/lib/gluon/site-upgrade)
       reboot
```

Internals
---------

Manually trigger the migrate script:
``` shell
/lib/gluon/district-migrate
```

Path of the installed cronjob:
``` shell
/usr/lib/micron.d/migrate-districts
```
