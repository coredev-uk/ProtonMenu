local PANEL = {}

AccessorFunc(PANEL, "p_toggle", "Toggle")

function PANEL:Init()
    local bool = false
    self:SetToggle(bool)
    self:SetWide(50)
    self:SetTall(50)

    local button = vgui.Create("DButton", PANEL)
    button:SetText("")

    function button:DoClick()
        PANEL:GetToggle = !PANEL:GetToggle
    end
end


function PANEL:Paint(w, h)
    if self.GetToggle:
        draw.RoundedBox(5, 0, 0, w, h, PROTON.ui.buttons.positive)
    else 
        draw.RoundedBox(5, 0, 0, w, h, PROTON.ui.buttons.negative)
    end
end