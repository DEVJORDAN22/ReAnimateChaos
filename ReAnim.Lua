local rs = game:GetService("RunService")
local plr = game.Players.LocalPlayer

local HRPCF = CFrame.new(0, 100, 0)
local FakeHRP = nil

local function CreateAlign(Part1, Part2) 
	local A0 = nil
	local A1 = nil
	if Part1:FindFirstChildOfClass("Attachment") then
		A0 = Part1:FindFirstChildOfClass("Attachment")
	end

	if Part2:FindFirstChildOfClass("Attachment") then
		A1 = Part2:FindFirstChildOfClass("Attachment")
	end

	local AlignPosition = Instance.new("AlignPosition")
	AlignPosition.Parent = Part1
	local AlignOrientation = Instance.new("AlignOrientation")
	AlignOrientation.Parent = Part1

	AlignPosition.Attachment0 = A0
	AlignPosition.Attachment1 = A1
	AlignOrientation.Attachment0 = A0
	AlignOrientation.Attachment1 = A1

	AlignPosition.RigidityEnabled = false
	AlignPosition.ApplyAtCenterOfMass = false
	AlignPosition.MaxForce = math.huge
	AlignPosition.MaxVelocity = math.huge
	AlignPosition.ReactionForceEnabled = false
	AlignPosition.Responsiveness = 200

	AlignOrientation.MaxTorque = math.huge
	AlignOrientation.MaxAngularVelocity = math.huge
	AlignOrientation.PrimaryAxisOnly = false
	AlignOrientation.ReactionTorqueEnabled = false
	AlignOrientation.Responsiveness = 200
	AlignOrientation.RigidityEnabled = false

	Part2.Transparency = 0.8 -- So you can see the fake hats relative to the real ones incase they fall and etc
end

local function CreateFakeHat(Hat)
	print("Creating fake hat for "..Hat.Name)
	local FakeHat = Hat:Clone()
	FakeHat.Parent = plr.Character
	FakeHat.Handle.Massless = true
	FakeHat.Handle.CanCollide = false
	FakeHat.Handle.Anchored = true
	FakeHat.Handle.CFrame = FakeHRP.CFrame
	CreateAlign(Hat:FindFirstChild("Handle"), FakeHat:FindFirstChild("Handle"))
end

local function ReAnim()
	pcall(function()
    	settings().Physics.AllowSleep = false
		settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled
	end)
    replicatesignal(plr.ConnectDiedSignalBackend)
    task.wait(game.Players.RespawnTime + 0.1)
	local Gyro = Instance.new("BodyGyro", plr.Character.HumanoidRootPart)
	Gyro.CFrame = CFrame.new(0, 0, 0, 0, 1, -0, 0, 0, -1, 0, 0, -0)
	Gyro.D = 500
	Gyro.P = 90000
	Gyro.MaxTorque = Vector3.new(400000, 400000, 400000)
    plr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
	plr.Character.HumanoidRootPart.CFrame = CFrame.new(0, 0, 0)
    wait(0.1)
	FakeHRP = plr.Character.HumanoidRootPart:Clone()
	FakeHRP.Name = "FakeHRP"
	FakeHRP.Parent = plr.Character
	FakeHRP.Anchored = true
	FakeHRP.CFrame = HRPCF
	FakeHRP.Massless = true
	FakeHRP.BodyGyro:Destroy()
	for i, v in pairs(plr.Character:GetChildren()) do
		print(v.Name)
        if v:IsA("Accessory") then
			print("Found accessory: "..v.Name)
			v.Handle:BreakJoints()
            local Attachment = v.Handle:FindFirstChildOfClass("Attachment")
            CreateFakeHat(v)
        end
    end
	FakePlr = game:GetService("Players"):CreateHumanoidModelFromDescription(game:GetService("Players"):GetHumanoidDescriptionFromUserId(game:GetService("Players").LocalPlayer.UserId),Enum.HumanoidRigType.R6)
	for i,v in pairs(FakePlr:GetChildren()) do
		if v:IsA("Accessory") then
			v:Destroy()
		end
	end
	for i,v in pairs(FakePlr:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Transparency = 0.5
		elseif v:IsA("Decal") then
			v.Transparency = 1
		end
	end
	FakePlr.PrimaryPart = FakePlr:FindFirstChild("HumanoidRootPart")
	FakePlr.Parent = workspace
	FakePlr.Name = "FakePlr"
	plr.Character.Parent = FakePlr
    plr.Character.HumanoidRootPart.Anchored = false
	--CreateAlign(plr.Character.HumanoidRootPart, plr.Character.FakeHRP)
	local BP = Instance.new("BodyPosition", plr.Character.HumanoidRootPart)
	BP.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	BP.P = 90000
	BP.D = 500
	BP.Position = HRPCF.Position
	plr.Character.HumanoidRootPart.CFrame = HRPCF
	plr.Character.HumanoidRootPart.BodyGyro:Destroy()
	replicatesignal(plr.Character.Humanoid.ServerBreakJoints)
    --game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
	game.Workspace.CurrentCamera.CameraSubject = plr.Character.Humanoid
    game.Workspace.CurrentCamera.CFrame = CFrame.new(0, 100, -50)
	FakeHRP.Name = "HumanoidRootPart"
end

ReAnim()
