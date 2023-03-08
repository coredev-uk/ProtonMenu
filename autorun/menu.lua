for i=1, 45 do
	surface.CreateFont("PROTON.fonts.menu."..i, {
		font = "Montserrat",
		size = i,
	})

	surface.CreateFont("PROTON.fonts.menu.light."..i, {
		font = "Montserrat Light",
		size = i,
	})

	surface.CreateFont("PROTON.fonts.menu.title."..i, {
		font = "Montserrat",
		size = i,
		bold = true,
	})
end

-- PROTON.AddCommand("menu", function()
-- 	-- local menu
-- 	-- if menu then
-- 	-- 	menu:Remove()
-- 	-- else
-- 	-- 	menu = vgui.Create("ProUI.Container")
-- 	-- 	menu:SetPage("ESP Configuration")
-- 	-- end
--     print("menu")
-- end)