local plr = game.Players.LocalPlayer

local function ReAnim()
	local Gyro = Instance.new("BodyGyro", plr.Character.HumanoidRootPart)
	Gyro.CFrame = CFrame.new(0, 0, 0, 0, 1, -0, 0, 0, -1, 0, 0, -0)
	Gyro.D = 500
	Gyro.P = 90000
	Gyro.MaxTorque = Vector3.new(400000, 400000, 400000)
	plr.Character.HumanoidRootPart.CFrame = CFrame.new(0, -497.67, 0)
	replicatesignal(plr.ConnectDiedSignalBackend)
	replicatesignal(plr.Character.Humanoid.ServerBreakJoints)
end

ReAnim()
