local PANEL = {}

AccessorFunc(PANEL, "p_toggle", "Toggle")

function PANEL:Init()
    local bool = false
    self:SetToggle(bool)

    local button = vgui.Create("DButton", PANEL)
    button:SetText("")
    button:Dock(RIGHT)
    button:SetWide(50)
    button:SetTall(50)

    function button:DoClick()
        PANEL:GetToggle = !PANEL:GetToggle
    end

    function button:Paint(s, w, h)
        if PANEL:GetToggle():
            draw.RoundedBox(5, 0, 0, w, h, PROTON.ui.buttons.positive)
        else 
            draw.RoundedBox(5, 0, 0, w, h, PROTON.ui.buttons.negative)
        end
    end

    local label = vgui.Create("DLabel", PANEL)
    label:SetText(self:GetToggle())
    label:Dock(LEFT)
end

vgui.Register("ProUI.Button.Toggle", PANEL)