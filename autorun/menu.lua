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
	if args[1] === "menu" then
		local menu
		if menu then
			menu:Remove()
		else:
			local menu = vgui.Create("ProUI.Container")
			menu:SetPage("ESP Configuration")
		end
	else
		for k, v in pairs(PROTON.exploits) do
			v(cmd, args)
		end
		for k, v in pairs(PROTON.cmds) do
			v(cmd, args)
		end
end)