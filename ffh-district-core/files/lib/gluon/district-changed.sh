#!/bin/sh

for script in /lib/gluon/district-changed.d/*; do
	"$script"
done
