# The Lunatic RPG Framework
Lunatic is an adventure game framework with an inbuilt map/game editor built in Lua with LÖVE (the LÖVE Engine).

## Usage
Assuming you have LÖVE installed on your system, you can run the game with the following command:
```bash
open -a love .
```
To open the map editor, use:
```bash
open -a love ./map_editor
```

## Project Structure
All modules are contained within `/scripts/` and expose one of three methods in the `M` table.

- `init()`
- `update()`
- `render()`
