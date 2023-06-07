local DINF = {}

local DialogueFunctions = require(script.Parent.DialogueFunctions);

DINF.TestDialogueNpc = 
	{
		NodeId = 1;
		Name = "Test Dialogue NPC";
		Priority = 1;
		Empty = false;
		Question = "";
		Text = "Hello, how could I help you?";
		Node1 =
		{
			NodeId = 2;
			Priority = 1;
			Empty = false;
			Question = "Who are you?";
			Text = "I am the test NPC here for you to test the dialogue module.";
			Node4 =
			{
				NodeId = 5;
				Priority = 1;
				Empty = false;
				Question = "Are you working?";
				Text = "Yes, I am working.";
				Node5 = 
				{
					NodeId = 6;
					Priority = 1;
					Empty = false;
					Question = "[END DIALOG]";
					Text = "...";
					fun = DialogueFunctions.EndDialogue;
				},
				Node7 = 
				{
					NodeId = 8;
					Priority = 2;
					Empty = false;
					Question = "Who made you?";
					Text = "This dialogue module has been made by smellingpoopfart1324.";
					Node8 = 
					{
						NodeId = 9;
						Priority = 1;
						Empty = false;
						Question = "[END DIALOG]";
						Text = "...";
						fun = DialogueFunctions.EndDialogue;
					}
				}
			},
		},
		Node2 =
		{
			NodeId = 3;
			Priority = 2;
			Empty = false;
			Question = "Are you working?";
			Text = "Yes, I am working.";
			Node5 = 
			{
				NodeId = 6;
				Priority = 1;
				Empty = false;
				Question = "[END DIALOG]";
				Text = "...";
				fun = DialogueFunctions.EndDialogue;
			},
			Node8 = 
			{
				NodeId = 9;
				Priority = 2;
				Empty = false;
				Question = "Who made you?";
				Text = "This dialogue module has been made by smellingpoopfart1324.";
				Node9 = 
				{
					NodeId = 10;
					Priority = 1;
					Empty = false;
					Question = "[END DIALOG]";
					Text = "...";
					fun = DialogueFunctions.EndDialogue;
				}
			}
		},
		Node3 = 
		{
			NodeId = 4;
			Priority = 3;
			Empty = false;
			Question = "I'd like to buy the dialogue module.";
			Text = "Oh, Great!.";
			fun = DialogueFunctions.BuyDialogue;
			Node6 =
			{
				NodeId = 7;
				Priority = 1;
				Empty = false;
				Question = "[END DIALOG]";
				Text = "...";
				fun = DialogueFunctions.EndDialogue;
			}
		}
	}
return DINF;
