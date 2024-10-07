#  Layout notes

-- March 2, 2024
max size for ipad keys: 128pt

max size for phone is basically take geometry reader of device width and divide by 4.

height is basically the width, with exception of non-square keys, grid spaces.


Aspect ratio for the display is 2.19-ish. Fills entire area on touch-id phones, leaves room for some branding, skewy for iphone-X+ later phones.

Do not waste time right now on horizontal layout. Do that after shipping v1

-- March 5, 2024
font ideas: 
  Routed Gothic, 
  Routed Gothic Narrow, 
  Routed Gothic Wide,
  Jetbrains Mono
  Ticket Mono OT
  ThreeSix 01 Mono Pro
  Magda Clean Mono OT
  Isonorm Monospaced Pro
  GT Maru Mono
  ABC Diatype Plus Variable


LEDGlowView font settings for:
            DSEG7Classic-Regular -> largeFontSize: UIDevice.isTablet ? 64 : 32,
                                    smallFontSize: UIDevice.isTablet ? 24 : 16)

            
Using Dave Delong's MathParser swift library for formatting strings of expressions to Math operations. NICE, will have to thank him.


-- March 6, 2024
I implemented a fontpicker where you can choose from among the many DSEG7/14 fonts available.
Going to eventually simplfy it to where the style of the display is chosen for you.

Emulate real world calc displays for red, green and blue LED screens. Each one has their own specific properties. Even though I have all the fonts, i want the interface to be simple. The display theme will then call on specific fonts to recreate that specific look for 'BlueDisplay', 'Red Display', and 'Green Display'. Each LED historically had their own unique qualities. Even the blurs are different for the different LED technology.

Red, Green, Blue. Easy skewy switcher toggle under the top panel view. Slide to reveal. 

The goal is for people to say, "I want that calculator."

Start with two themes and show 5 more as IAP. Make it juicy, play the sounds of the IAP versions when on that style with an overlay paywall blocker. 

Then you can focus on creating themes independent of the logic and keep on adding down the road and improving the value prop. Include metal rendering, 3d etc. Logic stays the same.

Open panel and enable the theme switching ui. Possible indicate rounded rect glowing frame borders around the calc view (display + keys) and show a gesture to swipe "<->" between the themes.

Red would be thin DSEG with wood panel
Bleu would be moms calc printer with light plastic and gloss black, angled regular DSEG
Green would be my sharp Else 8002 blue bg, Bold Mini DSEG
Orange/Yellow would be Omron round keys (different font)
White would be Teenage Engineering keys (different font)

Each theme needs its own buttonView and buttonsView, with bindings to the model!!!! So important.

QUESTION: How can I incorporate light and dark mode for each theme?


The font chooser is working great. Ultimately I won't incorporate it verbatim. I need to create the R/G/B selector and apply the themes accordingly with my theme choose.
