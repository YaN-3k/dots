# Frequently Asked Questions

## Surf is starting up slowly. What might happen?

The  first suspect for such a behaviour is the plugin handling. Run surf
on the commandline and see if there are errors because of »nspluginwrap‐
per«  or  failed RPCs to them. If that is true, go to ~/.mozilla/plugins
and try removing stale links to plugins not on your system anymore. This
will stop surf from trying to load them.

