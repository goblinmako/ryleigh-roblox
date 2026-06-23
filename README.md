# Ryleigh's Roblox Game 🎮

This repository is the **backup and version history** for Ryleigh's Roblox game,
built in **Roblox Studio**. Each time you upload a new copy, GitHub keeps the old
ones — so you can always go back to an earlier version.

## 💾 Save a new version (do this whenever you want to back up your progress)

1. In **Roblox Studio**, open the game.
2. Go to **File → Save to File As…**
3. In the save dialog, set the file type to **Roblox XML Place Files (`*.rbxlx`)**
   and name it **`ryleigh.rbxlx`**.  *(Use `.rbxlx`, not `.rbxl` — the XML version
   tracks changes better.)*
4. Come to this repo on GitHub → **Add file ▸ Upload files** → drag in
   `ryleigh.rbxlx` → type a short note like *"added the obby"* → **Commit changes**.

That's it — your game is saved. Uploading again later replaces the file, and the
previous version stays in the history.

## ↩️ Go back to an older version

1. In this repo click **`ryleigh.rbxlx`** → **History** (or the clock icon) to see
   past versions, or just **Download** the current one.
2. Open the downloaded `.rbxlx` in Roblox Studio (**File → Open from File…**).

## 🔧 Open in Studio with Rojo

Rojo syncs this repo's script files directly into Roblox Studio as you edit them — no manual saving needed. Use this when the game has real scripts you want to track line-by-line.

**One-time setup:**

1. Install Rojo on your computer — download the latest release from [rojo.space](https://rojo.space) and put the `rojo` binary somewhere on your PATH (e.g. `/usr/local/bin`).
2. Inside Roblox Studio, go to **Plugins → Manage Plugins** and install the **Rojo** plugin (search the Roblox plugin marketplace).

**Each time you want to sync:**

1. Open a terminal, `cd` into this repo folder.
2. Run: `rojo serve`
3. In Roblox Studio, click the **Rojo** plugin button → **Connect**.
4. Studio will now stay in sync with the files in `src/` as you edit them.

> **Tip for Ryleigh:** you don't need Rojo to start. Plain file saves (above) are fine. Switch to Rojo when the scripts get big enough that you want to see exactly what changed.
