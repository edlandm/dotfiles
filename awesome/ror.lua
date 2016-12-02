-- ror.lua
-- This is the file goes in your ~/.config/awesome/ directory
-- It contains your table of 'run or raise' key bindings for aweror.lua
-- Table entry format: ["key"]={"function", "match string", "optional attribute to match"}
-- The "key" can include "Control-", "Shift-", and "Mod1-" modifiers (eg "Control-z")
-- The "key" will be bound as "modkey + key". (eg from above would end up as modkey+Control+z)
-- The "function" is what gets run if no matching client windows are found.
-- Usual attributes are "class","instance", or "name". If no attribute is given it defaults to "class".
-- The "match string"  will match substrings.  So "Firefox" will match "blah Firefox blah"
-- Use xprop to get this info from a window.  WM_CLASS(STRING) gives you "instance", "class".
-- WM_NAME(STRING) gives you the name of the selected window (usually something like the web page title
-- for browsers, or the file name for emacs).

table5={
   ["/"]={"xterm -T ranger ranger","ranger","name"},
   ["c"]={"xterm -class Cmus cmus","Cmus","class"},
   -- Open up both of my gmail accounts
   ["g"]={"luakit -U -c /home/miles/.config/luakit/sessionless.rc.lua --name=Gmail --class=Gmail -u https://mail.google.com/mail/u/1/h/kdv1dekdzxyl/? -u https://mail.google.com/mail/u/0/h/17c1a9ztmci6h/?tab=wm&zy=g&f=1", "Gmail", "name"},
   ["t"]={"luakit -U -c /home/miles/.config/luakit/sessionless.rc.lua --name=Telegram --class=Telegram -u https://web.telegram.org/#/im", "Telegram", "name"},
   ["p"]={"xterm -T pianobar pianobar","pianobar","name"},
   ["i"]={"xterm -T Irssi irssi","Irssi","name"},
   ["y"]={"xterm -class Mpsyt mpsyt","Mpsyt","class"},
   ["Shift-m"]={"xterm -T alsamixer alsamixer","alsamixer","name"}
}
