ffh-district-site-adjust
========================

This package contains to actually patches the `site.conf` based on the district.

- The patching routine is [here](https://github.com/freifunkh/ffh-packages/blob/master/ffh-district-site-adjust/files/lib/gluon/upgrade/002-adjust-site-config).
- It also it also provides a [district-changed.d/](https://github.com/freifunkh/ffh-packages/blob/master/ffh-district-site-adjust/files/lib/gluon/district-changed.d/site-upgrade)-script to react to updates
  properly.

For more information, see the [ffh-district-core](https://github.com/freifunkh/ffh-packages/tree/master/ffh-district-core)
or [ffh-district-migrate](https://github.com/freifunkh/ffh-packages/tree/master/ffh-district-migrate) packages.

Hacks:
------

**Use the original site.conf without changes:**

``` shell
cp /rom/lib/gluon/site.json /lib/gluon/
rm /lib/gluon/upgrade/002-adjust-site-config
/lib/gluon/district-changed.sh
reboot
```


```/lib/gluon/site-upgrade``` triggers all scripts below ```/lib/gluon/upgrade/*``` including ```002-adjust-site-config```, which writes an adjusted version of ```/lib/gluon/site.json```.
