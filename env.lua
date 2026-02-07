-- Skidding Ballistic In 2026 lol

local ENVIRONMENT = {} -- will be returned later to merge with already existing env

local VirtualInputManager = game:GetService("VirtualInputManager")
local UserInputService = game:GetService("UserInputService")
local InsertService = game:GetService("InsertService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local RobloxEnvironment = table.freeze({
	["print"] = print, ["warn"] = warn, ["error"] = error, ["assert"] = assert, ["collectgarbage"] = collectgarbage, ["require"] = require,
	["select"] = select, ["tonumber"] = tonumber, ["tostring"] = tostring, ["type"] = type, ["xpcall"] = xpcall,
	["pairs"] = pairs, ["next"] = next, ["ipairs"] = ipairs, ["newproxy"] = newproxy, ["rawequal"] = rawequal, ["rawget"] = rawget,
	["rawset"] = rawset, ["rawlen"] = rawlen, ["gcinfo"] = gcinfo,

	["coroutine"] = {
		["create"] = coroutine["create"], ["resume"] = coroutine["resume"], ["running"] = coroutine["running"],
		["status"] = coroutine["status"], ["wrap"] = coroutine["wrap"], ["yield"] = coroutine["yield"],
	},

	["bit32"] = {
		["arshift"] = bit32["arshift"], ["band"] = bit32["band"], ["bnot"] = bit32["bnot"], ["bor"] = bit32["bor"], ["btest"] = bit32["btest"],
		["extract"] = bit32["extract"], ["lshift"] = bit32["lshift"], ["replace"] = bit32["replace"], ["rshift"] = bit32["rshift"], ["xor"] = bit32["xor"],
	},

	["math"] = {
		["abs"] = math["abs"], ["acos"] = math["acos"], ["asin"] = math["asin"], ["atan"] = math["atan"], ["atan2"] = math["atan2"], ["ceil"] = math["ceil"],
		["cos"] = math["cos"], ["cosh"] = math["cosh"], ["deg"] = math["deg"], ["exp"] = math["exp"], ["floor"] = math["floor"], ["fmod"] = math["fmod"],
		["frexp"] = math["frexp"], ["ldexp"] = math["ldexp"], ["log"] = math["log"], ["log10"] = math["log10"], ["max"] = math["max"], ["min"] = math["min"],
		["modf"] = math["modf"], ["pow"] = math["pow"], ["rad"] = math["rad"], ["random"] = math["random"], ["randomseed"] = math["randomseed"],
		["sin"] = math["sin"], ["sinh"] = math["sinh"], ["sqrt"] = math["sqrt"], ["tan"] = math["tan"], ["tanh"] = math["tanh"]
	},

	["string"] = {
		["byte"] = string["byte"], ["char"] = string["char"], ["find"] = string["find"], ["format"] = string["format"], ["gmatch"] = string["gmatch"],
		["gsub"] = string["gsub"], ["len"] = string["len"], ["lower"] = string["lower"], ["match"] = string["match"], ["pack"] = string["pack"],
		["packsize"] = string["packsize"], ["rep"] = string["rep"], ["reverse"] = string["reverse"], ["sub"] = string["sub"],
		["unpack"] = string["unpack"], ["upper"] = string["upper"],
	},

	["table"] = {
		["clone"] = table.clone, ["concat"] = table.concat, ["insert"] = table.insert, ["pack"] = table.pack, ["remove"] = table.remove, ["sort"] = table.sort,
		["unpack"] = table.unpack,
	},

	["utf8"] = {
		["char"] = utf8["char"], ["charpattern"] = utf8["charpattern"], ["codepoint"] = utf8["codepoint"], ["codes"] = utf8["codes"],
		["len"] = utf8["len"], ["nfdnormalize"] = utf8["nfdnormalize"], ["nfcnormalize"] = utf8["nfcnormalize"],
	},

	["os"] = {
		["clock"] = os["clock"], ["date"] = os["date"], ["difftime"] = os["difftime"], ["time"] = os["time"],
	},

	["delay"] = delay, ["elapsedTime"] = elapsedTime, ["spawn"] = spawn, ["tick"] = tick, ["time"] = time, ["typeof"] = typeof,
	["UserSettings"] = UserSettings, ["version"] = version, ["wait"] = wait, ["_VERSION"] = _VERSION,

	["task"] = {
		["defer"] = task["defer"], ["delay"] = task["delay"], ["spawn"] = task["spawn"], ["wait"] = task["wait"], ["cancel"] = task["cancel"]
	},

	["debug"] = {
		["traceback"] = debug["traceback"], ["profilebegin"] = debug["profilebegin"], ["profileend"] = debug["profileend"],
	},

	["game"] = game, ["workspace"] = workspace, ["Game"] = game, ["Workspace"] = workspace,

	["getmetatable"] = getmetatable, ["setmetatable"] = setmetatable,
})


-- Returns local asset.
ENVIRONMENT["getobjects"] = newcclosure(function(Asset)
    return { InsertService:LoadLocalAsset(Asset) }
end)

ENVIRONMENT["get_objects"] = ENVIRONMENT["getobjects"]
ENVIRONMENT["GetObjects"] = ENVIRONMENT["getobjects"]

-- Returns the script responsible for the currently running function.
ENVIRONMENT["getcallingscript"] = (function() return getgenv(0)["script"] end)
ENVIRONMENT["get_calling_script"] = ENVIRONMENT["getcallingscript"]
ENVIRONMENT["GetCallingScript"] = ENVIRONMENT["getcallingscript"]

-- Generates a new closure using the bytecode of script.
ENVIRONMENT["getscriptclosure"] = (function(script)
	return function()
		return getrenv()["table"].clone(getrenv().require(script))
	end
end)

ENVIRONMENT["get_script_closure"] = ENVIRONMENT["getscriptclosure"]
ENVIRONMENT["GetScriptClosure"] = ENVIRONMENT["getscriptclosure"]

ENVIRONMENT["getscriptfunction"] = ENVIRONMENT["getscriptclosure"]
ENVIRONMENT["get_script_function"] = ENVIRONMENT["getscriptclosure"]
ENVIRONMENT["GetScriptFunction"] = ENVIRONMENT["getscriptclosure"]

local function RobloxConsoleHandler(...)
	warn("Disabled \"rconsole\" library.")
end

ENVIRONMENT["rconsoleclear"] = newcclosure(RobloxConsoleHandler)
ENVIRONMENT["consoleclear"] = ENVIRONMENT["rconsoleclear"]
ENVIRONMENT["console_clear"] = ENVIRONMENT["rconsoleclear"]
ENVIRONMENT["ConsoleClear"] = ENVIRONMENT["rconsoleclear"]

ENVIRONMENT["rconsolecreate"] = newcclosure(RobloxConsoleHandler)
ENVIRONMENT["consolecreate"] = ENVIRONMENT["rconsolecreate"]
ENVIRONMENT["console_create"] = ENVIRONMENT["rconsolecreate"]
ENVIRONMENT["ConsoleCreate"] = ENVIRONMENT["rconsolecreate"]

ENVIRONMENT["rconsoledestroy"] = newcclosure(RobloxConsoleHandler)
ENVIRONMENT["consoledestroy"] = ENVIRONMENT["rconsoledestroy"]
ENVIRONMENT["console_destroy"] = ENVIRONMENT["rconsoledestroy"]
ENVIRONMENT["ConsoleDestroy"] = ENVIRONMENT["rconsoledestroy"]

ENVIRONMENT["rconsoleinput"] = newcclosure(RobloxConsoleHandler)
ENVIRONMENT["consoleinput"] = ENVIRONMENT["rconsoleinput"]
ENVIRONMENT["console_input"] = ENVIRONMENT["rconsoleinput"]
ENVIRONMENT["ConsoleInput"] = ENVIRONMENT["rconsoleinput"]

ENVIRONMENT["rconsoleprint"] = newcclosure(RobloxConsoleHandler)
ENVIRONMENT["consoleprint"] = ENVIRONMENT["rconsoleprint"]
ENVIRONMENT["console_print"] = ENVIRONMENT["rconsoleprint"]
ENVIRONMENT["ConsolePrint"] = ENVIRONMENT["rconsoleprint"]

ENVIRONMENT["rconsolesettitle"] = newcclosure(RobloxConsoleHandler)
ENVIRONMENT["rconsolename"] = ENVIRONMENT["rconsolesettitle"]
ENVIRONMENT["consolesettitle"] = ENVIRONMENT["rconsolesettitle"]
ENVIRONMENT["console_set_title"] = ENVIRONMENT["rconsolesettitle"]
ENVIRONMENT["ConsoleSetTitle"] = ENVIRONMENT["rconsolesettitle"]

-- Returns the global environment of the game client. It can be used to access the global functions that LocalScripts and ModuleScripts use.
ENVIRONMENT["getrenv"] = newcclosure(function() return RobloxEnvironment end)

-- Returns whether the game's window is in focus. Must be true for other input functions to work.
ENVIRONMENT["isrbxactive"] = newcclosure(function()
    return ClientInfo["IsWindowFocused"]
end)

ENVIRONMENT["is_rbx_active"] = ENVIRONMENT["isrbxactive"]
ENVIRONMENT["IsRbxActive"] = ENVIRONMENT["isrbxactive"]

ENVIRONMENT["isgameactive"] = ENVIRONMENT["isrbxactive"]
ENVIRONMENT["is_game_active"] = ENVIRONMENT["isrbxactive"]
ENVIRONMENT["IsGameActive"] = ENVIRONMENT["isrbxactive"]

UserInputService["WindowFocused"]:Connect(function()
    ClientInfo["IsWindowFocused"] = true
end)

UserInputService["WindowFocusReleased"]:Connect(function()
    ClientInfo["IsWindowFocused"] = false
end)

-- Dispatches a left mouse button click.
ENVIRONMENT["mouse1click"] = newcclosure(function()
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
end)

ENVIRONMENT["Mouse1Click"] = ENVIRONMENT["mouse1click"]

-- Dispatches a left mouse button press.
ENVIRONMENT["mouse1press"] = newcclosure(function()
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
end)

ENVIRONMENT["Mouse1Press"] = ENVIRONMENT["mouse1press"]

-- Dispatches a left mouse button release.
ENVIRONMENT["mouse1release"] = newcclosure(function()
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
end)

ENVIRONMENT["Mouse1Release"] = ENVIRONMENT["mouse1release"]

-- Dispatches a right mouse button click.
ENVIRONMENT["mouse2click"] = newcclosure(function()
    VirtualInputManager:SendMouseButtonEvent(0, 0, 1, true, game, 1)
    VirtualInputManager:SendMouseButtonEvent(0, 0, 1, false, game, 1)
end)

ENVIRONMENT["Mouse2Click"] = ENVIRONMENT["mouse2click"]

-- Dispatches a right mouse button press.
ENVIRONMENT["mouse2press"] = newcclosure(function()
    VirtualInputManager:SendMouseButtonEvent(0, 0, 1, true, game, 1)
end)

ENVIRONMENT["Mouse2Press"] = ENVIRONMENT["mouse2press"]

-- Dispatches a right mouse button release.
ENVIRONMENT["mouse2release"] = newcclosure(function()
    VirtualInputManager:SendMouseButtonEvent(0, 0, 1, false, game, 1)
end)

ENVIRONMENT["Mouse2Release"] = ENVIRONMENT["mouse2release"]

-- Moves the mouse cursor to the specified absolute position.
ENVIRONMENT["mousemoveabs"] = newcclosure(function(x, y)
    VirtualInputManager:SendMouseMoveEvent(x, y, game)
end)

ENVIRONMENT["MouseMoveAbs"] = ENVIRONMENT["mousemoveabs"]

-- Adjusts the mouse cursor by the specified relative amount.
ENVIRONMENT["mousemoverel"] = newcclosure(function(x, y)
    local MouseLocation = UserInputService:GetMouseLocation()
    VirtualInputManager:SendMouseMoveEvent(MouseLocation.X + x, MouseLocation.Y + y, game)
end)

ENVIRONMENT["MouseMoveRel"] = ENVIRONMENT["mousemoverel"]

-- Dispatches a mouse scroll by the specified number of pixels.
ENVIRONMENT["mousescroll"] = newcclosure(function(Pixels)
    VirtualInputManager:SendMouseWheelEvent(0, 0, Pixels > 0, game)
end)

ENVIRONMENT["MouseScroll"] = ENVIRONMENT["mousescroll"]

--[[
	Dispatches a click or hover event to the given ClickDetector. When absent, `distance` defaults to zero, and `event` defaults to "MouseClick".
	Possible input events include 'MouseClick', 'RightMouseClick', 'MouseHoverEnter', and 'MouseHoverLeave'.
]]
ENVIRONMENT["fireclickdetector"] = newcclosure(function(Target)
	assert(typeof(Target) == "Instance", "invalid argument #1 to 'fireclickdetector' (Instance expected, got " .. type(Target) .. ") ", 2)
	local ClickDetector = Target:FindFirstChild("ClickDetector") or Target
	local PreviousParent = ClickDetector["Parent"]

	local NewPart = Instance.new("Part", getrenv()["workspace"])
	do
		NewPart["Transparency"] = 1
		NewPart["Size"] = Vector3.new(30, 30, 30)
		NewPart["Anchored"] = true
		NewPart["CanCollide"] = false
		getrenv()["task"].delay(15, function()
			if NewPart:IsDescendantOf(getrenv()["game"]) then
				NewPart:Destroy()
			end
		end)
		ClickDetector["Parent"] = NewPart
		ClickDetector["MaxActivationDistance"] = math.huge
	end

	local VirtualUser = getrenv()["game"]:FindService("VirtualUser") or getrenv()["game"]:GetService("VirtualUser")

	local HeartbeatConnection = RunService["Heartbeat"]:Connect(function()
		local CurrentCamera = getrenv()["workspace"]["CurrentCamera"] or getrenv()["workspace"]["Camera"]
		NewPart["CFrame"] = CurrentCamera["CFrame"] * CFrame.new(0, 0, -20) * CFrame.new(CurrentCamera["CFrame"]["LookVector"]['X'], CurrentCamera["CFrame"]["LookVector"]['Y'], CurrentCamera["CFrame"]["LookVector"]['Z'])
		VirtualUser:ClickButton1(Vector2.new(20, 20), CurrentCamera["CFrame"])
	end)

	ClickDetector["MouseClick"]:Once(function()
		HeartbeatConnection:Disconnect()
		ClickDetector["Parent"] = PreviousParent
		NewPart:Destroy()
	end)
end)

ENVIRONMENT["fire_click_detector"] = ENVIRONMENT["fireclickdetector"]
ENVIRONMENT["FireClickDetector"] = ENVIRONMENT["fireclickdetector"]

-- Dispatches a ProximityPrompt.
ENVIRONMENT["fireproximityprompt"] = (function(ProximityPrompt, Amount, Skip)
	assert(typeof(ProximityPrompt) == "Instance", "invalid argument #1 to 'fireproximityprompt' (Instance expected, got " .. typeof(ProximityPrompt) .. ") ", 2)
	assert(ProximityPrompt:IsA("ProximityPrompt"), "invalid argument #1 to 'fireproximityprompt' (ProximityPrompt expected, got " .. ProximityPrompt["ClassName"] .. ") ", 2)

	Amount = Amount or 1
	Skip = Skip or false

	assert(type(Amount) == "number", "invalid argument #2 to 'fireproximityprompt' (number expected, got " .. type(Amount) .. ") ", 2)
	assert(type(Skip) == "boolean", "invalid argument #2 to 'fireproximityprompt' (boolean expected, got " .. type(Amount) .. ") ", 2)

	local OldHoldDuration = ProximityPrompt.HoldDuration
	local OldMaxDistance = ProximityPrompt.MaxActivationDistance

	ProximityPrompt["MaxActivationDistance"] = 9e9
	ProximityPrompt:InputHoldBegin()

	for i = 1, Amount or 1 do
		if Skip then
			ProximityPrompt["HoldDuration"] = 0
		else
			getrenv()["task"].wait(ProximityPrompt["HoldDuration"] + 0.01)
		end
	end

	ProximityPrompt:InputHoldEnd()
	ProximityPrompt["MaxActivationDistance"] = OldMaxDistance
	ProximityPrompt["HoldDuration"] = OldHoldDuration
end)

ENVIRONMENT["fire_proximity_prompt"] = ENVIRONMENT["fireproximityprompt"]
ENVIRONMENT["FireProximityPrompt"] = ENVIRONMENT["fireproximityprompt"]

-- Creates a list of Connection objects for the functions connected to `signal`.
ENVIRONMENT["getconnections"] = newcclosure(function(Event)
    assert(typeof(Event) == "RBXScriptSignal", "Argument must be a RBXScriptSignal")

    local Connections = {}

    local Connection = Event:Connect(function() end)
    
    local ConnectionInfo = {
        ["Enabled"] = true,
        ["ForeignState"] = false,
        ["LuaConnection"] = true,
        ["Function"] = function() end,
        ["Thread"] = getrenv()["coroutine"].create(function() end),
        ["Fire"] = function() Connection:Fire() end,
        ["Defer"] = function() task.defer(Connection["Fire"], Connection) end,
        ["Disconnect"] = function() Connection:Disconnect() end,
        ["Disable"] = function() ConnectionInfo["Enabled"] = false end,
        ["Enable"] = function() ConnectionInfo["Enabled"] = true end,
    }

    getrenv()["table"].insert(Connections, ConnectionInfo)

    Connection:Disconnect()
    return Connections
end)

ENVIRONMENT["get_connections"] = ENVIRONMENT["getconnections"]
ENVIRONMENT["GetConnections"] = ENVIRONMENT["getconnections"]

local _isscriptable = clonefunction(isscriptable)
local _setscriptable = clonefunction(setscriptable)
local ScriptableCache = {}

--[[
	Returns the value of a hidden property of `object`, which cannot be indexed normally.
	If the property is hidden, the second return value will be `true`. Otherwise, it will be `false`.
]]
ENVIRONMENT["gethiddenproperty"] = newcclosure(function(Inst, Idx) 
	assert(typeof(Inst) == "Instance", "invalid argument #1 to 'gethiddenproperty' [Instance expected]", 2);
	local Was = _isscriptable(Inst, Idx);
	_setscriptable(Inst, Idx, true)

	local Value = Inst[Idx]
	_setscriptable(Inst, Idx, Was)

	return Value, not Was
end)

ENVIRONMENT["get_hidden_property"] = ENVIRONMENT["gethiddenproperty"]
ENVIRONMENT["GetHiddenProperty"] = ENVIRONMENT["gethiddenproperty"]

-- Sets the value of a hidden property of `object`, which cannot be set normally. Returns whether the property was hidden.
ENVIRONMENT["sethiddenproperty"] = (function(Inst, Idx, Value) 
	assert(typeof(Inst) == "Instance", "invalid argument #1 to 'sethiddenproperty' [Instance expected]", 2);
	local Was = _isscriptable(Inst, Idx);
	_setscriptable(Inst, Idx, true)

	Inst[Idx] = Value

	_setscriptable(Inst, Idx, Was)

	return not Was
end)

ENVIRONMENT["set_hidden_property"] = ENVIRONMENT["sethiddenproperty"]
ENVIRONMENT["SetHiddenProperty"] = ENVIRONMENT["sethiddenproperty"]

ENVIRONMENT["isscriptable"] = newcclosure(function(Inst: Instance, Property: string)
    local InstanceCache = ScriptableCache[Inst]
    if InstanceCache then
        local Value = InstanceCache[Property]
        if Value ~= nil then
            return Value
        end
    end
    return _isscriptable(Inst, Property)
end)

ENVIRONMENT["is_scriptable"] = ENVIRONMENT["isscriptable"]
ENVIRONMENT["IsScriptable"] = ENVIRONMENT["isscriptable"]

ENVIRONMENT["setscriptable"] = newcclosure(function(Inst: Instance, Property: string, Scriptable: boolean)
    local WasScriptable = _isscriptable(Inst, Property)
    if ScriptableCache[Inst] == nil then
        ScriptableCache[Inst] = {}
    end
    ScriptableCache[Inst][Property] = Scriptable
    return WasScriptable
end)

ENVIRONMENT["set_scriptable"] = ENVIRONMENT["setscriptable"]
ENVIRONMENT["SetScriptable"] = ENVIRONMENT["setscriptable"]

local NewIndex; NewIndex = hookmetamethod(game, "__newindex", function(t, k, v)
    if checkcaller() then
        local Cache = ScriptableCache[t]
        if Cache and Cache[k] ~= nil and _isscriptable(t, k) ~= Cache[k] then
            _setscriptable(t, k, Cache[k])
            local s, r = pcall(function()
                NewIndex(t, k, v)
            end)
            _setscriptable(t, k, not Cache[k])
            if not s then
                error(r)
            end
            return
        end
    end
    NewIndex(t, k, v)
end)

-- REMVOED FOR NOW BECAUSE UNSURE IF SETCLIPBOARD IS DEFINED
-- ENVIRONMENT["setrbxclipboard"] = setclipboard
-- ENVIRONMENT["set_rbx_clipboard"] = setclipboard
-- ENVIRONMENT["SetRbxClipboard"] = setclipboard

-- Compresses `data` using LZ4 compression.
ENVIRONMENT["lz4compress"] = newcclosure(function(Data)
    local Out, i, DataLen = {}, 1, #Data

    while i <= DataLen do
        local BestLen, BestDist = 0, 0

        for Dist = 1, math.min(i - 1, 65535) do
            local MatchStart, Len = i - Dist, 0

            while i + Len <= DataLen and Data:sub(MatchStart + Len, MatchStart + Len) == Data:sub(i + Len, i + Len) do
                Len += 1
                if Len == 65535 then break end
            end

            if Len > BestLen then BestLen, BestDist = Len, Dist end
        end

        if BestLen >= 4 then
            getrenv()["table"].insert(Out, getrenv()["string"].char(0) .. getrenv()["string"].pack(">I2I2", BestDist - 1, BestLen - 4))
            i += BestLen
        else
            local LitStart = i

            while i <= DataLen and (i - LitStart < 15 or i == DataLen) do i += 1 end
            getrenv()["table"].insert(Out, getrenv()["string"].char(i - LitStart) .. Data:sub(LitStart, i - 1))
        end
    end
    return getrenv()["table"].concat(Out)
end)

ENVIRONMENT["lz4_compress"] = ENVIRONMENT["lz4compress"]
ENVIRONMENT["Lz4Compress"] = ENVIRONMENT["lz4compress"]

-- Decompresses `data` using LZ4 compression, with the decompressed size specified by `size`.
ENVIRONMENT["lz4decompress"] = newcclosure(function(Data, Size)
    local Out, i, DataLen = {}, 1, #Data

    while i <= DataLen and #getrenv()["table"].concat(Out) < Size do
        local Token = Data:byte(i)
        i = i + 1

        if Token == 0 then
            local Dist, Len = getrenv()["string"].unpack(">I2I2", Data:sub(i, i + 3))

            i = i + 4
            Dist = Dist + 1
            Len = Len + 4

            local Start = #getrenv()["table"].concat(Out) - Dist + 1
            local Match = getrenv()["table"].concat(Out):sub(Start, Start + Len - 1)

            while #Match < Len do
                Match = Match .. Match
            end

            getrenv()["table"].insert(Out, Match:sub(1, Len))
        else
            getrenv()["table"].insert(Out, Data:sub(i, i + Token - 1))
            i = i + Token
        end
    end

    return getrenv()["table"].concat(Out):sub(1, Size)
end)

ENVIRONMENT["lz4_decompress"] = ENVIRONMENT["lz4decompress"
ENVIRONMENT["Lz4Decompress"] = ENVIRONMENT["lz4decompress"

local function MessageBoxHandler(...)
	warn("Disabled function \"messagebox\".")
end

ENVIRONMENT["messagebox"] = newcclosure(MessageBoxHandler)
ENVIRONMENT["message_box"] = newcclosure(MessageBoxHandler)
ENVIRONMENT["MessageBox"] = newcclosure(MessageBoxHandler)

local function QueueOnTeleportHandler(...)
	warn("Disabled function \"queue_on_teleport\".")
end

ENVIRONMENT["queueonteleport"] = newcclosure(QueueOnTeleportHandler)
ENVIRONMENT["queue_on_teleport"] = newcclosure(QueueOnTeleportHandler)
ENVIRONMENT["QueueOnTeleport"] = newcclosure(QueueOnTeleportHandler)

local CurrentFps, _Task = nil, nil

-- Sets the in-game FPS cap to `fps`. If `fps` is 0, the FPS cap is disabled.
ENVIRONMENT["setfpscap"] = newcclosure(function(NewCap)
    if _Task then
        getrenv()["task"].cancel(_Task)
        _Task = nil
    end

    if NewCap and NewCap > 0 and NewCap < 10000 then
        CurrentFps = NewCap
        local Interval = 1 / NewCap

        _Task = getrenv()["task"].spawn(function()
            while true do
                local Start = getrenv()["os"].clock()
                RunService["Heartbeat"]:Wait()
                while getrenv()["os"].clock() - Start < Interval do end
            end
        end)
    else 
        CurrentFps = nil
    end
end)

ENVIRONMENT["set_fps_cap"] = ENVIRONMENT["setfpscap"]
ENVIRONMENT["SetFpsCap"] = ENVIRONMENT["setfpscap"]

-- Returns the in-game FPS cap.
ENVIRONMENT["getfpscap"] = newcclosure(function()
	return getrenv()["workspace"]:GetRealPhysicsFPS()
end)

ENVIRONMENT["get_fps_cap"] = ENVIRONMENT["getfpscap"]
ENVIRONMENT["GetFpsCap"] = ENVIRONMENT["getfpscap"]

-- Returns a list of ModuleScripts that have been loaded. If `excludeCore` is true, CoreScript-related modules will not be included in the list.
ENVIRONMENT["getloadedmodules"] = newcclosure(function()
    local LoadedModules = {}
    for _, v in pairs(getrenv()["game"]:GetDescendants()) do
        if typeof(v) == "Instance" and v:IsA("ModuleScript") then getrenv()["table"].insert(LoadedModules, v) end
    end
    return LoadedModules
end)

ENVIRONMENT["get_loaded_modules"] = ENVIRONMENT["getloadedmodules"]
ENVIRONMENT["GetLoadedModules"] = ENVIRONMENT["getloadedmodules"]

-- Returns a list of scripts that are currently running.
ENVIRONMENT["getrunningscripts"] = newcclosure(function()
    local RunningScripts = {}
    for _, v in ipairs(Players["LocalPlayer"]:GetDescendants()) do
        if v:IsA("LocalScript") or v:IsA("ModuleScript") then
            RunningScripts[#RunningScripts + 1] = v
        end
    end
    return RunningScripts
end)

ENVIRONMENT["get_running_scripts"] = ENVIRONMENT["getrunningscripts"]
ENVIRONMENT["GetRunningScripts"] = ENVIRONMENT["getrunningscripts"]

ENVIRONMENT["getscripts"] = ENVIRONMENT["getrunningscripts"]
ENVIRONMENT["get_scripts"] = ENVIRONMENT["getrunningscripts"]
ENVIRONMENT["GetScripts"] = ENVIRONMENT["getrunningscripts"]

-- Returns a SHA384 hash of the script's bytecode. This is useful for detecting changes to a script's source code.
ENVIRONMENT["getscripthash"] = newcclosure(function(Inst)
    assert(typeof(Inst) == "Instance", "invalid argument #1 to 'getscripthash' (Instance expected, got " .. typeof(Inst) .. ") ", 2)
	assert(Inst:IsA("LuaSourceContainer"), "invalid argument #1 to 'getscripthash' (LuaSourceContainer expected, got " .. Inst["ClassName"] .. ") ", 2)
	return Inst:GetHash()
end)

-- Returns the global environment of the given script. It can be used to access variables and functions that are not defined as local.
ENVIRONMENT["getsenv"] = newcclosure(function(script)
    assert(typeof(script) == "Instance", "invalid argument #1 to 'getsenv' [ModuleScript or LocalScript expected]", 2);
	assert((script:IsA("LocalScript") or script:IsA("ModuleScript")), "invalid argument #1 to 'getsenv' [ModuleScript or LocalScript expected]", 2)
	if (script:IsA("LocalScript") == true) then 
		for _, v in getreg() do
			if (type(v) == "function") then
				if getfenv(v)["script"] then
					if getfenv(v)["script"] == script then
						return getfenv(v)
					end
				end
			end
		end
	else
		local Reg = getreg()
		local Senv = {}

		if #Reg == 0 then
			return require(script)
		end

		for _, v in next, Reg do
			if type(v) == "function" and islclosure(v) then
				local Fenv = getfenv(v)
				local Raw = rawget(Fenv, "script")
				if Raw and Raw == script then
					for i, k in next, Fenv do
						if i ~= "script" then
							rawset(Senv, i, k)
						end
					end
				end
			end
		end
		return Senv
	end
end)



return ENVIRONMENT
