# ScreenLib-Roblox
2023

By: mrjacksonsapien

[1.0 Rules and syntax]

	1.1 - Syntax to get a pixel with coordinates: (screenName)._x_y (eg: myScreen._1_1 -- Will select the pixel at coordinate(1,1));

	1.2 - Index of pixels inside the matrix starts at 1 (not 0 unlike most indexes);
	
	1.3 - Calling functions with pixels values that are non existent within the screen's resolution range will generat errors
	(eg: Calling setPixel and selecting _50_50 in a 25x25 will generate an error. Calling any other functions that will try to draw
	some pixels that are out of bounds will generate an error too.);
	
[2.0 Procedure]

	2.1 - Pixels are 3D parts. Increasing the resolution of the screen will affect the performance of the game since more instances
	are generated. It would have been easier to create the grid with a surfaceUI but it was intended to be 3D models to represent pixels
	in real life. WARNING: Do not try to recreate real-life screen's resolution with this library. It could result into the game or studio
	crashing. The maximum recommended resolution is 100x100 according to my game's performance result. This library is not meant to render
	high resolution screens. A limit has been set for the total amount of pixels generated. If there is an attempt to generate more
	pixels, an error message will be displayed in the output and the screen will not generate. This limit has been set for safety
	measures and avoid game lags. If you simply want to use this library for personnal purpose and have a performant computer, you can change
	the pixels limit to the one wanted but if you want to use this library for public projects, it is recommended to keep the limit at 10000;

	2.2 - This library mostly supports square/cube shaped parts to draw a rectangle screen on the top surface. If any other shapes is used
	such as a ball mesh or any other mesh it will still draw on top of it but as a plane, so it won't cover the specific surface. 
	library can still be used as prefered and be used as billboards if wanted but the drawn surface will always be square shaped;

	2.3 - When the createScreen function is called. It will draw a grid on the x and z axis. It is important to ensure that the surface on
	which the screen is drawn is motionless and at an orientation of Vector3(0, 0, 0). The library does not take in consideration the
	orientation of the instance (part) when drawn. Once the screen has been succesfully drawn, it is possible to move it around and rotate
	it;
	
[3.0 Properties]

	3.1 - The library will set a bunch of attributes to the screen folder when created. Those attributes can be used for further manipulation
	and calculations. To get an attribute of the screen write your screen variable name for example "myScreen" followed by 
	:GetAttribute("AttributeName"). So for example if I would like to get the screenWidth attribute I could write
	myScreen:GetAtttribute("screenWidth") and it would return the screenWidth value that I first initiated. If I set the x value
	to 100 when I created my screen, it will return this value;
	
	{List of attributes}
	
	[Screen attributes]
	
		- screenWidth
		- screenHeight
		- Resolution
		
	[Pixels attributes]
	
		- State
		- RGB
	
[4.0 Public Functions]

	Note: To call a function, you should always use the library itself. Functions can not be called from the screen itself. The selected
	screen or pixels will be given as parameters inside the function.

	4.1 - createScreen(x, y)
		Will create a matrix with the given parameters x and y and draw it on the surface. The screen will take the whole
		space of the top surface of the part (the X and Z Size of the shape) and decide the size of the pixels based on how
		many pixels are desired for the screen. If the X and Z values are not equivalent. The pixels will be stretched one way
		or the other;
		
	4.2 - setPixel(pixel, state, rgbColor)
		Will take the given pixel as an input (with the syntax of the library) and change it's state to the given state value (0 or 1).
		0 will turn the pixel "off", just like in a computer and 1 will turn it on. If the pixel is off, the only possible Color3 value
		is 0, 0, 0. If the pixel is on, it is possible to change it's color. If Color3.fromRGB() value is not given in the 3rd parameter, 
		the default color of the pixel will be 255, 255, 255. Refer to index 1.1 of documentation for selection syntax;
		
	4.3 - clearScreen(screen)
		Will take the given screen folder as a parameter and will clear all of it's content (set all pixel's state to 0 with a for loop);
		
	{Functions that require a minimum resolution for efficient and prettier display}
	
	4.4 - drawLine(from to, rgbColor)
		This function gives the option to draw lines from one set of coordinates to another. The set of coordinates take instances (pixels)
		objects as input values and the program will deconcatenate the x and y values out of it. Refer to index 1.1 of documentation
		for selection syntax;
	
	4.5 - strokeRec(from, to, rgbColor)
		This function will take an first set of coordinates(x, y) and a second one and wil draw the stroke of a square in between.
		The two given coordinates will be used a the corners of the square. (eg: from: 0, 0 to: 50, 50 will take 0,0 as the top left corner
		and 50, 50 as the bottom right corner). This function ONLY takes the instances of the pixels as parameters and will deconcatenate
		the coordinates out of the instance's name (use the library syntax for selecting coordinates). Refer to index 1.1 of documentation
		for selection syntax;

[5.0 Private functions]

	5.1 - The library uses private functions under the public functions such as deconcatenatePixel() to perform some tasks within the library.
	Those functions are not meant to be used by the developer and they are only meant to be used by the functions that can be called
	from the developer. These functions have not been included in the module to make the library more simple to use for developers but it
	is still possible to include them inside the module if needed.

[6.0 Copyright's policy]

	6.1 - Re-publishing the library or any of it's functions or modified content without the owner's aproval is not allowed.
	
	6.2 - Sharing and re-using this library is still allowed as long as it's not claimed to be someone's 
	else creation or property other than the true owner mentionned at the beggining of this documentation after the "By:".
	
	6.3 - This library can be used for public projects and games with the owner's approval and requests.
