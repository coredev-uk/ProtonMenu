local PANEL = {}

AccessorFunc(PANEL, "p_version", "Version")

function PANEL:Init()
    self:SetVersion("placeholder")
end

function PANEL:Paint(w, h)
    draw.RoundedBoxEx(5, 0, 0, w, h, PROTON.ui.accent, false, false, true, true)
    draw.SimpleText("Version: "..self:GetVersion(), "PROTON.fonts.menu.title.20", 10, h, PROTON.ui.txt.white)
end

vgui.Register("ProUI.Container.Footer", PANEL)