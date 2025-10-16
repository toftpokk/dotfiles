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

## Policies.json

ID is from `guid` in https://addons.mozilla.org/api/v5/addons/addon/ublock-origin/
Where this link is from? Searching in extensions and copying the name in the URL
Nobody has any idea where it's from.

## Mako
Always show truncated messages

To get full messages
```sh
busctl --user call org.freedesktop.Notifications /fr/emersion/Mako fr.emersion.Mako ListNotifications -j \
        | jq -r '.data[][] | select(.body.type == "s") | "\(.["app-name"].data)\n  \(.summary.data)\n  \(.body.data)\n"'
```
ref: https://github.com/emersion/mako/issues/540

# New things
- yazi is weird coming from lf:
    - wrapping top & bottom
    - filter vs find
- ghostty
    - is too slow to spawn
    - top bars is annoying for tiling window managers
    - some ssh targets don't work:
      - ssh into old servers and delete becomes space
    - pasting shows annoying dialog
      - I know it's for security but very annoying
- hyprland
	- suspend and wake is a little wonky. niri supports this better
	- swallow is a little weird.
		- Opening pdfs and quitting sometimes leaves a terminal hanging
		- Sometimes swallowing does not shift focus to created window (hitting q quits the swallower)
  - sometimes it just does not wake up
