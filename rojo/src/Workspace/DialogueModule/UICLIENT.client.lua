local ProximityPromptService = game:GetService("ProximityPromptService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local DialogueService = require(ReplicatedStorage.Dialogue);
local DialogueGui = script.Parent:WaitForChild("DialogueGui").DialogueF;

ProximityPromptService.PromptTriggered:Connect(function(prompt : ProximityPrompt, player: Player)
	if(prompt.Name == "DialoguePP") then
		local DialogueName;
		for i,v in ipairs(prompt:GetChildren()) do
			if(v:IsA("StringValue")) then
				DialogueName = v.Value;
			end
		end
		DialogueService.NewDialogue("TestDialogueNpc", DialogueGui); -- Start the dialogue, first parameter is the name of the dialogue, 
																	 --second is the gui the dialogue is going to be shown on.
	end
end)