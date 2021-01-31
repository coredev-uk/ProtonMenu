/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ProtonMenu: ESP
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

local function DrawEntities()
	if b_ss || !PROTON.esp.toggles.entityesp then return end
	for this, col in pairs(PROTON.esp.colours.entities[engine.ActiveGamemode()] or {}) do
		for k, v in pairs(ents.FindByClass(this)) do
			if v:IsDormant() then continue end
			render.DrawWireframeBox(v:GetPos(), v:GetAngles(), v:OBBMins(), v:OBBMaxs(), col, false)
		end
	end
end

local function DrawPlayers()
	if b_ss || !PROTON.esp.toggles.esp then return end
	for k, v in next, player.GetAll() do
		if v:IsDormant() || !v:Alive() || v == LocalPlayer() then continue end

		local ent = FindMetaTable("Entity")
		local vec = FindMetaTable("Vector")
		local ply = LocalPlayer()
		local pos = ent.GetPos(v)
		local poss = pos + Vector(0, 0, 70)
		local txtPos = vec.ToScreen(pos + Vector(0, 0, 85))
		local pos = vec.ToScreen(pos)
		local poss = vec.ToScreen(poss)
		local h = pos.y - poss.y
		local w = h / 2

		-- Player Name Overheads
		if PROTON.esp.toggles.name then
			draw.SimpleText(PROTON.GetName(v), "Trebuchet18", txtPos.x, txtPos.y - 45, PROTON.FriendColor(v), 1, 1)
		end

		-- Player Team Overheads
		if PROTON.esp.toggles.team && (DarkRP || engine.ActiveGamemode() == "hideandseek") then
			draw.SimpleText(team.GetName(v:Team()), "Trebuchet18", txtPos.x, txtPos.y - 30, PROTON.TeamColor(v), 1, 1)
		end

		-- Player Usergroup Overheads
		if PROTON.esp.toggles.usergroup then
			draw.SimpleText(PROTON.GetUserGroup(v), "Trebuchet18", txtPos.x, txtPos.y - 15, PROTON.esp.colours.usergroup, 1, 1)
		end

		-- Player Active Weapon Overheads
		if PROTON.esp.toggles.weapon then
			draw.SimpleText(PROTON.GetActiveWeapon(v), "Trebuchet18", txtPos.x, txtPos.y, PROTON.esp.colours.weapon, 1, 1)
		end

		-- 2D Box
		if PROTON.esp.toggles.box_2d then
			surface.SetDrawColor(PROTON.esp.colours.box_2d)
			surface.DrawOutlinedRect(pos.x - w / 2, pos.y - h, w, h)
		end

		-- Player 2D Box Edges
		if PROTON.esp.toggles.edges then
			draw.RoundedBox(0, pos.x - w / 2, pos.y - h, 5, h / 10, PROTON.esp.colours.edges)
			draw.RoundedBox(0, pos.x - w / 2, pos.y - h,  h / 10, 5, PROTON.esp.colours.edges)
			draw.RoundedBox(0, pos.x + w / 2 - 5, pos.y - h, 5, h / 10, PROTON.esp.colours.edges)
			draw.RoundedBox(0, pos.x + w / 2 - h / 10, pos.y - h,  h / 10, 5, PROTON.esp.colours.edges)
			draw.RoundedBox(0, pos.x - w / 2, pos.y - h / 10, 5, h / 10, PROTON.esp.colours.edges)
			draw.RoundedBox(0, pos.x - w / 2, pos.y - 5,  h / 10, 5, PROTON.esp.colours.edges)
			draw.RoundedBox(0, pos.x + w / 2 - 5, pos.y - h / 10, 5, h / 10, PROTON.esp.colours.edges)
			draw.RoundedBox(0, pos.x + w / 2 - h / 10, pos.y - 5,  h / 10, 5, PROTON.esp.colours.edges)
		end

		-- Player 2D Box HP and Armour Columns
		if PROTON.esp.toggles.hparmcolumn then
			local health = math.Clamp(v:Health(), 0, 100)
			local armor = math.Clamp(v:Armor(), 0, 100)
			local hpCol = HSVToColor( health / 100 * 120, 1, 1 )
			local armorCol = Color(0, armor / 100 * 100, armor / 100 * 255)
			local diffHp = h - health * h / 100
			local diffArmor = h - armor * h / 100

			draw.RoundedBox(0, pos.x - w / 2 - 10, pos.y - h + diffHp, 5, h / 100 * health, hpCol)
			draw.RoundedBox(0, pos.x + w / 2 + 5, pos.y - h + diffArmor, 5, h / 100 * armor, armorCol)
			draw.SimpleText(v:Health() .. "%", "Default", pos.x - w / 2 - 5, pos.y - h - 6, Color(255,255,255,255), 1, 1)
			draw.SimpleText(v:Armor() .. "%", "Default", pos.x + w / 2, pos.y - h - 6, Color(255,255,255,255), 1, 1)
		end

		-- Show Entity Name when looking at it
		if PROTON.esp.toggles.entname then
			local traceinfo = ply:GetEyeTrace()
			if traceinfo then
				if IsEntity( traceinfo.Entity ) && traceinfo.HitNonWorld then
					if traceinfo.Entity:GetPos():Distance(ply:GetPos()) > 500 then continue end
					draw.SimpleText(traceinfo.Entity:GetClass(), "Default", ScrW() / 2, ScrH() / 2 + 10, Color(255,255,255), 1, 1)
				end
			end
		end
		
	end
end

local function DrawEyeTrace()
	if b_ss || !PROTON.esp.toggles.eyetrace then return end
	for k, v in pairs(player.GetAll()) do
		if v:IsDormant() || !v:Alive() || v == LocalPlayer() then continue end
		render.SetMaterial(Material("color_ignorez"))
		if v == LocalPlayer() then continue end
		if LocalPlayer():GetPos():Distance(v:GetPos()) > 2500 then continue end
		local tr = v:GetEyeTrace()
		render.DrawBeam( tr.StartPos, tr.HitPos, 2, 1, 1, PROTON.esp.colours.eyetrace)
		render.DrawWireframeSphere( tr.HitPos, 3, 7, 7, PROTON.esp.colours.eyetrace)
	end
end

--[[-----------------------------------------------------
Online Staff List
-------------------------------------------------------]]
local function DrawStaff()
	if bss || !PROTON.esp.toggles.onlinestaff then return end
	for k, v in next, player.GetHumans() do

		local staff = {}
		for k, v in pairs (player.GetAll()) do
			if !PROTON.IsStaff(v) then continue end
			table.insert(staff, v)
		end

		local staffwide = {}
		for k, v in pairs(staff) do
			local no = surface.GetTextSize(string.format("%s (%s)", v:Nick(), v:GetUserGroup()))
			table.insert(staffwide, no)
		end

		table.sort(staffwide)
		local widthstaff = math.Clamp((staffwide[#staffwide]), 0, 250)

		draw.RoundedBox(5, 0, ScrH() * 0.025, staffwide[#staffwide], 20, PROTON.ui.accent, false, false, true, true) -- Title Box
		draw.SimpleText("Online Staff", "Trebuchet18", 5, (ScrH() * 0.026), Color(255, 255, 255)) -- Title Text
		draw.RoundedBox(5, 0, ScrH() * 0.05, staffwide[#staffwide], #staff * 20, PROTON.ui.accent, true, true, false, false) -- Text Box

		for k, v in pairs (staff) do
			draw.SimpleText(string.format("%s (%s)", v:Nick(), v:GetUserGroup()), "Trebuchet18", 5, (ScrH() * 0.05) + (k - 1) * 20, PROTON.ui.txt.white)
		end
	end
end

hook.Add("PreDrawEffects", "DrawEntities", DrawEntities)
hook.Add("HUDPaint", "DrawPlayers", DrawPlayers)
hook.Add("PreDrawEffects", "DrawEyeTrace", DrawEyeTrace)
hook.Add("HUDPaint", "DrawStaff", DrawStaff)