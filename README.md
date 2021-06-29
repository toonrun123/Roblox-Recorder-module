# Roblox Recorder module

# What is  Recorder module?
Record Your Models When have moving.


# Functions
 - Record
 - StopRecording
 - Play

# How to use

## Record
 ```lua
  Module:Record(Name,Model)
 ```
 
 ## Stop Record
  ```lua
  Module:Stop(Name)
 ```
 
 ## Playing Record
 ```lua
 Module:Play(Name,ModelWantPlaying)
 ```
 # Example
```lua
local Record = require(game.ReplicatedStorage:WaitForChild("RecorderModule"))

Record:Record("Died",game.Players.LocalPlayer.Character)
game.Players.LocalPlayer.Character:BreakJoints()
wait(1)
Record:Stop("Died")
wait(1)
Record:Play("Died",game.Players.LocalPlayer.Character)
```
