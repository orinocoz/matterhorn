module Draw.NotifyPrefs
  ( drawNotifyPrefs
  )
where

import Prelude ()
import Prelude.MH

import Brick
import Brick.Widgets.Border
import Brick.Widgets.Center
import Brick.Forms (renderForm)
import Data.List (intersperse)

import Draw.Util (renderKeybindingHelp)
import Types
import Types.KeyEvents
import Themes

drawNotifyPrefs :: ChatState -> Widget Name
drawNotifyPrefs st =
    let Just form = st^.csNotifyPrefs
        label = forceAttr clientEmphAttr $ str "Notification Preferences"
        formKeys = withDefAttr clientEmphAttr <$> txt <$> ["Tab", "BackTab"]
        bindings = vBox $ hCenter <$> [ renderKeybindingHelp "Save" [FormSubmitEvent] <+> txt "  " <+>
                                        renderKeybindingHelp "Cancel" [CancelEvent]
                                      , hBox ((intersperse (txt "/") formKeys) <> [txt (":Cycle form fields")])
                                      , hBox [withDefAttr clientEmphAttr $ txt "Space", txt ":Toggle form field"]
                                      ]
    in centerLayer $
       vLimit 25 $
       hLimit 39 $
       joinBorders $
       borderWithLabel label $
       (padAll 1 $ renderForm form) <=> hBorder <=> bindings
