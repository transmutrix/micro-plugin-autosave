# autosave plugin

The autosave plugin is a (hacky) replacement for
the default autosave feature in micro.

By default, all plugin functionality is _turned off_.

autosave currently offers 2 types of autosave, which can
be used together (although that seems pointless).

Each type is controlled through your config:

- `save_on_switch_buffer` will cause micro to save the
  current view whenever you switch to a different tab
  or split pane.

- `save_on_rune` will cause micro to save every couple
  seconds during typing.

`save_on_rune` can result in silliness when editing code,
but for writing prose, it can be convenient.

This plugin pairs well with the built-in `saveundo` option.
It never hurts to be cautious. :)
