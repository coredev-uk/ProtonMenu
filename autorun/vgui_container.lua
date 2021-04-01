local PANEL = {}

AccessorFunc(PANEL, "p_page", "Page")

function PANEL:Init()
    self:SetPage("ESP Configuration")

    -- Sizes
    self:SetWide(ScrW() * 0.6)
    self:SetTall(ScrH() * 0.6)
    self:Center()

    -- Header
    self.Header = vgui.Create("ProUI.Container.Header", self)
    self.Header:Dock(TOP)
    self.Header:SetWide(self:GetWide())
    self.Header:SetTall(30)
    self.Header:SetTitle("ProtonMenu")
    self.Header:SetPage(self:GetPage())

    -- Footer
    self.Footer = vgui.Create("ProUI.Container.Footer", self)
    self.Footer:Dock(BOTTOM)
    self.Footer:SetWide(self:GetWide())
    self.Footer:SetTall(30)
end

function PANEL:Paint(w, h)
    draw.RoundedBox(5, 0, 0, w, h, PROTON.ui.primary)
end

function PANEL:CreateColumns()
    for k, v in pairs(PROTON.esp)
        local column = vgui.Create("ProUI.Container.Column")
        column:SetTitle(k)
        column:SetTable(v)
    end
end

vgui.Register("ProUI.Container", PANEL)