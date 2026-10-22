local RunService = game:GetService("RunService")

local Camera = workspace.CurrentCamera
local Char = script.Parent

local Hum:Humanoid = Char:WaitForChild("Humanoid")
local Hrp:BasePart = Char:WaitForChild("HumanoidRootPart")

local Clock = 0

local function RandomNum(Min:number, Max:number)
	local Table = {Min, Max}
	return Table[math.random(1, 2)]
end

local function ShakeCam(Power)
	for i = 1,20 do
		local NumX = RandomNum(-Power, Power)
		local NumY = RandomNum(-Power, Power)

		Camera.CFrame = Camera.CFrame * CFrame.Angles(math.rad(NumX), math.rad(NumY), 0)
		task.wait()
	end
end

RunService.RenderStepped:Connect(function()
	if os.clock() - Clock <= 0.1 then return end

	local HumState = Hum:GetState()
	local IsLanded = HumState == Enum.HumanoidStateType.Landed

	if IsLanded then
		Clock = os.clock()

		local Number = 0
		
		if math.abs(Hrp.AssemblyLinearVelocity.Y / 5) <= 30 then
			Number = math.abs(Hrp.AssemblyLinearVelocity.Y / 63)
		else
			Number = math.abs(Hrp.AssemblyLinearVelocity.Magnitude / 10)
		end
		
		local Result = math.clamp(Number, 1, math.huge)
		
		task.spawn(function()
			ShakeCam(Result)
		end)
	end
end)
