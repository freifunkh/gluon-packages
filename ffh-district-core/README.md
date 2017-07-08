The idea
========

As our mesh network in Hannover is becomming greater and greater, we get issues
with the "ground noise" (noise floor). All routers are announcing their routing information
periodically every 10 seconds, which leads to a lot of packets. Furthermore since
the network is a layer 2 network we have a lot of ARP and ICMPv6 traffic to
resolve the IP-addresses into mac addresses. Currently there is no chance to
establish a VPN tunnel from a DSL 2000 line, without blocking the whole line (
even if you have no real payload traffic).

So we need to introduce a new concept. There are already some existing
approaches e.g. [hoodselector](https://github.com/freifunk-gluon/gluon/pull/997)
and [site-select](https://github.com/freifunk-gluon/gluon/pull/1003). But both
are not ideal for our needs, yet. But maybe we should define our needs first.

Our needs in short words:
1. low complexity
2. splitting the layer2 segments should be easy
3. automatic segment switching is not so important

The first requirement kicks out the hoodselector, as it has a rather complex
state machine to ensure no mesh connection between the segments (in their
usage called "hoods"). A cool feature of the hoodselector is, that a router
automatically switches it's segment, when there is a neighbour router having
an other segment. But in our opinion, this is not important enough to justify
such a complex software for this feature. So we went on and looked for another
approach.

Next we found the site-select package which allows to bake multiple segment
configs (`site.conf`) files into the image and chose one of them in a dropdown
in the config mode. This implies you always have to reboot your router to change
the segment, but this should be okay for us. But this package has also some
issues for us. First of all the dropdown is located in the expert mode, so
probably most of the routers will end up in the default district. But this is
just a minor issue.

The other (greater) issue is, that our idea is to provide a diverse dropdown, so
the user can choose between our 52 districts and some outside locations. Not
each of those districts should be in another segment (or "layer 2 segment"). At
least not yet. So we begin with 9 or 10 segments (hopefully each including about
100 routers), but we also have a finer graduated information for each router
if we want to split again. This is actually not very easy, because not every
router provides its geo location.

To sum up, we have two concepts:
- **district**: actually a city district, an outside location, or maybe also a
  subcommunity using our infrastructure. This information is mandatory for each
  router.
- **segment**: multiple districts are taken together into a segment. Routers in the
  same segment are able to mesh with each other (so have the same mesh SSID,
  network range, ...)

The issue, why we cant use the site-select package here, is that we would have
to bake >50 `site.conf` files (each around 3 kB) into the firmware, which costs
a lot of storage. So we decided to create our own solution based on the source
code of the site-select package.

Migration
---------

**1st phase: migrating the existing routers**

As already mentioned, the initial migration from the current state is a
challenge. Not every router is providing its geo information, so we need to take
other indicators (e.g. the mesh partners) into account. We definitely don't want
to break already established meshes. Since this is just an initial problem, we
put the logic for this into a script on a server and let the router ask for a
district for his nodeid via http. This is done by the package
[ffh-district-migrate](https://github.com/freifunkh/ffh-packages/tree/master/ffh-district-migrate).
Some day this package will be removed from the routers.

When there are new routers during this phase, it is reasonable to already show
the dropdown and let the user choose it's district by itself (as it will be
later the normal way to do so). This is done by the package
[ffh-district-core](https://github.com/freifunkh/ffh-packages/tree/master/ffh-district-core).

So this phase is just a migration phase. **All routers are still able to mesh with
each other and the district is just saved for later use.** For now the information
is effectively unused. To supervise the whole process, every router will
announce its district via respondd. This is also done by the
[ffh-district-core](https://github.com/freifunkh/ffh-packages/tree/master/ffh-district-core)
package.

**2nd phase: propagating the segments**

For now all routers should have a district assigned, but to the mesh no actual change happened.
The transition is a delicate thing, since the router which once
changed its district is no longer able to mesh with the one not yet migrated. So
if the uplink router changes it's district, the mesh-only routers need another
way to receive their firmware upgrade.

This is where the [ffho-autoupdater-wifi-fallback](https://git.c3pb.de/freifunk-pb/ffho-packages/tree/master/ffho/ffho-autoupdater-wifi-fallback)
comes into play. With this package the router may download its firmware image
via the client network, when there is no mesh network to reach the update server.
So the mesh-only routers can connect to the client network of the other routers,
which already have updated their firmware and no router should be left behind.

The actual **segment** magic is done by the
[ffh-district-site-adjust](https://github.com/freifunkh/ffh-packages/tree/master/ffh-district-site-adjust)
package. It patches the initial `site.conf` every time the district is changed.
This has the advantage, that we do not need to store a `site.conf` for each
district on the router, which saves a lot of space. Maybe using compression would
do the same job, but we decided to use this
[patching mechanism](https://github.com/freifunkh/ffh-packages/blob/master/ffh-district-site-adjust/files/lib/gluon/upgrade/002-adjust-site-config).


Features
--------

The packages `ffh-district-*` have the following main functions:
- Add a dropdown field for the districts to the main page of the config mode.
- Patch the site config regarding to the district directly on the router, so
  you can have a lot of different site configs without losing a lot of space.
- The district is announced via respondd at the nodeinfo section.
- A migration strategy from the point where no router has a `district` set yet.


Useful stuff
------------

**show the current district:**
``` shell
uci show gluon-node-info.district.current
```

**Changing the district manually:**
``` shell
uci set gluon-node-info.district.current='leetfeld' # use the short identifier here
uci commit gluon-node-info
/lib/gluon/district-changed.sh
```

For the short identifiers, see [here](https://github.com/freifunkh/ffh-packages/blob/master/ffh-district-core/files/usr/lib/lua/gluon/districts.lua).

**Asking a node for it's district via respondd:**

``` shell
gluon-neighbour-info -r nodeinfo -p 1001 -d ::1 -t 0.2 | tr -s "," "\n" | grep district
```

List of important files
-----------------------

This is a flat overview of the most important files in the three packages. To
help other communities to adapt our package, all relevant files are marked with
asterisk (\*) after their name/description here.

1. [dropdown for config mode](https://github.com/freifunkh/ffh-packages/blob/master/ffh-district-core/files/lib/gluon/config-mode/wizard/0200-site-adjust.lua)
2. [district config](https://github.com/freifunkh/ffh-packages/blob/master/ffh-district-core/files/usr/lib/lua/gluon/districts.lua)\*\*
3. [respondd provider](https://github.com/freifunkh/ffh-packages/blob/master/ffh-district-core/src/respondd.c)
4. [migration script](https://github.com/freifunkh/ffh-packages/blob/master/ffh-district-migrate/files/lib/gluon/district-migrate)\*
5. [handler to call the patching process](https://github.com/freifunkh/ffh-packages/blob/master/ffh-district-site-adjust/files/lib/gluon/district-changed.d/site-upgrade)
6. [patching the site.conf](https://github.com/freifunkh/ffh-packages/blob/master/ffh-district-site-adjust/files/lib/gluon/upgrade/002-adjust-site-config)\*\*

\* only a small Hannover related information (look for: `http://web.ffh.zone/migrate/`)

\*\* a lot of Hannover related information
