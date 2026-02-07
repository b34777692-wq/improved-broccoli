(local lgi (require :lgi))
(local Gtk (lgi.require :Gtk :3.0))

(local window (Gtk.Window {:title :Notes :on_destroy (fn [] (Gtk.main_quit))}))

(let [mainBox (Gtk.Box {:orientation :VERTICAL})]
  (window:add mainBox)
  (let [scroll (Gtk.ScrolledWindow)
        buttonBox (Gtk.Box {:orientation :HORIZONTAL})]
    (mainBox:add scroll)
    (mainBox:add buttonBox)
    (let [textView (Gtk.TextView {:visible true
                                  :can_focus true
                                  :vexpand true
                                  :wrap_mode 3
                                  :accepts_tab true
                                  :buffer (Gtk.TextBuffer {:text :placeholder})})
          buttonOpen (Gtk.Button {:label :Open})
          buttonSave (Gtk.Button {:label :Save})]
      (scroll:add textView)
      (buttonBox:add buttonSave)
      (buttonBox:add buttonOpen)
      (let [buffer (textView:get_buffer)]
        (fn show_open_dialog []
          (let [native (Gtk.FileChooserNative {:title "Open a file"
                                               :action Gtk.FileChooserAction.OPEN
                                               :accept_label :_Open
                                               :cancel_label :_Cancel})
                result (let [response (native:run)]
                         (if (= response Gtk.ResponseType.ACCEPT)
                             (let [file (native:get_file)
                                   path (file:get_path)]
                               (print path)
                               (with-open [f (io.open path :r)] (f:read :*all)))))]
            (native:destroy)
            result))

        (fn show_save_dialog [data]
          (let [native (Gtk.FileChooserNative {:title "Save to file"
                                               :action Gtk.FileChooserAction.SAVE
                                               :accept_label :_Save
                                               :cancel_label :_Cancel
                                               :do_overwrite_confirmation true})]
            (let [response (native:run)]
              (if (= response Gtk.ResponseType.ACCEPT)
                  (let [file (native:get_file)
                        path (file:get_path)]
                    (with-open [f (io.open path :w)] (f:write data))
                    (native:destroy))))))

        (set buttonSave.on_clicked
             (fn [_]
               (let [data buffer.text]
                 (show_save_dialog data))))
        (set buttonOpen.on_clicked
             (fn [_]
               (let [contents (show_open_dialog)]
                 (when contents
                   (set buffer.text contents)))))))))

(window:show_all)
(Gtk.main)
(print "")
