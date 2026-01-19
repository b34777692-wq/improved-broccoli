local lgi = require 'lgi'
local Gtk = lgi.require("Gtk", "3.0")

local window = Gtk.Window {
  title = "Notes",
  Gtk.Box {
    orientation = 'VERTICAL',
    Gtk.ScrolledWindow {
      id = 'scroll'
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

local textview = Gtk.TextView {
  visible = true,
  can_focus = true,
  vexpand = true,
  wrap_mode = Gtk.WrapMode.WORDCHAR,
  accepts_tab = true,
  buffer = Gtk.TextBuffer { text = "placeholder"}
}
window.child.scroll:add(textview)

local function show_open_dialog()
  local native = Gtk.FileChooserNative {
    title = "Open file",
    action = Gtk.FileChooserAction.OPEN,
    accept_label = "_Open",
    cancel_label = "_Cancel",
  }
  local response = native:run()
  if response  == Gtk.ResponseType.ACCEPT then
    local file = native:get_file()
    print(1)
    local path = file:get_path()
    print(2)
    return path
  end
  native:destroy()
end


local function saveFile(path, data)
  local file = io.open(path, "w")
  if file then
    file:write(data)
  else
    print("Invalid file")
  end
end

local function show_save_dialog(data)
  local native = Gtk.FileChooserNative {
    title = "Save file",
    action = Gtk.FileChooserAction.SAVE,
    accept_label = "_Save",
    cancel_label = "_Cancel",
  }
  local response = native:run()
  if response  == Gtk.ResponseType.ACCEPT then
    local file = native:get_file()
    print(1)
    local path = file:get_path()
    print(2)
    saveFile(path, data)
  end
  native:destroy()
end

function window.child.open:on_clicked()
  local path = show_open_dialog()
  local file = io.open(path, "r")
  if not file then
    return
  end
  local contents = file:read("*a")
  file:close()
  local buffer = textview:get_buffer()
  buffer.text = contents
end
function window.child.save:on_clicked()
  local buffer = textview:get_buffer()
  local data = buffer.text
  show_save_dialog(data)
end




window:show_all()
Gtk.main()
