local lgi = require("lgi")
local Gtk = lgi.require("Gtk", "3.0")
local window
local function _1_()
  return Gtk.main_quit()
end
window = Gtk.Window({title = "Notes", on_destroy = _1_})
do
  local mainBox = Gtk.Box({orientation = "VERTICAL"})
  window:add(mainBox)
  local scroll = Gtk.ScrolledWindow()
  local buttonBox = Gtk.Box({orientation = "HORIZONTAL"})
  mainBox:add(scroll)
  mainBox:add(buttonBox)
  local textView = Gtk.TextView({visible = true, can_focus = true, vexpand = true, wrap_mode = 3.0, accepts_tab = true, buffer = Gtk.TextBuffer({text = "placeholder"})})
  local buttonOpen = Gtk.Button({label = "Open"})
  local buttonSave = Gtk.Button({label = "Save"})
  scroll:add(textView)
  buttonBox:add(buttonSave)
  buttonBox:add(buttonOpen)
  local buffer = textView:get_buffer()
  local function show_open_dialog()
    local native = Gtk.FileChooserNative({title = "Open a file", action = Gtk.FileChooserAction.OPEN, accept_label = "_Open", cancel_label = "_Cancel"})
    local response = native:run()
    if (response == Gtk.ResponseType.ACCEPT) then
      local file = native:get_file()
      local path = file:get_path()
      print(path)
      local f = io.open(path, "r")
      local function close_handlers_13_(ok_14_, ...)
        f:close()
        if ok_14_ then
          return ...
        else
          return error(..., 0)
        end
      end
      local function _3_()
        return f:read("*all")
      end
      local _5_
      do
        local t_4_ = _G
        if (nil ~= t_4_) then
          t_4_ = t_4_.package
        else
        end
        if (nil ~= t_4_) then
          t_4_ = t_4_.loaded
        else
        end
        if (nil ~= t_4_) then
          t_4_ = t_4_.fennel
        else
        end
        _5_ = t_4_
      end
      local or_9_ = _5_ or _G.debug
      if not or_9_ then
        local function _10_()
          return ""
        end
        or_9_ = {traceback = _10_}
      end
      close_handlers_13_(_G.xpcall(_3_, or_9_.traceback))
    else
    end
    return native:destroy()
  end
  local function _12_(widget)
    return print(show_open_dialog())()
  end
  buttonOpen.on_clicked = _12_
end
window:show_all()
Gtk.main()
return print("")
