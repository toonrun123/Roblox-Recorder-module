local Record = {}
local Runservice = game:GetService("RunService")
local RecorderFolder = Instance.new("Folder",game.ReplicatedStorage)
local Camera = workspace.CurrentCamera
local RecordService = {}
RecorderFolder.Name = "RecorderFolder"

function Record:Record(Name,Model)
	if not RecorderFolder:FindFirstChild(Name) and not RecordService[Name] and Model then
		local FolderRecorder = Instance.new("Folder",RecorderFolder)
		local RenderStepped = nil
		FolderRecorder.Name = Name
		RenderStepped = Runservice.Stepped:connect(function()
			local NowFrame = #FolderRecorder:GetChildren()+1
			local FrameFolder = Instance.new("Folder",FolderRecorder)
			FrameFolder.Name = NowFrame
			for num,Part in pairs(Model:GetDescendants()) do
				if Part:IsA("BasePart") and not Part.Parent:IsA("Accessory") then
					local CFrameValue = Instance.new("CFrameValue",FrameFolder)
					CFrameValue.Value = Part.CFrame
					CFrameValue.Name = Part.Name
				end
			end
			wait(0.0001)
		end)
		RecordService[Name] = RenderStepped
	end
end

function Record:Stop(Name)
	if RecordService[Name] then
		RecordService[Name]:Disconnect()
	end
end

function Record:Play(Folder,Model,tablesettings)
	if tablesettings then
		local DestroyModelComplete = tablesettings.DMC
		if Folder and Model and DestroyModelComplete then
			Model.Archivable = true
			local ModelClone = Model:Clone()
			ModelClone.Parent = workspace
			Model.Archivable = false
			for i,frame in ipairs(Folder:GetChildren()) do
				for num,Part in pairs(ModelClone:GetDescendants()) do
					if Part:IsA("BasePart") then
						Part.Anchored = true
						if frame:FindFirstChild(Part.Name) then
							Part.CFrame = frame[Part.Name].Value
						end
					end
				end
				wait(0.0001)
			end	
			if rawequal(DestroyModelComplete,true) then
				ModelClone:Destroy()
			end
		end	
	end	
end

return Record
