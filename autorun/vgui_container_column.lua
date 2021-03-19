local PANEL = {}

function PANEL:Init()
    self:SetTall(100%)
end

function PANEL:Paint(w, h)
    draw.RoundedBox(5, 0, 0, w, h, PROTON.ui.background.column)
    draw.RoundedBoxEx(5, 0, 0, w, 10, PROTON.ui.background.title, true, true)
end

vgui.Register("ProUI.Container.Column", PANEL)