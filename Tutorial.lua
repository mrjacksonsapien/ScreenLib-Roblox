-- For more details, check out the lib module script or the documentation
-- Always use "ScreenLib" to access the functions
-- To get a better visualization you can run the game and watch the screen change over time

local ScreenLib = require(script.Parent.lib) -- Import the lib module with it's current path

-- Example

-- 1. Create your own screen with x and y values followed by the target object to be used a draw surface
-- In this case I created a 10 by 10 screen and used the baseplate as a surface to draw my screen
-- Be careful! Increasing the resolution of the grid might affect the performance of the game since each pixel is 3D model and not a UI object
-- When you create your screen remember to always keep the object you wanna draw on with a rotation of 0 and motionless on all axis, you can make it move or rotate later.

local myScreen = ScreenLib.createScreen(10, 10, workspace.Baseplate)

-- 2. You can use the setPixel function to select a pixel and change it's state to 0 (off) and 1 (on).
-- You can also change it's color when it is turned on (optional) else the default color will be white for 1 and black for 0

-- Notes: 
	--The index of the pixels coordinates start at 1 and not 0
	--The coordinates need to be between the range you gave for your own screen (eg: If I create a 10 by 10 I cannot select pixel _11_11 since it does not exist)

-- Here we started by selecting the first pixel of myScreen with the following syntax (_x_y) and setting it's state to 1 (on)
-- We could also add a rgb value parameter for it's color but in this case we'll start with that

ScreenLib.setPixel(myScreen._1_1, 1)

-- 3. Once we're done drawing we can reset our screen by calling the follow function. This is the easiest way to clear the screen

wait(2) -- Small delay so we can notice our previous modifications
ScreenLib.clearScreen(myScreen) -- Here we used myScreen as a parameter of what screen we want to clear

wait(2)

-- 4. Now let's try again to set the same pixel again but with a different color
ScreenLib.setPixel(myScreen._1_1, 1, Color3.fromRGB(255, 0, 0)) -- We added a new parameter that gets the Color3 class to pick a specific rgb color

-- The screen only accepts rgb values using Color3.fromRGB()

-- 5. In this case here's a slighty more complicated way to clear our screen since we only need to turn off this specific pixel
-- We will use the setPixel function again but this time we'll simply just change the state of the pixel to 0 so it turns off

wait(2)

ScreenLib.setPixel(myScreen._1_1, 0)

wait(2)

-- 6. Now it's time to make things more complicated. Here's a way to select many pixels at the same time.
-- In our case, the pixels are selected by their name so the best way to select multiple pixels is by using concatenation
-- Concatenation: Means taking multiple strings and/or numbers and match them together to create a new string
-- We will also use the metadata attributes assigned to the screen. In this case we'll use the screenWidth

-- In this case we'll draw a row with a for loop
-- If you do not understand how a for loop works I would recommend reading about it in the Roblox Documentation or any other programming languages documentations

for i = 1, myScreen:GetAttribute("screenWidth") do
	local pixel = "_"..i.."_1" -- Here is the concatenation where every iteration we select is a new coordinate. Expected output: "_i_1"
	ScreenLib.setPixel(myScreen[pixel], 1) -- Here we use the brackets "[]" to select a child by it's name
end

wait(2)

-- Here we can draw a second row
for i = 1, myScreen:GetAttribute("screenWidth") do
	local pixel = "_"..i.."_3" -- Notice we changed the last number which is the row number or the Y value of the coordinates
	ScreenLib.setPixel(myScreen[pixel], 1)
end

wait(2)

-- And so it goes on for the rest
for i = 1, myScreen:GetAttribute("screenWidth") do
	local pixel = "_"..i.."_5"
	ScreenLib.setPixel(myScreen[pixel], 1)
end

for i = 1, myScreen:GetAttribute("screenWidth") do
	local pixel = "_"..i.."_7"
	ScreenLib.setPixel(myScreen[pixel], 1)
end

for i = 1, myScreen:GetAttribute("screenWidth") do
	local pixel = "_"..i.."_9"
	ScreenLib.setPixel(myScreen[pixel], 1)
end

wait(2)

ScreenLib.clearScreen(myScreen)

--[[

Here we are at the end of the tutorial!

This lib is still in development and I will later on include some new pre-built functions that could be used. If you are experimented
enough in programming, I encourage you to create your own functions inside the lib, else I would recommend you to stick with the basic
functions I created and make your own out of it without touching the lib module script.

Note: This tutorial only teaches the primary functions of the lib such as createScreen, setPixel and clearScreen. Other functions
can be tested. For any information please refer to the documentation.

]]
