local plr = game.Players.LocalPlayer

local function TPHat(Hat)
    while true do
        task.wait()
        local Handle = Hat:FindFirstChild("Handle")
        if Handle then
            Handle.CFrame = plr.Character.HumanoidRootPart.CFrame
        end
    end
end

local function ReAnim()
    replicatesignal(plr.ConnectDiedSignalBackend)
    task.wait(game.Players.RespawnTime + 0.1)
	local Gyro = Instance.new("BodyGyro", plr.Character.HumanoidRootPart)
	Gyro.CFrame = CFrame.new(0, 0, 0, 0, 1, -0, 0, 0, -1, 0, 0, -0)
	Gyro.D = 500
	Gyro.P = 90000
	Gyro.MaxTorque = Vector3.new(400000, 400000, 400000)
	plr.Character.HumanoidRootPart.CFrame = CFrame.new(0, -497.67, 0)
	replicatesignal(plr.Character.Humanoid.ServerBreakJoints)
    game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
    game.Workspace.CurrentCamera.CFrame = CFrame.new(0, 100, 0)
    for i, v in pairs(plr.Character:GetChildren()) do
        if v:IsA("Hat") then
            coroutine.wrap(TPHat)(v)
        end
    end
end

ReAnim()
