local lgi = require("lgi")
local Gtk = lgi.require("Gtk", "3.0")
local window
local function _1_()
  return Gtk.main_quit()
end
window = Gtk.Window({Gtk.Box({orientation = "VERTICAL"}, 1, Gtk.ScrolledWindow({id = "scroll"}), 2, Gtk.Box({orientation = "HORIZONTAL"}, 1, Gtk.Button({label = "Save", id = "save"}), 2, Gtk.Button({label = "Open", id = "open"}))), title = "Notes", on_destroy = _1_})
do
  local textview = Gtk.TextView({visible = true, can_focus = true, vexpand = true, wrap_mode = Gtk.WrapMode.WORD_CHAR, accepts_tab = true, buffer = Gtk.TextBuffer({text = "placeholder"})})
  local root = window.child
  root.scroll:add(textview)
end
window:show_all()
Gtk:main()
return print("")
