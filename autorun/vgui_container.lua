local PANEL = {}

function PANEL:Init()
    self:SetWide(ScrW() * 0.6)
    self:SetTall(ScrH() * 0.6)
    self:Center()

    self.Header = vgui.Create("ProUI.Container.Header", self)
    self.Header:Dock(TOP)
    self.Header:SetWide(self:GetWide())
    self.Header:SetTall(30)
    self.Header:SetTitle("ProtonMenu")
    self.Header:SetPage("ESP Configuration")

    self.Footer = vgui.Create("ProUI.Container.Footer", self)
    self.Footer:Dock(BOTTOM)
    self.Footer:SetWide(self:GetWide())
    self.Footer:SetTall(30)
    self.Footer:SetVersion("0.5.0")
end

function PANEL:Paint(w, h)
    draw.RoundedBox(5, 0, 0, w, h, PROTON.ui.primary)
end

vgui.Register("ProUI.Container", PANEL)