local plr = game.Players.LocalPlayer

local function ReAnim()
	local Gyro = Instance.new("BodyGyro", plr.Character.HumanoidRootPart)
	Gyro.CFrame = CFrame.new(0, 0, 0, 0, 1, -0, 0, 0, -1, 0, 0, -0)
	Gyro.D = 500
	Gyro.P = 90000
	Gyro.MaxTorque = Vector3.new(400000, 400000, 400000)
	plr.Character.HumanoidRootPart.CFrame = CFrame.new(0, -497.67, 0)
    wait()
	replicatesignal(plr.ConnectDiedSignalBackend)
	replicatesignal(plr.Character.Humanoid.ServerBreakJoints)
    game.Workspace.CurrentCamera.CameraMode = Enum.CameraMode.Scriptable
    game.Workspace.CurrentCamera.CFrame = CFrame.new(0, 100, 0)
    for i, v in pairs(plr.Character:GetChildren()) do
        if v:IsA("Hat") then
            local Bodyposition = Instance.new("BodyPosition", v.Handle)
            Bodyposition.Position = Vector3.new(0, 100, 0)
            Bodyposition.MaxForce = Vector3.new(400000, 400000, 400000)
            Bodyposition.P = 90000
        end
    end
end

ReAnim()
