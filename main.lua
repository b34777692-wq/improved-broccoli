runtime.version = "Lua 5.3"
local lgi = require 'lgi'
local Gtk = lgi.require("Gtk", "3.0")

local window = Gtk.Window {
  title = "Notes",
  Gtk.Box {
    orientation = 'VERTICAL',
    Gtk.Entry {
      id = 'entry'
    },
    Gtk.Box {
      orientation = 'HORIZONTAL',
      Gtk.Button {
        label = 'Save',
        id = 'save'
      },
      Gtk. Button {
        label = 'Open',
        id = 'open'
      }
    }
  },
  on_destroy = function()
    Gtk.main_quit()
  end
}

window:show_all()
Gtk.main()
