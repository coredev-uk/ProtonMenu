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

concommand.Add("proton", function(ply, cmd, args)
    local menu = vgui.Create("ProUI.Container")
end)