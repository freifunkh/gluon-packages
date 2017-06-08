ffh-site-adjust
======================

This Repository contains a Gluon package to choose between different sites/districts files after flashing the image. <br>
This does not apply to the site.mk!

Usage
-----

# uci show gluon-node-info.district.current

/lib/gluon/site-upgrade triggers all scripts below /lib/gluon/upgrade/ including 002-adjust-site-config, which writes an adjusted version of /lib/gluon/site.json.
