/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ProtonMenu: Configuration File
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

PROTON = {
	cmds = {},
	menu = {
		version = "0.5.0",
		panicSound = "ambient/creatures/town_child_scream1.wav"
	},
	esp = {
		colours = {
			-- overheads
			name = Color(0, 191, 255),
			team = Color(0, 191, 255),
			friend = Color(0, 255, 0),
			usergroup = Color(0, 191, 255),
			weapon = Color(0, 191, 255),
			-- end
			box_2d = Color(0, 191, 255),
			edges = Color(255, 255, 255),
			eyetrace = Color(255, 0, 0),
			entities = {
				["murder"] = {
					["mu_knife"] = Color(255, 0, 0), -- Murder Knife - Thrown (Red)
					["weapon_mu_knife"] = Color(255, 0, 0), -- Murder Knife (Red)
					["mu_loot"] = Color(0, 255, 0), -- loot (Green)
					["weapon_mu_magnum"] = Color(0, 0, 255) -- Sheriff Magnum (Blue)
				},
				["darkrp"] = {
					["spawned_money"] = Color(133, 187, 101), -- Money (Dark Green)
					["*printer*"] = Color(255, 223, 0), -- Printers (Gold)
					["*bitminer*"] = Color(127, 127, 127), -- Bitminers (Grey)
					["*cocaine*"] = Color(255, 255, 255), -- Any cocaine scripts (White)
					["*zwf*"] = Color(29, 82, 21), -- Zeros Weed Farm (Dark Green)
					["*zmlab*"] = Color(102, 164, 186), -- Zeros Meth Lab (Light Blue)
					["*zrms*"] = Color(102, 34, 0), -- Zeros Retro Mining System (Brown)
					["*zbl*"] = Color(255, 255, 0), -- Zeros Bio Lab (Yellow)
					["zvm_machine"] = Color(255, 0, 0) -- Zeros Vending Machine (Red)
				}
			}
		},
		toggles = {
			esp = true,
			entityesp = true,
			name = true,
			team = true,
			weapon = true,
			usergroup = true,
			appendnicks = false,
			friends = true,
			-- overhead ends
			-- visuals
			eyetrace = true,
			edges = true,
			hparmcolumn = true,
			box_2d = true, -- 2D Box
			-- misc esp
			onlinestaff = true,
			entname = true
		},
		friendlist = {
			"STEAM_0:1:49736199"
		},
		staffGroupList = {
			["trialmoderator"] = true,
			["moderator"] = true,
			["admin"] = true,
			["mod"] = true
		}
	},
	exploits = {
		["unisec"] = function()
			for k, v in pairs(ents.FindInSphere(LocalPlayer():GetPos(), 500)) do
				if v:GetClass() ~= "uni_keypad" then continue end
				net.Start("usec_paid_door")
				net.WriteEntity(v)
				net.WriteBool(true)
				net.SendToServer()
			end
		end,

		["tipjar"] = function()
			for i = 0, 1000 do
				for k, v in pairs(ents.FindInSphere( LocalPlayer():GetPos(), 100)) do
					if v:GetClass() ~= "darkrp_tip_jar" then continue end
					net.Start("DarkRP_TipJarDonate", true)
						net.WriteEntity(v)
						net.WriteUInt(0, 32)
					net.SendToServer()
				end
			end
		end,

		["vender"] = function()
			local ent = LocalPlayer():GetEyeTrace().Entity
			local tbl = {}
			for k, v in pairs(ent.Products) do
				tbl[k] = 17e307
			end
			PrintTable(tbl)
			local data =  util.TableToJSON(tbl)
			local dataCompressed = util.Compress(data)
			net.Start("zvm_Machine_Buy_Request")
			net.WriteEntity(ent)
			net.WriteUInt(#dataCompressed, 16)
			net.WriteData(dataCompressed, #dataCompressed)
			net.SendToServer()
		end,

		["what"] = function()
			local ent = LocalPlayer():GetEyeTrace().Entity
			if !ent || !ent:IsValid() then return end
			print(ent:GetClass())
		end,

		["nutwep"] = function(cmd, args)
			if !args[1] then return end
			net.Start("adminSpawnItem")
			net.WriteString(args[1])
			net.SendToServer()
		end,

		["mafiadrag"] = function(cmd, args)
			netstream.Start("PIMRunOption", "Drag Player")
		end,

		["mafiadrop"] = function(cmd, args)
			netstream.Start("PIMRunOption", "Stop Dragging")
		end,

		["mafiacuff"] = function(cmd, args)
			netstream.Start("PIMRunOption", "Cuff")
		end,

		["mafiauncuff"] = function(cmd, args)
			netstream.Start("PIMRunOption", "Uncuff")
		end,

		["mafiaincar"] = function(cmd, args)
			netstream.Start("PIMRunOption", "Put in vehicle")
		end,

		["mafiacar"] = function(cmd, args)
			local vehicles = list.Get("simfphys_vehicles")
			local want = args[1] || table.GetFirstKey(vehicles)
			local col = Color(args[2] || 255, args[3] || 255, args[4] || 255)
			local data = {color = col}
			netstream.Start("PlayerSpawnRemoteVehicle", want, data)
		end,

		["fallenrpmenu"] = function(cmd, args)
			net.Receivers["cmds.openmenu"]()
		end
	},
	ui = {
		primary = Color(40, 44, 52), --#282C34
		accent = Color(49, 54, 94), --#31365E
		accent2 = Color(178, 201, 237), --#B2C9ED

		background = {
			column = Color(98, 108, 128), --#626C80
			title = Color(147, 162, 191) --#93A2BF
		},

		buttons = {
			positive = Color(0, 255, 0),
			negative = Color(255, 0, 0),
			close = Color(139, 0, 0), --#8b0000
			closehover = Color(255, 0, 0) --#FF0000
		},

		txt = {
			white = Color(255, 255, 255), -- #FFFFFF
			black = Color(0, 0, 0) --#000000
		}
	}
}

if file.Exists("PROTON.json", "DATA") then
	PROTON = util.JSONToTable(file.Read("PROTON.json", "DATA"))
else
	file.Write("PROTON.json", util.TableToJSON(PROTON), true)
end

concommand.Remove("proton")
concommand.Add("proton", function(ply, cmd, args)
    if !args[1] then
        CPrint(1, "Command", "No command specified")
        return
    end

    if PROTON.exploits[args[1]] then
        PROTON.exploits[args[1]](cmd, args)
        CPrint(1, "Command", "Executing command " .. cmd)
        return
    elseif PROTON.cmds[args[1]] then
        PROTON.cmds[args[1]](cmd, args)
        CPrint(1, "Command", "Executing command " .. cmd)
        return
    end
end)

-- concommand.Run("proton")