# Architecture — RBSCript

Single Lua file executed in a Roblox executor environment.

```
Dig to Earth's CORE!.lua
├── HttpGet → pastefy.app (external UI library)
├── RemoteEvent spam loops (SpinPrizeEvent, DigEvent)
└── GUI buttons (auto-spin, auto-dig, unlock pets)
```

No modular structure. No local build step.

**Supply chain:** UI library loaded at runtime from a third-party paste service — highest risk component.
