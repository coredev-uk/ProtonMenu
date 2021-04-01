/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ProtonMenu: Functions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

--[[-----------------------------------------------------
Is The Player A Friend?
-------------------------------------------------------]]
function PROTON.IsFriend(ply)
	if ply:GetFriendStatus() == "friend" || table.HasValue(PROTON.esp.friendlist, ply:SteamID()) || table.HasValue(PROTON.esp.friendlist, ply:SteamID64()) then
		return true
	else
		return false
	end
end

--[[-----------------------------------------------------
Is The Player Staff?
-------------------------------------------------------]]
function PROTON.IsStaff(ply)
	if ply:IsAdmin() || ply:IsSuperAdmin() || PROTON.esp.staffGroupList[ply] then
		return true
	else
		for k, v in pairs(PROTON.esp.staffGroupList) do
			if string.find(ply:GetUserGroup(), k) then
				return true
			else
				return false
			end
		end
	end
end

--[[-----------------------------------------------------
Append Nicknames
-------------------------------------------------------]]
function PROTON.GetName(ply)
    if ply:Nick() == nil or ply:Nick() == "" then return "" end
    if PROTON.esp.toggles.appendnicks && PROTON.IsFriend(ply) then
        local name = ply.steamNick
        return name
    else
        local name = ply:Nick() .. (ply.steamNick && " (" .. ply.steamNick .. ")" || "")
        return name
    end
    -- Steam Nick Name Fetch
    local name = ply:Nick()
    if !ply.steamNick then
        steamworks.RequestPlayerInfo(ply:SteamID64(), function(name)
            ply.steamNick = name
        end)
    end
end

--[[-----------------------------------------------------
Job Colour
-------------------------------------------------------]]
function PROTON.TeamColor(ply)
    if engine.ActiveGamemode() == "hideandseek" or engine.ActiveGamemode() == "terrortown" or engine.ActiveGamemode() == "murder" then
        local col = team.GetColor(ply:Team())
        return col
    else
        local col = PROTON.esp.colours.team
        return col
    end
end

--[[-----------------------------------------------------
Friend Name Colour
-------------------------------------------------------]]
function PROTON.FriendColor(ply)
    if PROTON.esp.toggles.friends && PROTON.IsFriend(ply) then
        local col = PROTON.esp.colours.friend
        return col
    else
        local col = PROTON.esp.colours.name
        return col
    end
end

--[[-----------------------------------------------------
Players Active Weapon
-------------------------------------------------------]]
function PROTON.GetActiveWeapon(ply)
    local wep = ply:GetActiveWeapon()
    if !IsValid(wep) then
        return ""
    else
        return wep:GetClass()
    end
end

--[[-----------------------------------------------------
Player Usergroup
-------------------------------------------------------]]
function PROTON.GetUserGroup(ply)
    if PROTON.IsStaff(ply) then
        return (string.format("%s - [STAFF]", ply:GetUserGroup()))
    else
        return ply:GetUserGroup()
    end
end

--[[-----------------------------------------------------
AddCommand
-------------------------------------------------------]]
function PROTON:AddCommand(cmd, args)
    table.insert(PROTON.cmds, cmd, args)
end