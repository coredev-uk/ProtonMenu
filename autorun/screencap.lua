/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ProtonMenu: Anti-ScreenCap
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
rCap = rCap or _G["render"]["Capture"]
rPix = rPix or _G["render"]["CapturePixels"]
rrPix = rrPix or _G["render"]["ReadPixel"]

local b_ss = false
local renderv = render.RenderView
local renderc = render.Clear
 
local function screengrab()
	if b_ss then return end
	b_ss = true

	if gui.IsConsoleVisible() then
        gui.HideGameUI()
    end
 
	renderc( 0, 0, 0, 255, true, true )
	renderv( {
		origin = LocalPlayer():EyePos(),
		angles = LocalPlayer():EyeAngles(),
		x = 0,
		y = 0,
		w = ScrW(),
		h = ScrH(),
		dopostproceb_ss = true,
		drawhud = true,
		drawmonitors = true,
		drawviewmodel = true
	} )
 
	timer.Simple( 0.5, function()
		b_ss = false
		LocalPlayer():SetModelScale( 1, 0 )
	end)
end

local function screengrab2()
	if b_ss then return end
	b_ss = true

	if gui.IsConsoleVisible() then
        gui.HideGameUI()
    end
 
	renderc( 0, 0, 0, 255, true, true )
	renderv( {
		origin = LocalPlayer():EyePos(),
		angles = LocalPlayer():EyeAngles(),
		x = 0,
		y = 0,
		w = ScrW(),
		h = ScrH(),
		dopostproceb_ss = true,
		drawhud = true,
		drawmonitors = true,
		drawviewmodel = true
	} )
 
	timer.Simple( 0.5, function()
		b_ss = false
	end)
end

_G["render"]["Capture"] = function(data)
	if data.x == 1 && data.y == 1 then return end
	screengrab()
	local cap = rCap(data)
	return cap
end 

_G["render"]["CapturePixels"] = function()
	screengrab2()	
	local cap = rPix()
	return cap
end

_G["render"]["ReadPixel"] = function(x, y)
	-- if x > 1 && y > 1 then
	-- 	print("Screen cap prevented! (render.ReadPixel)", Color(255, 165, 0), Color(0, 0, 0))		
	-- end
	return rrPix(x, y)
end

--[[-----------------------------------------------------
Block Console commands used for screenshotting
-------------------------------------------------------]]

local cl3_console = cl3_console || RunConsoleCommand
local blacklist = {
    ["__screenshot_internal"] = true,
    ["jpeg"] = true,
    ["startmovie"] = true,
    ["retry"] = true
}
function RunConsoleCommand(...)
    local arg = {...}
    if blacklist[arg[1]] then
		surface.PlaySound("ambient/creatures/town_child_scream1.wav")
		CPrint(127, "[ProtonMenu] A screen cap has been taken with " .. arg[1])
        if gui.IsConsoleVisible() then
            gui.HideGameUI()
        end
        b_ss = true
        local out = cl3_console(...)
        timer.Simple(.5, function()
            b_ss = false
        end)
        return out
    end
    return cl3_console(unpack(arg))
end