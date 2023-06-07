--[[
/////////////////////////////////////////////////////////////

				DIALOGUE MODULE MAIN FILE
Author: marcin_pl500
Purpose: Main module of the dialogue module, handles the generation, connection and selection of nodes (choices)

\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
]]

local TB = {};

local TweenService = game:GetService("TweenService")
TB.ConnectedNodes = {Connections = {}, Vertexes = {}}; -- We store the connections here
local GraphModule = require(script.GraphModule); -- Graph module is used for connecting nodes
TB.DialogueService = GraphModule.new(GraphModule.GraphType.OneWay) -- Created dialogue vertex
local DialogueInfos = require(script.DialoguesInfos);
local TypewriteModule = require(script.Typewrite);
local Config = require(script.Config);
local TypewriteSpeed = Config.TypewriteSpeed;
local TweenSpeed = Config.TweenSpeed;
TB.ResetGui = function(gui) -- responsible for making the text buttons invisible and clearing the button connections
	for i,b in pairs(gui:GetChildren()) do -- looping through the gui to deactivate the buttons
		if b:IsA("TextButton") then -- checking if the value is a text button
			b.Visible = false; -- it is a text button, disabling it
			b.Active = false;
		end
	end
	for i,c in pairs(TB.ConnectedNodes.Connections) do -- looping through the connections in order to disconnect and clear them
		c:Disconnect();
		c = nil;
	end
end

TB.CreateNode = function(choice : string,response : string,priority : number ,onSelected, NodeId : number) -- Creating Nodes
	local newNode = {} -- New node table
	newNode.Choice = choice or "" -- Choice text shown on buttons
	newNode.Response = response or "" -- NPC Text shown on text label
	newNode.Priority = priority or math.huge -- priority (1 - highest priority)
	newNode.NodeId = NodeId or math.huge-- Node id (all nodes id must be unique)
	newNode.OnSelected = onSelected or function ()  end -- function fired upon selecting node
	table.insert(TB.ConnectedNodes.Vertexes, newNode) -- inserting the node into the vertex table (not sure why I added it tbh)
	TB.DialogueService:AddVertex(newNode) -- inserting it into the vertex (graph module)
	return newNode -- returning the node
end

TB.HookUpNodes = function(Table, occurence : number)
	local FirstNode; -- Node that other ones will be connected to and will be returned
	if Table.Empty  then  
		return true, TB.CreateNode();
	else
		if Table.fun then 
			-- If there is an attached function to the node
			FirstNode = TB.CreateNode(Table.Question, Table.Text, occurence, Table.fun, Table.NodeId);
		else
			-- If there is no function attached, put empty function
			FirstNode = TB.CreateNode(Table.Question, Table.Text, occurence, function()end, Table.NodeId);
		end
		local NodesTable = {}; -- Our children nodes that will be connected to the first node
		for i,v in pairs(Table) do
			if type(v) == "table" and not v.Empty then
				table.insert(NodesTable, v); --Inserting the nodes infos for creating and hooking them up
			end
		end;
		table.sort(NodesTable, function(a,b) return a.Priority <= b.Priority;  end) -- Sorting the priorities
		for i,v in ipairs(NodesTable) do -- Looping through the nodes infos to create the nodes and connect them to the first node
			local empty,node = TB.HookUpNodes(v, v.Priority)
			if not empty then
				TB.DialogueService:Connect(FirstNode, node); 	
			end
		end
		return false, FirstNode; -- returning the node
	end
	return true, TB.CreateNode();
end

local selectDebounce = false -- Makes sure that there are no 2 nodes selected at once
TB.SelectNode = function(node, gui)
	TB.ResetGui(gui); --Makes the buttons invisible and clears the button clicking connections
	local NpcTextLbl = gui.NpcTextLbl;
	if selectDebounce then return else  -- Function ends when there is another node selected
		selectDebounce = true; -- Marking that the function is running and a node is already selected
		if node.Response ~= "" then -- If the node text is  not empty (Usually they won't be empty and contain text)
			--DtxtBtn.Text = node.Response
			TypewriteModule.typeWrite(NpcTextLbl, node.Response,TypewriteSpeed)  -- Typewriting the text in a span of .03 seconds
		end
		local neighbors = TB.DialogueService:Neighbors(node) -- Getting connected children nodes
		if neighbors then -- If there are any children nodes
			table.sort(neighbors, function(a,b) -- Sorting by priority (it maybe could've work without it as it's sorted on Hookup but one more won't hurt)
				return a.Priority <= b.Priority -- Returning the higher priority first
			end)
			for index = 1, #neighbors do -- looping through the children nodes in order to map them to the text buttons, show their choice text and map their functions on to click connections
				local nextNode = neighbors[index] -- Getting the children node 
				local choiceButton = gui:FindFirstChild("Choice"..index.."Btn") -- Finding the text button 
				choiceButton.Visible = true -- Making it visible for user (ResetDialogGui makes them all invisible and inactive)
				choiceButton.Active = true;
				TypewriteModule.typeWrite(choiceButton, nextNode.Choice, TypewriteSpeed) -- Typewriting the choice
				TB.ConnectedNodes.Connections[index] = choiceButton.MouseButton1Click:Connect(function() -- Mapping the children node function to the button by click event
					--		print("SELECTED NODE: "..nextNode.NodeId) -- debug print
					TB.SelectNode(nextNode, gui) -- Selecting the node, firing this function again for the selected children node
					--	print("Fired") -- debug print
					nextNode.OnSelected(gui) -- Firing the function that children node is containing
					selectDebounce = false; -- ending function, unlocking it
					return -- returning because another children node is selected and the node's function has been executed
				end)
			end
			selectDebounce = false; -- ending the function, unlocking it
		end
	end
end
TB.NewDialogue = function(DialogueName, gui) -- This function starts the new dialogue
	TB.ResetGui(gui); -- Makes sure the are no existing connections
	if(DialogueInfos[DialogueName]) then -- Checking if the dialogue exists
		local TWINF = TweenInfo.new(TweenSpeed, Enum.EasingStyle.Quart, Enum.EasingDirection.In) -- Creating the tween info for the tween
		gui.Visible = true;		--In order to show the gui, we have to turn it on first
		local DialogueInfo = DialogueInfos[DialogueName] -- getting the dialogue info (nodes, name, etc)
		local NpcNameLbl = gui.NpcNameLbl; -- Getting the NPC name text label for it to display the npc name
		NpcNameLbl.Text = DialogueInfo.Name; -- Setting the npc name
		local FirstNode = TB.CreateNode("", DialogueInfo.Text, 1, function()end, DialogueInfo.NodeId); -- Creating the first node, the dialogue will base on it
		local GuiSizeIn = Config.GuiSizes[gui.Name]["Enter"];
		local TweenEntry; -- declaring soon to be created tween
		if(tostring(typeof(GuiSizeIn)) == "UDim2") then
			TweenEntry = TweenService:Create(gui, TWINF, {Size = GuiSizeIn}); -- Creating the tween for it to smoothly appear
		else
			warn("GUI SIZE ENTER FOR GUI "..gui.Name.. " IS NOT AN UDim2. INCORRECT INPUT.");
			return;
		end
		TweenEntry:Play(); -- Playing the tween 
		--In the meantime, we prepare the dialogue
		local NodesTable = {}; -- Creating the nodes table that will contain children nodes (nodes connected to the first node, our first choices)
		for i,n in pairs(DialogueInfo) do -- Looping through the dialogue info in order to get the nodes
			if(type(n) == "table") and not n.Empty then -- Checking if the children is a node (table) and it's not empty
				table.insert(NodesTable, n); -- Adding the children node into the table for creation
			end
		end 
		table.sort(NodesTable, function(a,b)
			return a.Priority <= b.Priority -- Sorting the table by priority (1 - the highest priority)
		end)
		for i,n in ipairs(NodesTable) do
			local empty,node = TB.HookUpNodes(n, n.Priority); -- Creating and hooking up the nodes
			if (not empty) then  -- Checking if the node is empty
				TB.DialogueService:Connect(FirstNode, node); -- node isn't empty, connecting to the first node in order for them to appear on the dialogue gui	
			end
		end
		TB.SelectNode(FirstNode, gui); -- Starting the dialogue by selecting the first node
	end

end



return TB;