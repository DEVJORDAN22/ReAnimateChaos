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
    plr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
	plr.Character.HumanoidRootPart.CFrame = CFrame.new(0, -497.67, 0)
    wait(0.1)
    plr.Character.HumanoidRootPart.Anchored = true
	replicatesignal(plr.Character.Humanoid.ServerBreakJoints)
    game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
    game.Workspace.CurrentCamera.CFrame = CFrame.new(0, 100, -50)
    for i, v in pairs(plr.Character:GetChildren()) do
        if v:IsA("Hat") then
            local Attachment = v.Handle:FindFirstChildOfClass("Attachment")
            replicatesignal(v.Handle.SetCFrame, CFrame.new(0, 100, 0))
            if Attachment then
                AP = Instance.new("AlignPosition", v.Handle)
                AO = Instance.new("AlignOrientation", v.Handle)
                AP.Mode = Enum.PositionAlignmentMode.OneAttachment
                AP.RigidityEnabled = false
                AP.MaxForce = 1e+35
                AP.MaxVelocity = 1e+35
                AP.ReactionForceEnabled = false
                AP.Responsiveness = 1e+35
                AP.Attachment0 = Attachment
                AP.Position = Vector3.new(0, 100, 0)
                AO.Mode = Enum.OrientationAlignmentMode.OneAttachment
                AO.Attachment0 = Attachment
                AO.Orientation = Vector3.new(0, 0, 0)
            end
        end
    end
end

ReAnim()
