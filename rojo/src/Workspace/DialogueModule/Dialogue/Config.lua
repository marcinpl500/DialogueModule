--[[
/////////////////////////////////////////////////////////////

				DIALOGUE MODULE CONFIG
Author: smellingpoopfart1324
Purpose: Config file for the dialogue module

\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
]]
local config= {};

config.GuiSizes =  -- Used for appearing/disappearing of the GUI (For tweening sizes)
	{
		["DialogueF"] =  -- name of the UI
		{
			["Enter"] = UDim2.fromScale(0.441, 0.252); -- UI size for entering screen/dialogue
			["Out"] = UDim2.fromScale(0.0001,0.0001) -- UI size for exiting screen/dialogue
		}
	}

config.TypewriteSpeed = 0.003 --Speed for the letters to appear.
config.TweenSpeed = .3 --Speed for the tween.

return config;
