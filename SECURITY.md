# Security Policy

## Critical Warnings

1. **Remote code execution** — script fetches and executes code from `pastefy.app` via `loadstring`. The remote content can change at any time.
2. **Roblox ToS** — using this script with executors violates Roblox Terms of Use and may result in account bans.
3. **No integrity checks** — downloaded Lua is not verified with checksums or signatures.

## Recommendations

- Do not run this script in production environments
- Consider making this repository private
- Remove `loadstring` + remote URL pattern entirely if repurposing the code

Report issues to [@Benqxc](https://github.com/Benqxc).
