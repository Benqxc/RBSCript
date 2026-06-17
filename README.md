# RBSCript

> **Warning:** This repository contains scripts intended for use with Roblox executors. Using exploits violates [Roblox Terms of Use](https://en.help.roblox.com/hc/en-us/articles/203313410). This code is provided for educational review only.

Lua script for the Roblox game "Dig to Earth's CORE!".

## Security Risks

- Loads external code via `loadstring(game:HttpGet(...))` — **remote code execution risk**
- Spams `RemoteEvent` calls — may trigger anti-cheat
- Third-party URL (`pastefy.app`) can change without notice

## Files

| File | Description |
|------|-------------|
| `Dig to Earth's CORE!.lua` | Auto-spin, auto-dig, pet unlock GUI |

## License

No license — all rights reserved. Not recommended for redistribution.
