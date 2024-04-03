-- Library

local LIB_NAME = "ScreenLIB"

local module = {}

local pixels_limit = 10000

if pixels_limit > 10000 then
	warn("["..LIB_NAME.."] WARNING: Pixel limit is higher than recommended value.")
end

function module.createScreen(x, y, obj)
	if x * y > pixels_limit then
		warn("["..LIB_NAME.."] ERROR: Total amount of pixels over limit. Can not continue generation.")
	elseif x < 0 or y < 0 then
		warn("["..LIB_NAME.."] ERROR: Can not use negative numbers for screen generation.")
	else
		local screen = obj
		local screenX = screen.Size.X
		local screenY = screen.Size.Z

		local pixels = Instance.new("Folder", screen)
		pixels.Name = "ScreenLIB_"..screen.Name.."_screen"
		
		print("["..LIB_NAME.."] Screen folder created.")
		
		pixels:SetAttribute("Type", "Screen")
		pixels:SetAttribute("screenWidth", x)
		pixels:SetAttribute("screenHeight", y)
		pixels:SetAttribute("Resolution", x * y)
		
		local pixelX = screenX / x
		local pixelY = screenY / y
		
		local pixeltmp = Instance.new("Part")
		pixeltmp.Size = Vector3.new(pixelX, 0.001, pixelY)
		pixeltmp.Material = Enum.Material.Neon
		pixeltmp.Locked = true
		pixeltmp.Anchored = true

		local screenOrigin = screen.Position + Vector3.new(screen.Size.X / 2 - pixeltmp.Size.X / 2, screen.Size.Y/2 + pixeltmp.Size.Y * 10, screen.Size.Z / 2 - pixeltmp.Size.Z / 2)
		
		local pixelsCount = 0

		for i = 1, x do
			for j = 1, y do
				local pixel = pixeltmp:Clone()
				pixel.Size = pixeltmp.Size
				pixel.Position = screenOrigin - Vector3.new(pixelX * j - pixelX, 0, pixelY * i - pixelY)
				pixelsCount = pixelsCount + 1
				pixel.Name = "_"..j.."_"..i

				pixel:SetAttribute("State", 0)
				pixel:SetAttribute("RGB", pixel.Color)

				pixel.Parent = pixels

				local weld = Instance.new("WeldConstraint", pixel)
				weld.Part0 = pixel
				weld.Part1 = screen
			end
		end
		print("["..LIB_NAME.."] Screen ready for drawing.")

		return pixels
	end
end

function module.setPixel(pixel, state, rgbColor)
	if pixel:isA("Part") then
		if state == 1 then
			if rgbColor then
				pixel.Color = rgbColor
				pixel.Transparency = 0.5
			else
				pixel.Color = Color3.fromRGB(255, 255, 255)
				pixel.Transparency = 0.5
			end
		elseif state == 0 then
			pixel.Color = Color3.fromRGB(0, 0, 0)
			pixel.Transparency = 0
		end
		pixel:SetAttribute("State", state)
		pixel:SetAttribute("RGB", pixel.Color)
	end
end

function module.clearScreen(screen)
	for i, v in pairs(screen:GetChildren()) do
		if v:IsA("Part") then
			module.setPixel(v, 0)
		end
	end
end

function module.drawLine(from, to, rgbColor)
	local x1, y1 = deconcatenatePixel(from)
	local x2, y2 = deconcatenatePixel(to)

	local width = math.abs(x2 - x1)
	local height = math.abs(y2 - y1)

	local xStep = (x2 > x1) and 1 or -1
	local yStep = (y2 > y1) and 1 or -1

	local err = width - height

	while true do
		local pixelName = "_" .. x1 .. "_" .. y1
		local pixel = from.Parent[pixelName]
		module.setPixel(pixel, 1, rgbColor)

		if x1 == x2 and y1 == y2 then
			break
		end

		local err2 = err * 2

		if err2 > -height then
			err = err - height
			x1 = x1 + xStep
		end

		if err2 < width then
			err = err + width
			y1 = y1 + yStep
		end
	end
end

function module.strokeRec(from, to, rgbColor)
	local x1, y1 = deconcatenatePixel(from)
	local x2, y2 = deconcatenatePixel(to)

	local minX, maxX = math.min(x1, x2), math.max(x1, x2)
	local minY, maxY = math.min(y1, y2), math.max(y1, y2)

	local width = maxX - minX
	local height = maxY - minY

	for i = 0, width do
		local xline1 = "_" .. (minX + i) .. "_" .. minY
		local xline2 = "_" .. (minX + i) .. "_" .. maxY

		module.setPixel(from.Parent[xline1], 1, rgbColor)
		module.setPixel(from.Parent[xline2], 1, rgbColor)
	end

	for j = 0, height do
		local yline1 = "_" .. minX .. "_" .. (minY + j)
		local yline2 = "_" .. maxX .. "_" .. (minY + j)

		module.setPixel(from.Parent[yline1], 1, rgbColor)
		module.setPixel(from.Parent[yline2], 1, rgbColor)
	end
end


function module.fillRec(from, to, RGBcolor)
	local x1, y1 = deconcatenatePixel(from)
	local x2, y2 = deconcatenatePixel(to)

	local minX, maxX = math.min(x1, x2), math.max(x1, x2)
	local minY, maxY = math.min(y1, y2), math.max(y1, y2)

	for x = minX, maxX do
		for y = minY, maxY do
			local pixelKey = "_" .. x .. "_" .. y
			module.setPixel(from.Parent[pixelKey], 1, RGBcolor)
		end
	end
end



--------- Private functions (Not in module) ---------------


function deconcatenatePixel(pixel)
	local pixelName = pixel.Name

	local underscore1 = string.find(pixelName, "_")
	local underscore2 = string.find(pixelName, "_", underscore1 + 1)

	local x = tonumber(string.sub(pixelName, underscore1 + 1, underscore2 - 1))
	local y = tonumber(string.sub(pixelName, underscore2 + 1))

	return x, y
end


print(LIB_NAME.." has been successfuly imported.")

return module
