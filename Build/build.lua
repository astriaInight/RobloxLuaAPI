-- Insert this into the workspace and run "loadstring(workspace.Build.Source)()" to build

-- Variables
local urls = {
	mainModule = "https://raw.githubusercontent.com/astriaInight/RobloxAPI/main/module.lua",
	license = "https://raw.githubusercontent.com/astriaInight/RobloxAPI/main/LICENSE"
}
local sources = {
	mainModule = nil,
	license = nil
}
local http = game:GetService("HttpService")
local requestWait = 4
local templateScript = "-- RobloxAPI --\n-- %s\n\n--[[\n%s\n]]\n\n%s"

-- Functions
-- nothing here yet

-- Load data
warn("Loading data...")

local module = Instance.new("ModuleScript")
module.Name = "RBXAPI"

sources.mainModule = http:GetAsync(urls.mainModule)
print("Loaded module source.")

wait(requestWait)

sources.license = http:GetAsync(urls.license)
print("Loaded license.")

-- Compile
warn("Compiling...")

local builtStatement = os.date("Built on %x at %X", os.clock())
module.Source = templateScript:format(builtStatement, sources.license, sources.mainModule)
module.Parent = workspace

print("Script compiled to workspace.")
warn("Build finished!")
