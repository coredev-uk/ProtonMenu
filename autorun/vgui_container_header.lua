local PANEL = {}

AccessorFunc(PANEL, "p_title", "Title")
AccessorFunc(PANEL, "p_page", "Page")

function PANEL:Init()
    self:SetTitle("Title")
    self:SetPage("Page")

    self.Close = vgui.Create("DButton", self)
    self.Close:SetText("")
    self.Close:SetWide(30)
    self.Close:Dock(RIGHT)
    self.Close.Paint = function(s, w, h)
		if self.Close:IsHovered() then
			draw.RoundedBoxEx(0, 0, 0, w, h, PROTON.ui.primary, false, true, false, false)
			draw.SimpleText("×", "PROTON.fonts.menu.40", w / 2, h / 2, PROTON.ui.buttons.closehover, 1, 1)
		else
            draw.RoundedBoxEx(0, 0, 0, w, h, ColorAlpha(PROTON.ui.primary, 150), false, true, false, false)
			draw.SimpleText("×", "PROTON.fonts.menu.40", w / 2, h / 2, PROTON.ui.buttons.close, 1, 1)
		end
    end
    self.Close.DoClick = function()
        self:GetParent():Remove()
    end
end

function PANEL:Paint(w, h)
    draw.RoundedBox(5, 0, 0, w, 30, PROTON.ui.accent)
    draw.SimpleText(self:GetTitle().." | "..self:GetPage(), "PROTON.fonts.menu.title.20", 10, 5, PROTON.ui.txt.white)
end

vgui.Register("ProUI.Container.Header", PANEL)