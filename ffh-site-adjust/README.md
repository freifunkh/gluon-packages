ffh-site-adjust
======================

This Repository contains a Gluon package to choose between different sites/districts files after flashing the image. <br>
This does not apply to the site.mk!

Features
--------

This package has three main functions:
- Add a dropdown field for the districts to the main page of the config mode.
- Patch the site config regarding to the district directly on the router, so you can have a lot of different site configs without losing a lot of space.
- By patching the `site_code` and `site_name` in the site, the district is also announced to respondd.

Usage
-----

```
uci show gluon-node-info.district.current
```

```/lib/gluon/site-upgrade``` triggers all scripts below ```/lib/gluon/upgrade/*``` including ```002-adjust-site-config```, which writes an adjusted version of ```/lib/gluon/site.json```.
