# theming
(put config :border-width 4)
(put config :outer-padding 10)
(put config :inner-padding 4)
(dofile (string (os/getenv "HOME") "/.cache/ashwal/colors-ashrwm.janet") :env (curenv))

# layout
(put config :layout :scroller)
(put config :main-ratio 0.75)
(put config :layouts @{2 :monocle
                       3 :floating

                       4 :monocle})
(put config :focus-wrap false)
(put config :float-on-top true)
(put config :new-window-position :end)

# input
(put config :tap-to-click true)
(put config :natural-scroll true)
(put config :dwt true)
(put config :focus-follows-mouse true)

# rules
(set (config :rules)
     @[[:app-id "mpv" {:float true}]
       [:app-id "org.twosheds.iwgtk" {:float true}]
       [:title "impala" {:float true}]
       [:title "Picture-in-Picture" {:float true :sticky true}]])

# keybinds
(set (config :xkb-bindings)
     @[# App launchers
       [:space {:mod1 true} (action/spawn ["rofi" "-show" "drun" "-show-icons"])]
       [:Return {:mod1 true} (action/spawn ["kitty"])]
       [:v {:mod1 true} (action/spawn ["sh" "-c" "cliphist list | rofi -dmenu | cliphist decode | wl-copy"])]
       [:t {:mod1 true} (action/spawn ["flatpak" "run" "app.zen_browser.zen"])]
       [:e {:mod1 true} (action/spawn ["thunar"])]
       [:w {:mod1 true} (action/spawn ["emacsclient" "-c" "-a" "emacs"])]
       [:i {:mod1 true} (action/spawn ["gtklock"])]
       [:p {:mod1 true} (action/spawn ["sh" "-c" "connect"])]
       [:m {:mod1 true} (action/spawn ["kitty" "-e" "rmpc"])]
       [:question {:mod1 true} (action/spawn ["rofi" "-show" "recursivebrowser"])]
       [:comma {:mod1 true} (action/spawn ["sh" "-c" "solemn"])]
       [:comma {:mod1 true :ctrl true} (action/spawn ["sh" "-c" "silly"])]
       [:space {:mod1 true :shift true} (action/spawn ["sh" "-c" "notes"])]
       [:space {:mod1 true :ctrl true} (action/spawn ["walmenu"])]
       #[:Tab {:mod1 true} (action/toggle-overview)]

       # Volume / Brightness
       [:XF86AudioRaiseVolume {} (action/spawn ["bash" "-c" "osd volume 5%+"])]
       [:XF86AudioLowerVolume {} (action/spawn ["bash" "-c" "osd volume 5%-"])]
       [:XF86AudioMute {} (action/spawn ["bash" "-c" "osd volume toggle"])]
       [:XF86MonBrightnessUp {} (action/spawn ["bash" "-c" "osd brightness 10%+"])]
       [:XF86MonBrightnessDown {} (action/spawn ["bash" "-c" "osd brightness 10%-"])]

       # Screenshots
       [:Print {} (action/spawn ["sh" "-c" "screenshot clip"])]
       [:Print {:mod1 true} (action/spawn ["sh" "-c" "screenshot"])]
       [:Print {:mod1 true :shift true} (action/spawn ["sh" "-c" "screenshot ocr"])]
       [:Print {:mod1 true :mod1 true} (action/spawn ["sh" "-c" "screenshot full"])]
       [:Print {:mod1 true :ctrl true :shift true} (action/spawn ["sh" "-c" "screenshot color"])]

       # Window management
       [:q {:mod1 true} (action/close)]
       [:r {:mod1 true} (action/config)]
       [:n {:mod1 true} (action/zoom)]
       [:j {:mod1 true} (action/focus :prev)]
       [:k {:mod1 true} (action/focus :next)]
       [:h {:mod1 true} (action/focus-output)]
       [:l {:mod1 true} (action/focus-output)]
       [:a {:mod1 true} (action/fullscreen)]
       [:b {:mod1 true} (action/swap-main)]
       [:d {:mod1 true} (action/sticky)]
       [:g {:mod1 true} (action/float)]
       [:z {:mod1 true} (action/layout :tile)]
       [:x {:mod1 true} (action/layout :grid)]
       [:s {:mod1 true} (action/layout :scroller)]
       [:c {:mod1 true} (action/layout :monocle)]
       [:f {:mod1 true} (action/layout :floating)]
       [:l {:mod1 true :shift true} (action/view-tag :next)]
       [:h {:mod1 true :shift true} (action/view-tag :prev)]
       [:equal {:mod1 true} (action/main-ratio 0.05)]
       [:minus {:mod1 true} (action/main-ratio -0.05)]
       [:equal {:mod1 true :shift true} (action/window-ratio 0.05)]
       [:minus {:mod1 true :shift true} (action/window-ratio -0.05)]
       [:Escape {:mod1 true :mod1 true :shift true :ctrl true} (action/passthrough)]
       [:q {:mod1 true :shift true} (action/exit-session)]
       [:0 {:mod1 true} (action/focus-all-tags)]])

(for i 1 10
  (let [keysym (keyword i)]
    (array/push (config :xkb-bindings) [keysym {:mod1 true} (action/focus-tag i)])
    (array/push (config :xkb-bindings) [keysym {:mod1 true :shift true} (action/set-tag i)])))

(set (config :pointer-bindings)
     @[[:left {:mod1 true} (action/pointer-move)]
       [:right {:mod1 true} (action/pointer-resize)]])
