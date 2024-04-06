## Fcitx
fcitx does not play well with tiling window managers

Problem:
When `<input>` selected in firefox, and 
switch to terminal with modifier keys 
(e.g. go to left terminal with $mod+H)
fcitx still "stuck" at `<input>`. This means cannot change typing
language at terminal.
Solution:
deselect `<input>` when switching to terminal
