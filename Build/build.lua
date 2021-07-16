--[[
	Insert this into the workspace, make sure the script is named "Build",
	and run "loadstring(workspace.Build.Source)()" in the command bar
	to build using the most recent files.
]]

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
local requestWait = 0.5
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

-- Load API modules
warn("Downloading APIs...")

wait(requestWait)

local apis = http:JSONDecode(http:GetAsync("https://api.github.com/repos/astriaInight/RobloxAPI/contents/APIs?ref=main"))
for _, api in pairs(apis) do
	local apiModule = Instance.new("ModuleScript")
	apiModule.Name = api.name:gsub(".lua", "") -- Removes .lua from name
	
	wait(requestWait)
	
	apiModule.Source = http:GetAsync(api.download_url) -- Actually the raw data in this case
	apiModule.Parent = module
	
	print("Loaded API: " .. apiModule.Name .. ".")
end

-- Compile
warn("Compiling...")

local builtStatement = os.date("Built on %x at %X", os.clock())
module.Source = templateScript:format(builtStatement, sources.license, sources.mainModule)
module.Parent = workspace

print("Script compiled to workspace.")
warn("Build finished!")
