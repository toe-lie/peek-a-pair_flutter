# Peek-a-Pair — Master Game Design Document (GDD)

---
## 📜 PART 1: CORE GAME DESIGN DOCUMENT
---

## 🎮 Game Overview
**Peek-a-Pair** is a playful, family-friendly memory game where players flip cards to find matching pairs. The game is designed to be visually delightful, thematically varied, and scalable with level progression, themes, and light narrative touches.

---

## 📖 Character & Story

### Mascot: Ollie the Owl 🦉
Ollie is the game's friendly, curious, and fun mascot. He acts as the player's guide and avatar on their journey through the game's worlds.

### The Story Behind the Name
The name "Ollie" is short for **Oliver**, a name with historical roots meaning "ancestor's descendant." This hints at the deeper story of our hero:

Ollie is the youngest descendant of a long and legendary line of "Grand Master" memory-keepers. His ancestors were the greatest Peek-a-Pair champions in the land, known for their incredible wisdom and memory. His great-great-grandfather was the first to ever master the "Final Peek."

Now, it is young Ollie's turn to go on his own journey. He must travel the world map, solve the unique puzzles in each land, and prove that he is a worthy successor to his family's legacy. His ultimate goal is to reach "The Final Peek" and take his place as a true memory master.

---

## 💎 Persistent UI & Menus

The main menu buttons are integrated directly onto the World Map screen as non-intrusive icon overlays to maintain immersion.

- **Game Logo & Mascot:** The `Peek-a-Pair` logo and Ollie the Owl are central to the game's branding and appear on loading screens and promotional materials.
- **Tagline:** _"Peek fast. Pair smart!"_
- **Overlay Buttons on World Map:**
    - `⚙️ Settings`: An icon button, likely in a corner, that opens a settings dialog or screen.
    - `🎨 Themes / Worlds`: This is handled by swiping left/right between world maps in the `WorldPagerScreen`.
    - `👣 How to Play`: An icon button that opens a simple tutorial overlay.

---

## 🎨 Visual Style

**Color Palette: Soft Pastels**
- Mint Green `#A8E6CF`
- Peachy Coral `#FFD3B6`
- Pale Yellow `#FFFAAA`
- Sky Blue `#B3E5FC`
- Soft Lilac `#D1C4E9`

**Mascot:** Ollie the Owl 🦉 — friendly, curious, and fun.

### Sound Design
The guiding principle for sound is to be gentle, happy, and responsive, enhancing the "soft pastel" visual style without ever being harsh or annoying.

#### 1. UI Sounds (User Interface)
* **Button Click:** A soft, rounded "boop" or a gentle "thwick."
* **Screen Transition:** A light, airy "whoosh" or a quick, gentle harp glissando.
* **Star Collection:** Each of the three stars on the win screen gets a slightly higher-pitched "ding!"
* **Unlock New Item:** A magical, ascending series of chimes with a soft, warm synth pad.

#### 2. Gameplay Sounds
* **Card Flip:** A soft "pop." Use 2-3 similar but slightly different variations that play randomly to avoid repetition.
* **Card Match (Success):** A short, rewarding "sparkle jingle"—a happy two-note melody from a xylophone and a tiny bell.
* **Card Mismatch (Failure):** A gentle, non-punishing sound. Either a cute "uh-oh!" voice line or a soft, descending "womp" sound.
* **Level Win:** A triumphant, happy musical fanfare combined with a confetti/rustling sound.

#### 3. Music & Ambience
* **Main Theme (World Map):** A gentle, happy, and looping theme. Light acoustic guitar, ukulele, or soft piano.
* **Gameplay Music:** A more subtle, atmospheric version of the main theme with less melody to help the player focus.
* **World-Specific Ambience (On World Map):**
    * **Forest Friends:** Faint sounds of birds chirping.
    * **Night Sky:** A very soft, ethereal "shimmer" or "twinkle."
    * **Ocean Quest:** The gentle sound of bubbles.

#### 4. Advanced Principles & Player Feedback
* **Streak/Combo Sound:** To reward skilled play, a sound will be implemented for consecutive successful matches. This could be an ascending arpeggio, where each successful match adds the next note in a pleasant musical sequence.
* **Thematic UI Sounds:** To deepen immersion, core UI sounds can be subtly layered with world-specific textures. For example, the button click sound on the "Sweet Street" map might include a faint "squish" sound, while on "Ocean Quest" it might have a "bubble" sound.
* **Use of Silence:** Music volume can be subtly lowered during key moments, such as when the "Level Complete" dialog is on screen, to focus the player's attention on their results and choices.

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
---

## 📜 APPENDIX A: DESIGN SUPPLEMENTS
---

### Mascot Design Strategy: Ollie the Owl

This section formalizes the design strategy for the game's mascot, Ollie the Owl.

**Guiding Principle: The Hybrid Approach**
To balance strong branding with thematic charm and a manageable workload, we will use a hybrid approach for Ollie's design throughout the game.

1.  **One Core Mascot Design:**
    * There will be one single, consistent, high-quality design for Ollie.
    * This core design will be used for the app logo, title screen, branding, and as the default character model to ensure Ollie is always recognizable.

2.  **Thematic Accessories per World:**
    * To add thematic flair and create reward opportunities, the core Ollie model will be adorned with a small, unique accessory when displayed on each world map.
    * **Examples:**
        * **Sweet Street 🍰:** Ollie wears a small candy-striped scarf.
        * **Night Sky 🚀:** Ollie has a little bubble helmet on.
        * **Ocean Quest 🌊:** Ollie wears a tiny snorkel mask.
        * **Jungle Jam 🐒:** Ollie wears an explorer's hat.

---

### World Asset Checklist

This checklist is a template for all assets required to build a new world in the game.

**1. World Map Screen Assets**
- [ ] **World Map Background**
- [ ] **Custom Header / Banner**
- [ ] **Level Node (Enabled)**
- [ ] **Level Node (Disabled)**
- [ ] **Player Mascot on Map**

**2. Gameplay Screen Assets (Theme-Specific)**
- [ ] **Game Screen Background**
- [ ] **Card Back Design**
- [ ] **Card Fronts Set**

**3. General UI & Reward Assets**
- [ ] **Star Icon (Filled)**
- [ ] **Star Icon (Empty)**
- [ ] **World-Specific Icons** (e.g., Timer icon)
- [ ] **Boss Level Unlock Asset**

---

### Complete Card Front Sets

**World 1: Forest Friends 🌲**
* **Pairs:** Squirrel, Bear Cub, Fox, Deer Fawn, Rabbit, Hedgehog, Little Owl, Raccoon.

**World 2: Sweet Street 🍰**
* **Pairs:** Cupcake, Lollipop, Donut, Ice Cream, Cookie, Hard Candy, Cake Slice, Chocolate Bar.

**World 3: Night Sky 🚀**
* **Pairs:** Rocket Ship, Planet, Moon, Alien UFO, Astronaut, Comet, Star, Constellation.

**World 4: Jungle Jam 🐒**
* **Pairs:** Monkey, Toucan, Sloth, Tiger Cub, Snake, Dart Frog, Banana, Jungle Leaf.

**World 5: Ocean Quest 🌊**
* **Pairs:** Clownfish, Crab, Octopus, Sea Turtle, Seahorse, Dolphin, Treasure Chest, Starfish.

**World 6: Memory Vault 🧠**
* **Triplets:** Red Circles, Blue Squares, Yellow Triangles, Green Hexagons, Purple Stars, Orange Plus Signs.

**World 7: Fairy Flicker 🧚**
* **Triplets:** Magic Wands, Potion Bottles, Power Crystals, Pixie Mushrooms, Fairy Lanterns, Magic Scrolls.

**World 8: The Final Peek 🏆**
* **Pairs:** Gold Trophy, Diamond, Winner's Crown, Award Ribbon, Laurel Wreath, Gold Medal, Golden Key, Flaming Torch.

---
---

## 📜 APPENDIX B: ASSET PROMPTS COOKBOOK
---

This document contains the final, successful Midjourney prompts used to generate the core visual assets for the game.

### 1. Branding & Core UI Assets

**App Logo (Classic Mascot)**
```
/imagine prompt: app logo icon, a modern and simple logo for a kids game, a clean and symmetrical icon of a cute baby owl's face (Ollie the mascot), looking directly at the viewer with a friendly smile, minimalist flat 2D vector logo, using simple geometric shapes, clean bold lines, soft pastel color palette, enclosed in a squircle shape with a peachy coral background --no text gradients shadows
```

### Mascot (Ollie the Owl) (Master Prompt)
```
/imagine prompt: full-body character design of Ollie the Owl, a super cute and friendly baby owl **wearing a simple [THEMED ACCESSORY]**, standing and waving with a cheerful expression, big curious eyes, flat vector illustration, clean bold lines, whimsical and delightful, soft pastel color palette, isolated character on a solid light grey background --no text --ar 1:1
```

---

## 2. World-Specific Assets

### World 1: Forest Friends 🌲

**Card Back Design**
```
/imagine prompt: game asset, playing card back design, a cute, stylized baby owl logo in the center, surrounded by a subtle symmetrical pattern of leaves and twigs, flat vector illustration, soft pastel colors, mint green and peachy coral, clean lines, whimsical and friendly, for a kids memory game --no text --ar 2:3
```

**Card Fronts (Master Prompt)**
```
/imagine prompt: game asset, playing card front, a cute [ANIMAL DESCRIPTION], centered character, on a simple circular background, flat vector illustration, soft pastel colors, sky blue and pale yellow, clean lines, whimsical and friendly --no text --ar 2:3
```
**Specific Card Prompts:**
- **Squirrel:** `/imagine prompt: game asset, playing card front, a cute happy squirrel with an acorn, centered character, on a simple circular background, flat vector illustration, soft pastel colors, sky blue and pale yellow, clean lines, whimsical and friendly --no text --ar 2:3`
- **Bear Cub:** `/imagine prompt: game asset, playing card front, a cute sleepy bear cub, centered character, on a simple circular background, flat vector illustration, soft pastel colors, sky blue and pale yellow, clean lines, whimsical and friendly --no text --ar 2:3`
- **Fox:** `/imagine prompt: game asset, playing card front, a cute curious fox, centered character, on a simple circular background, flat vector illustration, soft pastel colors, sky blue and pale yellow, clean lines, whimsical and friendly --no text --ar 2:3`
- **Deer Fawn:** `/imagine prompt: game asset, playing card front, a cute shy deer fawn, centered character, on a simple circular background, flat vector illustration, soft pastel colors, sky blue and pale yellow, clean lines, whimsical and friendly --no text --ar 2:3`
- **Rabbit:** `/imagine prompt: game asset, playing card front, a cute cheerful rabbit, centered character, on a simple circular background, flat vector illustration, soft pastel colors, sky blue and pale yellow, clean lines, whimsical and friendly --no text --ar 2:3`
- **Hedgehog:** `/imagine prompt: game asset, playing card front, a cute friendly hedgehog, centered character, on a simple circular background, flat vector illustration, soft pastel colors, sky blue and pale yellow, clean lines, whimsical and friendly --no text --ar 2:3`
- **Little Owl:** `/imagine prompt: game asset, playing card front, a cute wise little owl, centered character, on a simple circular background, flat vector illustration, soft pastel colors, sky blue and pale yellow, clean lines, whimsical and friendly --no text --ar 2:3`
- **Raccoon:** `/imagine prompt: game asset, playing card front, a cute clever raccoon, centered character, on a simple circular background, flat vector illustration, soft pastel colors, sky blue and pale yellow, clean lines, whimsical and friendly --no text --ar 2:3`

**World Map Background (Subtle & Clean)**
```
/imagine prompt: a minimalist and atmospheric mobile game world map background, a soft focus and dreamy forest scene, the background details are blurry and simplified, creating a gentle texture rather than sharp objects, with a faint, blurry path winding through, very subtle and muted color palette of soft greens and gentle earthy browns, designed with low contrast so that UI elements and bright yellow stars will be clearly visible on top --ar 9:16
```

**Gameplay Screen Background**
```
/imagine prompt: subtle background for a mobile game screen, a dreamy, out-of-focus magical forest, sunbeams filtering through a canopy of leaves, minimalist flat vector illustration, ultra soft pastel color palette, gentle gradients of mint green and pale sky blue, calm and serene --ar 9:16
```

**App Header / Banner (Wide)**
```
/imagine prompt: game UI header, title banner asset, a long, wide, banner-shaped whimsical hanging wooden sign that stretches across the full width of the image, decorated with cute green ivy vines, held up by ropes, center is a smooth clear space for text, isolated asset on a solid light grey background, flat vector illustration --ar 3:1 --style raw
```

### Level Node (Enabled State)
```
/imagine prompt: game UI asset, level select node, a cute, round wooden sign decorated with a small sprig of mint green leaves on the edge, with a light-colored center ready for a number to be placed on it, flat vector illustration, clean bold lines, soft pastel colors, using browns, but with accents of mint green and peachy coral to match the world map, isolated asset on a solid light grey background --no text --ar 1:1
```

### Level Node (Disabled State)
```
/imagine prompt: game UI asset, DISABLED level select node, a cute, round wooden sign decorated with a small sprig of leaves, with a simple, cute lock symbol in the center, desaturated grayscale color palette, muted tones, flat vector illustration, isolated asset on a solid light grey background --no text --ar 1:1
```

### Mascot (Ollie the Owl)
```
/imagine prompt: full-body character design of Ollie the Owl, a super cute and friendly baby owl, standing and waving with a cheerful expression, big curious eyes, flat vector illustration, clean bold lines, whimsical and delightful, soft pastel color palette, isolated character on a solid light grey background --no text --ar 1:1
```

### World 2: Sweet Street 🍰
**Card Back Design**
```
/imagine prompt: game asset, playing card back design, a cute, stylized baby owl logo in the center, surrounded by a subtle symmetrical pattern of tiny candy sprinkles and icing swirls, flat vector illustration, soft pastel colors, peachy coral and soft lilac, clean lines, whimsical and friendly, for a kids memory game --no text --ar 2:3
```

**Card Fronts (Master Prompt)**
```
/imagine prompt: game asset, playing card front, a cute [SWEET TREAT DESCRIPTION], centered character, on a simple circular background, flat vector illustration, soft pastel colors, peachy coral and soft lilac, clean lines, whimsical and friendly --no text --ar 2:3
```
**Specific Card Prompts:**
- **Cupcake:** `/imagine prompt: game asset, playing card front, a cute fluffy cupcake with sprinkles, centered character, on a simple circular background, flat vector illustration, soft pastel colors, peachy coral and soft lilac, clean lines, whimsical and friendly --no text --ar 2:3`
- **Lollipop:** `/imagine prompt: game asset, playing card front, a cute colorful swirly lollipop, centered character, on a simple circular background, flat vector illustration, soft pastel colors, peachy coral and soft lilac, clean lines, whimsical and friendly --no text --ar 2:3`
- **Donut:** `/imagine prompt: game asset, playing card front, a cute chocolate-frosted donut, centered character, on a simple circular background, flat vector illustration, soft pastel colors, peachy coral and soft lilac, clean lines, whimsical and friendly --no text --ar 2:3`
- **Ice Cream:** `/imagine prompt: game asset, playing card front, a cute wobbly scoop of ice cream, centered character, on a simple circular background, flat vector illustration, soft pastel colors, peachy coral and soft lilac, clean lines, whimsical and friendly --no text --ar 2:3`
- **Cookie:** `/imagine prompt: game asset, playing card front, a cute classic chocolate chip cookie, centered character, on a simple circular background, flat vector illustration, soft pastel colors, peachy coral and soft lilac, clean lines, whimsical and friendly --no text --ar 2:3`
- **Hard Candy:** `/imagine prompt: game asset, playing card front, a cute wrapped piece of hard candy, centered character, on a simple circular background, flat vector illustration, soft pastel colors, peachy coral and soft lilac, clean lines, whimsical and friendly --no text --ar 2:3`
- **Cake Slice:** `/imagine prompt: game asset, playing card front, a cute triangular slice of cake, centered character, on a simple circular background, flat vector illustration, soft pastel colors, peachy coral and soft lilac, clean lines, whimsical and friendly --no text --ar 2:3`
- **Chocolate Bar:** `/imagine prompt: game asset, playing card front, a cute bar of milk chocolate, centered character, on a simple circular background, flat vector illustration, soft pastel colors, peachy coral and soft lilac, clean lines, whimsical and friendly --no text --ar 2:3`

**World Map Background**
```
/imagine prompt: game world map background for a mobile game, a whimsical candy land, with cute gingerbread houses, lollipop trees, and a river of chocolate, a clear winding path made of cookie crumbs goes from bottom to top, flat vector illustration, clean bold lines, soft pastel color palette of peachy coral and soft lilac, cheerful and delicious --ar 9:16
```

**Gameplay Screen Background**
```
/imagine prompt: subtle background for a mobile game screen, a gentle, repeating pattern of candy and sweets, the shapes are simplified and look like soft-focus, blurry candy shapes floating in the distance, minimalist flat vector illustration, ultra soft pastel color palette, gentle gradients of peachy coral and soft lilac, calm and serene --ar 9:16
```

**App Header / Banner (Wide)**
```
/imagine prompt: game UI header, title banner asset, a whimsical hanging sign made out of a long gingerbread cookie, decorated with white icing swirls and colorful candy sprinkles along the edges, held up by red licorice ropes, the center is a smooth clear space ready for text, isolated asset on a solid light grey background, flat vector illustration --ar 3:1 --style raw
```

### Level Node (Enabled State)
```
/imagine prompt: game UI asset, level select node, a cute, round sugar cookie, decorated with a border of colorful candy sprinkles and white icing, with a smooth, clear center ready for a number to be placed on it, flat vector illustration, clean bold lines, soft pastel colors with accents of peachy coral and soft lilac, isolated asset on a solid light grey background --no text --ar 1:1
```

### Level Node (Disabled State)
```
/imagine prompt: game UI asset, DISABLED level select node, a cute, round sugar cookie, decorated with a border of sprinkles and icing, with a simple, cute lock symbol in the center, desaturated grayscale color palette, muted tones, flat vector illustration, isolated asset on a solid light grey background --no text --ar 1:1
```

### Mascot (Ollie the Owl)
```
/imagine prompt: full-body character design of Ollie the Owl, a super cute and friendly baby owl **wearing a simple red-and-white candy-striped scarf**, standing and waving with a cheerful expression, big curious eyes, flat vector illustration, clean bold lines, whimsical and delightful, soft pastel color palette, isolated character on a solid light grey background --no text --ar 1:1
```