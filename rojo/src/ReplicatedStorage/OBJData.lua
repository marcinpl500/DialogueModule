local TweenService = game:GetService("TweenService")
local objData = {};

objData.PlayerData = {};

objData.AvailablePlots = 
	{
		Plot1 = true,
		Plot2 = true;
	};

objData.ShopsData = 
	{
		Plots = 
		{
			Plot1 = 
			{
				ObjName = "Plot1",
				ObjDescription = "Plot1 Description",
				Price = 0
			},
			Plot2 = 
			{
				ObjName = "Plot2",
				ObjDescription = "Plot2 Description",
				Price = 0
			};
		};
	};

if game:GetService("RunService"):IsServer() then
	objData.Update = function(plr, keys, data, all)
		if all then game:GetService("ReplicatedStorage"):WaitForChild("Remotes").UpdateData:FireAllClients(keys,data);
		else game:GetService("ReplicatedStorage"):WaitForChild("Remotes").UpdateData:FireClient(plr, keys, data);
		end
	end
else
	local player = game.Players.LocalPlayer;
	local DialogueFunctions = require(script.Parent.DialogueFunctions);
--[[  local MainFrame = PlotOptionsF.MainFrame;
    local Owned = objData.PlayerData.Plot.Owned;
    local PlotOn = objData.PlayerData.Plot.PlotObj;
    if Owned and PlotOn then
        for i,v in pairs(MainFrame:GetChildren()) do
            if(v:IsA("TextButton")) then
                v.Visible = true;
                print(string.gsub(v.Name, "Btn", ""))
                v.MouseButton1Click:Connect(function()PlotOptionsBtnsTable[string.gsub(v.Name, "Btn", "")](v, prompt)end)
            elseif(v:IsA("TextLabel") and v.Name ~="NoPlotLbl") then
                v.Visible = true;
                print(string.gsub(v.Name, "Lbl", ""))
                v.Text = objData.PlayerData.Plot[string.gsub(v.Name, "Lbl", "")];
            else
                continue;
            end
        end
    end;]]
--[[objData.OpenPlotOptions = function(prompt)
    local MainFrame = PlotOptionsF.MainFrame;
    local Owned = objData.PlayerData.Plot.Owned;
    local PlotOn = objData.PlayerData.Plot.PlotObj;
    if Owned and PlotOn then
        for i,v in pairs(MainFrame:GetChildren()) do
            if(v:IsA("TextButton")) then
                v.Visible = true;
                print(string.gsub(v.Name, "Btn", ""))
                v.MouseButton1Click:Connect(function()PlotOptionsBtnsTable[string.gsub(v.Name, "Btn", "")](v, prompt)end)
            elseif(v:IsA("TextLabel") and v.Name ~="NoPlotLbl") then
                v.Visible = true;
                print(string.gsub(v.Name, "Lbl", ""))
                v.Text = objData.PlayerData.Plot[string.gsub(v.Name, "Lbl", "")];
            else
                continue;
            end
        end
    elseif Owned and not PlotOn then
    Replicated.Remotes.ClaimPlot:FireServer(game.Workspace.Plots.Plot1);
    local success;
    Replicated.Remotes.ClaimPlot.OnClientEvent:Connect(function(s)
        success = s;
    end)
    repeat wait() until success ~= nil;
    MainFrame.NoPlotLbl.Visible = true;
    MainFrame.CloseBtn.Visible = true;
    MainFrame.CloseBtn.MouseButton1Click:Connect(function()PlotOptionsBtnsTable["Close"]();end)
    if success then MainFrame.NoPlotLbl.Text = "PLOT ACQUIRED"; else MainFrame.NoPlotLbl.Text = "FAILURE DURING ACQUIRING PLOT. TRY ANOTHER ONE AND TRY AGAIN."; end
    else
    for i,v in pairs(MainFrame:GetChildren()) do
        if(v:IsA("TextLabel") and v.Name == "NoPlotLbl") then
            v.Visible = true;
        elseif(v:IsA("TextButton") and v.Name == "CloseBtn") then
            v.Visible = true;
            v.MouseButton1Click:Connect(function()PlotOptionsBtnsTable["Close"]();end)
        else
            if(v:IsA("TextLabel") or v:IsA("TextButton")) then
                v.Visible = false;
            end
        end
    end
    end
    PlotOptionsF.Visible = true;
    local EntryTween = TweenService:Create(PlotOptionsF, POUTW, {Size = UDim2.fromScale(0.241, 0.186)})
    EntryTween:Play()
end--]]

	objData.NPCDialouge = 
		{
			["PlotShopNpc"] =
			{
				nId = "Node0",
				Name = "Plots Merchant",
				Text = "Hello, how could I help you?",
				Question = "",
				Node1 = 
				{
					nId = "Node1",
					Pr = 1,
					Empty = false,
					Question = "Who are you?",
					Text = "I'm a plot merchant, I sell plots of land. Are you interested?",
					Node912 = 
					{
						nId = "Node912",
						Pr = 1,
						Question = "Show me your items for sale.",
						Text = "Of course, here you go.",
						fun = DialogueFunctions.OpenPlotShop;
					},
					Node2 = 
					{
						nId = "Node2",
						Pr = 2,
						Empty = false,
						Question = "No, sorry",
						Text = "Oh, of course.",
						Node9 = {nId = "Node9", Pr = 1, Empty = false, Question = "[End Dialog]", Text = "...", fun = DialogueFunctions.DialogueExit;};

					},
				},
				Node4 = 
				{
					nId = "Node4",
					Pr = 2,
					Empty = false,
					Question = "Show me your items for sale.",
					Text = "Of course, here you go.",
					fun = DialogueFunctions.OpenPlotShop;
				},
				Node5 =
				{
					nId = "Node5",
					Pr = 3,
					Empty = false,
					Question = "I'm not interested.",
					Text = "Oh, of course.",
					Node13 = {nId = "Node13", Pr = 1, Empty = false, Question = "[End Dialog]", Text = "...", fun = DialogueFunctions.DialogueExit;},
				};
			}
		};


	game:GetService("ReplicatedStorage"):WaitForChild("Remotes").UpdateData.OnClientEvent:Connect(function(keys, data)
		for i,v in ipairs(keys) do
			objData[v] = data[i];
		end
		game:GetService("ReplicatedStorage"):WaitForChild("Remotes").LoadData:FireServer();
	end)

end



return objData;
