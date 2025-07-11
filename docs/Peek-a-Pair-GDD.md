# Peek-a-Pair — Game Design Document (GDD)

## 🎮 Game Overview
**Peek-a-Pair** is a playful, family-friendly memory game where players flip cards to find matching pairs. The game is designed to be visually delightful, thematically varied, and scalable with level progression, themes, and light narrative touches.

---

## 🏠 Title Screen Layout

- Logo with owl mascot and bubbly font
- Tagline: _"Peek fast. Pair smart!"_
- Buttons: `▶️ Play Game`, `🎨 Themes`, `👣 How to Play`, `⚙️ Settings`

---

## 🎨 Visual Style

**Color Palette: Soft Pastels**
- Mint Green `#A8E6CF`
- Peachy Coral `#FFD3B6`
- Pale Yellow `#FFFAAA`
- Sky Blue `#B3E5FC`
- Soft Lilac `#D1C4E9`

**Mascot:** Ollie the Owl 🦉 — friendly, curious, and fun.

**Sound Design:**
- Flip: soft “pop”
- Match: sparkle jingle
- Mismatch: “uh-oh!”
- Win: confetti + fanfare

---

## 🗺️ Game Flow

The player's journey is central to the game flow.
1.  Title Screen
2.  **Interactive World Map** (Player sees their mascot, Ollie, on a path)
3.  Tap a Level Node → Game Screen (Grid Flip & Match)
4.  Level Win / Summary (Collect stars, see rewards)
5.  Return to World Map (Ollie the Owl moves to the next unlocked level node)
6.  Unlock the next World after meeting the requirements of the previous one.

---

## 🧩 Game Logic

**Basic Flip Match Logic:**
1.  Tap card → flip & reveal
2.  Tap second card
3.  If match: stay visible
4.  If not: delay + flip back
5.  Repeat until all matched

**Win Summary:**
- Time taken
- Moves used
- **Star Rating (Based on performance, e.g., speed or move efficiency):**
    - **⭐:** Complete the level.
    - **⭐⭐:** Beat the target score (e.g., under 30 moves or 60 seconds).
    - **⭐⭐⭐:** Achieve a perfect or near-perfect score.
- Buttons: “Next Level”, “Replay”, “Map”

---

## 🌍 World & Level Structure (Enhanced)

Progression is visualized on an interactive world map where Ollie the Owl travels along a path. Worlds are "gated" and must be unlocked, creating long-term goals. Each world introduces a new core mechanic or "twist" to keep the gameplay fresh and challenging.

### **World 1: Forest Friends 🌲**
* **Focus:** Core Memory Mechanics (Tutorial)
* **Twist:** None. This world is a stress-free introduction to the pure peek-a-pair gameplay.
* **Unlock Requirement:** Available from the start.
* **Boss Level (1-5):** Complete "Ollie's Owl Outpost" to unlock Sweet Street.

### **World 2: Sweet Street 🍰**
* **Focus:** Strategic Efficiency
* **Twist:** **Move Limits.** Levels must be completed within a specific number of moves. This introduces a puzzle-like element.
* **Unlock Requirement:** Beat the Boss Level of Forest Friends.

### **World 3: Night Sky 🚀**
* **Focus:** Speed & Pressure
* **Twist:** **Timers.** Levels must be completed before the timer runs out. This tests memory recall under pressure.
* **Unlock Requirement:** Collect 12 stars in Sweet Street.

### **World 4: Jungle Jam 🐒**
* **Focus:** Adaptability
* **Twist:** **Dynamic Obstacles.** A "Mischievous Monkey" might shuffle one or two unflipped cards mid-level, forcing the player to adapt.
* **Unlock Requirement:** Beat the Boss Level of Night Sky.

### **World 5: Ocean Quest 🌊**
* **Focus:** High-Pressure Efficiency
* **Twist:** **Combined Timers & Move Limits.** A true test of skill, requiring players to be both fast and strategically efficient.
* **Unlock Requirement:** Collect 30 stars from all previous worlds.

### **World 6: Memory Vault 🧠**
* **Focus:** Advanced Pattern Recognition
* **Twist:** **3-Card Matches (Triplets).** A fundamental shift in the game's core logic, requiring players to find three matching cards instead of two.
* **Unlock Requirement:** Beat the Boss Level of Ocean Quest.

### **World 7: Fairy Flicker 🧚**
* **Focus:** Magical Mayhem
* **Twist:** **3-Card Matches + Advanced Dynamic Obstacles.** A "Flicker Fairy" might temporarily hide a card, make two unflipped cards swap places, or briefly obscure the board.
* **Unlock Requirement:** Collect 60 stars from all previous worlds.

### **World 8: The Final Peek 🏆**
* **Focus:** Ultimate Mastery
* **Twist:** **The Gauntlet.** Levels in this world feature unpredictable combinations of all previous twists (Triplets + Timer, Triplets + Move Limits + Shuffling, etc.).
* **Boss Level (8-5):** "The Grandmaster's Grid." A massive 6x6 grid featuring triplets with both a strict timer and a tight move limit. The ultimate test of a Peek-a-Pair master.
* **Unlock Requirement:** Beat the Boss Level of Fairy Flicker.

---

## ✨ Future Features

The reward systems are directly tied to player progression through the worlds.
-   Daily challenges / timed events
-   **Collectible cards / gallery:** Sections are unlocked by earning stars. (e.g., "Collect 20 stars to unlock the 'Sweet Street' gallery!")
-   **Unlockable card skins:** Awarded for achieving 3 stars on all levels in a world.
-   Zen mode / memory challenge modes
-   **Story postcards from the mascot:** Unlocked by beating each world's Boss Level.

---

## 📦 Assets Generated So Far

-   ✅ Title Screen (with mascot & buttons)
-   ✅ App Logo (flat icon with owl and game name)
-   ✅ Forest Friends World Map (5 level signs)

---

## 📁 File Format

This file serves as a lightweight Game Design Document (`Peek-a-Pair-GDD.md`). In game dev, it’s often called a **GDD**, or you can call it a **Design Bible** or just `README.md` in your game folder.