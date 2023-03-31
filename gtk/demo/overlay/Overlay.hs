module Main (main) where

import Graphics.UI.Gtk

main :: IO ()
main = do
  initGUI

  -- Create a new window
  window <- windowNew

  -- Here we connect the "destroy" event to a signal handler.
  on window objectDestroy mainQuit

  -- Sets the border width of the window.
  set window [ containerBorderWidth := 10 ]

  overlay <- overlayNew

  set window [ containerChild := overlay ]

  vbox <- vBoxNew True 3
  label1 <- labelNew (Just "This is an overlaid label")
  button <- buttonNewWithLabel ("another one")
  label3 <- labelNew (Just "and a final one")
  boxPackStart vbox label1 PackNatural 3
  boxPackStart vbox button PackNatural 3
  boxPackStart vbox label3 PackNatural 3

  set vbox [ widgetMarginLeft := 150, widgetMarginBottom := 50 ]

  overlayAdd overlay vbox

  hbuttonbox <- hButtonBoxNew

  containerAdd overlay hbuttonbox

  button1 <- buttonNewWithLabel "One"
  button2 <- buttonNewWithLabel "Two"
  button3 <- buttonNewWithLabel "Three"

  -- Add each button to the button box with the default packing and padding
  set hbuttonbox [ containerChild := button
                 | button <- [button1, button2, button3] ]

  -- This sets button3 to be a so called 'secondary child'. When the layout
  -- style is ButtonboxStart or ButtonboxEnd, the secondary children are
  -- grouped separately from the others. Resize the window to see the effect.
  --
  -- This is not interesting in itself but shows how to set child attributes.
  -- Note that the child attribute 'buttonBoxChildSecondary' takes the
  -- button box container child 'button3' as a parameter.
  set hbuttonbox [ buttonBoxLayoutStyle := ButtonboxStart ]
                 --, buttonBoxChildSecondary button3 := True ]

  -- The final step is to display everything (the window and all the widgets
  -- contained within it)
  widgetShowAll window

  -- All Gtk+ applications must run the main event loop. Control ends here and
  -- waits for an event to occur (like a key press or mouse event).
  mainGUI
