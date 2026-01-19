local rs = game:GetService("RunService")
local plr = game.Players.LocalPlayer

local HRPCF = CFrame.new(0, 100, 0)
local FakeHRP = nil
local RS = game:GetService("RunService")

local SafeYAxis = 35

local function IsNetworkOwner(Part)  -- <BasePart> : Boolean
	return Part and Part.ReceiveAge == 0
end

local function CreateAlign(Part1, Part2, Offset) 
	if Part1 and Part2 then
		if Part1.Parent and Part2.Parent then
			if IsNetworkOwner(Part1) then
				local Part2Magnitude = Part2.Size.Magnitude
				local Part2Velocity = Part2.AssemblyLinearVelocity * Part2Magnitude
				local CalculatedVel = Part2Velocity * 2.5

				local ClampedAxisY = math.clamp(Part2Velocity.Y, SafeYAxis, 512)
				local Velocity = Vector3.new(CalculatedVel.X, ClampedAxisY, CalculatedVel.Z)

				local CFrameOffset = Part2.CFrame * Offset

				Part1.AssemblyLinearVelocity = Velocity
				Part1.AssemblyAngularVelocity = Part2.AssemblyAngularVelocity
				Part1.CFrame = CFrameOffset + ReverseSleep
			end
		end
	end
end

local function CreateFakeHat(Hat)
	print("Creating fake hat for "..Hat.Name)
	local FakeHat = Hat:Clone()
	FakeHat.Parent = plr.Character
	FakeHat.Handle.Massless = true
	FakeHat.Handle.CanCollide = false
	FakeHat.Handle.Anchored = true
	FakeHat.Handle.CFrame = HRPCF
	CreateAlign(Hat:WaitForChild("Handle"), FakeHat:WaitForChild("Handle"))
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
		for i, v in pairs(plr.Character:GetChildren()) do
		print(v.Name)
        if v:IsA("Accessory") then
			print("Found accessory: "..v.Name)
			v.Handle:BreakJoints()
			v.Handle.AssemblyLinearVelocity = Vector3.new(plr.Character.Torso.AssemblyLinearVelocity.X*15 -(10*math.cos(os.clock()*1000))   , 28.5312+math.sin(os.clock()*1000), plr.Character.Torso.AssemblyLinearVelocity.Z*15+(3*math.sin(os.clock()*12000))) 
			v.Handle.CanCollide = false
            local Attachment = v.Handle:FindFirstChildOfClass("Attachment")
            CreateFakeHat(v)
        end
    end
	FakeHRP.Name = "HumanoidRootPart"
end

ReAnim()
