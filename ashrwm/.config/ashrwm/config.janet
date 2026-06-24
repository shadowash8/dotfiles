# theming
(put config :border-width 4)
(put config :outer-padding 10)
(put config :inner-padding 4)
(dofile (string (os/getenv "HOME") "/.cache/ashwal/colors-ashrwm.janet") :env (curenv))

# layout
(put config :layout :scroller)
(put config :main-ratio 0.75)
(put config :layouts @{2 :monocle
                       4 :monocle})
(put config :focus-wrap false)
(put config :float-on-top true)
(put config :new-window-position :end)

# input
(put config :tap-to-click true)
(put config :natural-scroll true)
(put config :dwt false)
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
       [:space {:mod4 true} (action/spawn ["rofi" "-show" "drun" "-show-icons"])]
       [:Return {:mod4 true} (action/spawn ["kitty"])]
       [:v {:mod4 true} (action/spawn ["sh" "-c" "cliphist list | rofi -dmenu | cliphist decode | wl-copy"])]
       [:t {:mod4 true} (action/spawn ["zen-browser-twilight"])]
       [:e {:mod4 true} (action/spawn ["thunar"])]
       [:w {:mod4 true} (action/spawn ["emacsclient" "-c" "-a" "emacs"])]
       [:i {:mod4 true} (action/spawn ["gtklock"])]
       [:p {:mod4 true} (action/spawn ["sh" "-c" "connect"])]
       [:m {:mod4 true} (action/spawn ["kitty" "-e" "rmpc"])]
       [:question {:mod4 true} (action/spawn ["rofi" "-show" "recursivebrowser"])]
       [:comma {:mod4 true} (action/spawn ["sh" "-c" "solemn"])]
       [:comma {:mod4 true :ctrl true} (action/spawn ["sh" "-c" "silly"])]
       [:space {:mod4 true :shift true} (action/spawn ["sh" "-c" "notes"])]
       [:space {:mod4 true :ctrl true} (action/spawn ["walmenu"])]
       [:space {:mod4 true :ctrl true :mod1 true} (action/spawn ["swal"])]
       #[:Tab {:mod4 true} (action/toggle-overview)]

       # Volume / Brightness
       [:XF86AudioRaiseVolume {} (action/spawn ["osd" "volume" "5%+"])]
       [:XF86AudioLowerVolume {} (action/spawn ["osd" "volume" "5%-"])]
       [:XF86AudioMute {} (action/spawn ["osd" "volume" "toggle"])]
       [:XF86MonBrightnessUp {} (action/spawn ["osd" "brightness" "10%+"])]
       [:XF86MonBrightnessDown {} (action/spawn ["osd" "brightness" "10%-"])]

       # Screenshots
       [:Print {} (action/spawn ["sh" "-c" "screenshot clip"])]
       [:Print {:mod4 true} (action/spawn ["sh" "-c" "screenshot"])]
       [:Print {:mod4 true :shift true} (action/spawn ["sh" "-c" "screenshot ocr"])]
       [:Print {:mod4 true :mod1 true} (action/spawn ["sh" "-c" "screenshot full"])]
       [:Print {:mod4 true :ctrl true :shift true} (action/spawn ["sh" "-c" "screenshot color"])]

       # Window management
       [:q {:mod4 true} (action/close)]
       [:r {:mod4 true} (action/config)]
       [:n {:mod4 true} (action/zoom)]
       [:j {:mod4 true} (action/focus :prev)]
       [:k {:mod4 true} (action/focus :next)]
       [:h {:mod4 true} (action/focus-output)]
       [:l {:mod4 true} (action/focus-output)]
       [:a {:mod4 true} (action/fullscreen)]
       [:b {:mod4 true} (action/swap-main)]
       [:d {:mod4 true} (action/sticky)]
       [:g {:mod4 true} (action/float)]
       [:z {:mod4 true} (action/layout :tile)]
       [:x {:mod4 true} (action/layout :grid)]
       [:s {:mod4 true} (action/layout :scroller)]
       [:c {:mod4 true} (action/layout :monocle)]
       [:l {:mod4 true :shift true} (action/view-tag :next)]
       [:h {:mod4 true :shift true} (action/view-tag :prev)]
       [:equal {:mod4 true} (action/main-ratio 0.05)]
       [:minus {:mod4 true} (action/main-ratio -0.05)]
       [:equal {:mod4 true :shift true} (action/window-ratio 0.05)]
       [:minus {:mod4 true :shift true} (action/window-ratio -0.05)]
       [:Escape {:mod4 true :mod1 true :shift true :ctrl true} (action/passthrough)]
       [:q {:mod4 true :shift true} (action/exit-session)]
       [:0 {:mod4 true} (action/focus-all-tags)]])

(for i 1 10
  (let [keysym (keyword i)]
    (array/push (config :xkb-bindings) [keysym {:mod4 true} (action/focus-tag i)])
    (array/push (config :xkb-bindings) [keysym {:mod4 true :shift true} (action/set-tag i)])))

(set (config :pointer-bindings)
     @[[:left {:mod4 true} (action/pointer-move)]
       [:right {:mod4 true} (action/pointer-resize)]])
