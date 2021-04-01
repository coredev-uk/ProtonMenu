local PANEL = {}

AccessorFunc(PANEL, "p_title", "Title")
AccessorFunc(PANEL, "p_table", "Table")

function PANEL:Init()
    local SampleTable = {
        ["Key1"] = false,
        ["Key2"] = true
    }
    self:Dock(FILL)
    self:SetTitle("Column")
    self:SetTable(SampleTable)
end

function PANEL:Paint(w, h)
    draw.RoundedBox(5, 0, 0, w, h, PROTON.ui.background.column)
    draw.RoundedBoxEx(5, 0, 0, w, 10, PROTON.ui.background.title, true, true)
end

function PANEL:CreateButtons()
    for k, v in pairs(self:GetTable())
        local button = vgui.Create("ProUI.Button.Toggle")
        button:SetToggle(k)
    end
end

vgui.Register("ProUI.Container.Column", PANEL)