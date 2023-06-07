local tb = {};
local Replicated = game:GetService("ReplicatedStorage");
local MarketplaceService = game:GetService("MarketplaceService");
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService");
local Config = require(script.Parent.Config);
--Client side
if (RunService:IsClient()) then -- checking if the module script is executed by the client side
	local Player = game.Players.LocalPlayer; -- getting the player instance to grab gui (NOT AVAILABLE IN SERVER HENCE WHY CHECKING)
	local PlayerGui = Player.PlayerGui; -- getting the player gui
	
	tb.EndDialogue = function(gui) -- creating the function for ending dialogue
		local TWINF = TweenInfo.new(.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In); -- creating tween info
		local GuiSizeOut = Config.GuiSizes[gui.Name]["Out"]; -- Getting gui size for closing the ui
		local TweenOut; -- Our to be created tween
		if(tostring(typeof(GuiSizeOut)) == "UDim2") then
			TweenOut = TweenService:Create(gui, TWINF, {Size = GuiSizeOut});
		else
			warn("GUI SIZE OUT FOR GUI "..gui.Name.. " IS NOT AN UDim2. INCORRECT INPUT.");
			return;
		end
		TweenOut:Play();
		TweenOut.Completed:Wait();
		gui.Visible = false;
	end
	
	tb.BuyDialogue = function() --  Prompting purchase of the dialogue module
		local ProductId =1331087014; -- Id of the dev product
		MarketplaceService:PromptProductPurchase(Player, ProductId);
	end
end

return tb;