--[[Welcome to the dialogue module made by smellingpoopfart1324. This article will help you with understanding it.

USAGE:
To use it, simply put your dialogue in the "DialoguesInfos" module script in following way:

DINF.DialogueNpcName = 
	{
		NodeId = 1, --This is for the script to not get lost, NodeId must be unique.
		Name = "NPCNAME", --This is only for the starting node, sets the name of the npc on the gui.
		Priority = 1, --This is for the script to sort the node, use numbers, 1 is the most important, 
		--2 is less important but more important than 3 and so on. Use the numbers corresponding to the amount of choice buttons, 
		--up to the equal number of priorities/choice buttons.
		Empty = false, -- Indicates whether the node is empty and should be skipped. uses booleans (false = 0, true = 1).
		Question = "Can you help me?", -- Text that shows on the choice button corresponding to the priority. 
		Text = "Yes, I can." -- Text shown by NPC when the choice button/node is selected.
		fun = DialogueFunctions.SomeFunction --Optional, activates the function when the choice is selected.
		Node1 = --Creates new node, same variables are applied as above except the name one. There can be as many children nodes as there are choice buttons. Each node name should be unique.  
		{
			
		}
		etc.
		Look into "DialoguesInfos" for an example.
	} 
	
	
	DIALOGUE MODULE IS A PRODUCT MADE BY SMELLINGPOOPFART1324. PURCHASING THIS PRODUCT DOES NOT GRANT YOU RIGTHS TO RESELL AND DISTRIBUTE.
--]]
