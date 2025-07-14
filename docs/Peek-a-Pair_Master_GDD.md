# Peek-a-Pair — Master Game Design Document (GDD)
*Version 1.1*

---
### **DOCUMENT CONTROL**
---
*This section tracks major changes to the GDD, ensuring all team members are aware of the latest decisions.*

#### **Revision History**
| Version | Date         | Author     | Summary of Changes                                                                                              |
|:--------|:-------------|:-----------|:----------------------------------------------------------------------------------------------------------------|
| **v1.1** | **2025-07-13** | **Gemini AI** | **Refactored entire GDD into a scalable, modular structure. Integrated [PROPOSED] engagement & social mechanics.** |
| v1.0    | (Prev. Date) | (Your Name)| Initial creation of the Master GDD.                                                                            |

---
## PART 1: EXECUTIVE PILLARS
---
*(This section is the 10,000-foot view. It's for quickly communicating the game's core vision.)*

### **1.0 Game Overview**
* **1.1 Game Concept & Hook**
    * Peek-a-Pair is a playful, family-friendly memory game where players flip cards to find matching pairs. The game is designed to be visually delightful, thematically varied, and scalable with level progression, themes, and light narrative touches.
* **1.2 Target Audience & Platform**
    * **Audience:** Families, casual gamers, and players of all ages looking for a relaxing yet engaging puzzle experience.
    * **Platform:** Mobile (iOS & Android).
* **1.3 Core Pillars & Design Philosophy**
    * **Playful Discovery:** Encourage curiosity and reward players with delightful visuals and sounds.
    * **Gentle Progression:** Create a sense of journey and accomplishment through a clear world map and steadily evolving challenges.
    * **Aesthetic Delight:** Maintain a soft, welcoming, and cohesive art and sound style that is always pleasant and never harsh.
* **1.4 Game Logo & Tagline**
    * **Logo:** The `Peek-a-Pair` logo and Ollie the Owl are central to the game's branding and appear on loading screens and promotional materials.
    * **Tagline:** _"Peek fast. Pair smart!"_

---
## PART 2: NARRATIVE & PRESENTATION
---
*(This section covers the game's "feel," story, and emotional core.)*

### **2.0 Narrative & World**
* **2.1 The Story of Ollie**
    * Ollie is the game's friendly, curious, and fun mascot. The name "Ollie" is short for **Oliver**, a name with historical roots meaning "ancestor's descendant." This hints at the deeper story of our hero: Ollie is the youngest descendant of a long and legendary line of "Grand Master" memory-keepers. His ancestors were the greatest Peek-a-Pair champions in the land, known for their incredible wisdom and memory. His great-great-grandfather was the first to ever master the "Final Peek." Now, it is young Ollie's turn to go on his own journey. He must travel the world map, solve the unique puzzles in each land, and prove that he is a worthy successor to his family's legacy. His ultimate goal is to reach "The Final Peek" and take his place as a true memory master.
* **2.2 Mascot: Ollie the Owl 🦉**
    * **Principle: The Hybrid Approach:** To balance strong branding with thematic charm and a manageable workload, we will use a hybrid approach for Ollie's design throughout the game.
    * **One Core Design:** There will be one single, consistent, high-quality design for Ollie. This core design will be used for the app logo, title screen, branding, and as the default character model to ensure Ollie is always recognizable.
    * **Thematic Accessories:** To add thematic flair and create reward opportunities, the core Ollie model will be adorned with a small, unique accessory when displayed on each world map. Examples include a candy-striped scarf for Sweet Street, a bubble helmet for Night Sky, a snorkel mask for Ocean Quest, and an explorer's hat for Jungle Jam.

### **2.1 Visual Style**
* **2.1.1 Art Style & Mood**
    * The visual style is friendly, curious, and fun, defined by a soft pastel color palette.
    * **Color Palette:**
        * Mint Green `#A8E6CF`
        * Peachy Coral `#FFD3B6`
        * Pale Yellow `#FFFAAA`
        * Sky Blue `#B3E5FC`
        * Soft Lilac `#D1C4E9`
* **2.1.2 UI/UX Philosophy**
    * **Immersive & Non-Intrusive:** The main menu buttons are integrated directly onto the World Map screen as non-intrusive icon overlays to maintain immersion.
    * **Intuitive Navigation:** Themes and worlds are handled by swiping left/right between world maps in the `WorldPagerScreen`. Essential actions like `Settings` and `How to Play` are accessible via simple icon buttons.

### **2.2 Audio Design**
* **2.2.1 Sound Design Philosophy**
    * The guiding principle for sound is to be gentle, happy, and responsive, enhancing the "soft pastel" visual style without ever being harsh or annoying.
* **2.2.2 Music & Ambience**
    * **Main Theme (World Map):** A gentle, happy, and looping theme. Light acoustic guitar, ukulele, or soft piano.
    * **Gameplay Music:** A more subtle, atmospheric version of the main theme with less melody to help the player focus.
    * **World-Specific Ambience (On World Map):**
        * **Forest Friends:** Faint sounds of birds chirping.
        * **Night Sky:** A very soft, ethereal "shimmer" or "twinkle."
        * **Ocean Quest:** The gentle sound of bubbles.
* **2.2.3 UI & Gameplay Sounds**
    * **UI Sounds (User Interface)**
        * **Button Click:** A soft, rounded "boop" or a gentle "thwick."
        * **Screen Transition:** A light, airy "whoosh" or a quick, gentle harp glissando.
        * **Star Collection:** Each of the three stars on the win screen gets a slightly higher-pitched "ding!"
        * **Unlock New Item:** A magical, ascending series of chimes with a soft, warm synth pad.
    * **Gameplay Sounds**
        * **Card Flip:** A soft "pop." Use 2-3 similar but slightly different variations that play randomly to avoid repetition.
        * **Card Match (Success):** A short, rewarding "sparkle jingle"—a happy two-note melody from a xylophone and a tiny bell.
        * **Card Mismatch (Failure):** A gentle, non-punishing sound. Either a cute "uh-oh!" voice line or a soft, descending "womp" sound.
        * **Level Win:** A triumphant, happy musical fanfare combined with a confetti/rustling sound.
* **2.2.4 Advanced Audio Principles**
    * **Streak/Combo Sound:** To reward skilled play, a sound will be implemented for consecutive successful matches. This could be an ascending arpeggio, where each successful match adds the next note in a pleasant musical sequence.
    * **Thematic UI Sounds:** To deepen immersion, core UI sounds can be subtly layered with world-specific textures. For example, the button click sound on the "Sweet Street" map might include a faint "squish" sound, while on "Ocean Quest" it might have a "bubble" sound.
    * **Use of Silence:** Music volume can be subtly lowered during key moments, such as when the "Level Complete" dialog is on screen, to focus the player's attention on their results and choices.

---
## PART 3: CORE GAMEPLAY
---
*(This is the mechanical heart of the game—what the player does moment-to-moment.)*

### **3.0 The Core Loop**
The player's journey is central to the game flow and follows this primary loop:
1.  From the **Interactive World Map**, the player taps a Level Node.
2.  They enter the **Game Screen** to play the Grid Flip & Match game.
3.  Upon winning, they see the **Level Win / Summary** screen to collect stars and see rewards.
4.  They **Return to the World Map**, where Ollie the Owl moves to the next unlocked level node, reinforcing progression.

### **3.1 Core Mechanics**
* **3.1.1 Card Matching**
    * Tap a card to flip and reveal it.
    * Tap a second card.
    * If the cards match, they stay visible.
    * If they do not match, there is a short delay before they flip back over.
    * The level is won when all pairs are matched.
* **3.1.2 Level Twists (Core Mechanic Modifiers)**
    * **Move Limits:** Introduced in World 2, this twist requires the player to complete the level within a specific number of card flips, adding a strategic, puzzle-like element.
    * **Timers:** Introduced in World 3, this twist requires the player to complete the level before a timer runs out, testing memory recall under pressure.
    * **Dynamic Obstacles:** Introduced in World 4, this twist features a "Mischievous Monkey" or "Flicker Fairy" who might shuffle or temporarily hide unflipped cards mid-level, forcing the player to adapt.
    * **3-Card Matches (Triplets):** Introduced in World 6, this twist is a fundamental shift in the core logic, requiring players to find three matching cards instead of two.
    * **The Gauntlet:** Featured in World 8, these levels contain unpredictable combinations of all previous twists, serving as an ultimate test of mastery.

### **3.2 Game Twists & Modifiers**
This section details the specific gameplay modifiers, or "Twists," that are introduced as the player progresses through the game. Each twist is designed to challenge the player in a new way, keeping the core loop fresh and engaging.

---
#### **Twist 1: Move Limits**
* **Introduced In:** World 2: Sweet Street
* **Core Concept:** The player must complete the level within a specific number of moves (card flips).
* **Detailed Description:** A counter is displayed on the gameplay screen, showing "Moves Left: X/Y". Each card flip (one move) decrements the counter. If the counter reaches zero before all pairs are matched, the level is lost. This mechanic shifts the focus from speed to careful, strategic choices.
* **Design Rationale / Player Focus:** To test and encourage **Strategic Efficiency**. Players can no longer randomly flip cards; they must remember previous flips and plan their moves to avoid wasting them.
* **Evolution:** In later worlds, this can be combined with other twists, and the number of allotted moves can be made progressively tighter relative to the number of pairs.

---
#### **Twist 2: Timers**
* **Introduced In:** World 3: Night Sky
* **Core Concept:** The player must complete the level before a timer runs out.
* **Detailed Description:** A visual timer (e.g., a countdown clock or a depleting bar) is displayed on the screen. If the timer empties before all pairs are matched, the level is lost. Successful matches may add a small amount of time back to the clock as a reward.
* **Design Rationale / Player Focus:** To test **Speed & Pressure**. This twist challenges a player's ability to recall card locations quickly and perform under the stress of a deadline.
* **Evolution:** The initial time given can be reduced in later levels, and the time bonus for a successful match can be decreased.

---
#### **Twist 3: Dynamic Obstacles (Mischievous Monkey)**
* **Introduced In:** World 4: Jungle Jam
* **Core Concept:** An external agent will occasionally alter the board state mid-level.
* **Detailed Description:** Periodically, the "Mischievous Monkey" character may appear on screen and perform an action, such as shuffling the positions of one or two *unflipped* cards. This event is telegraphed to the player with a brief animation to ensure fairness.
* **Design Rationale / Player Focus:** To test **Adaptability**. This prevents players from relying solely on a static mental map of the board, forcing them to update their memory and adapt their strategy when the unexpected happens.
* **Evolution:** The frequency of the shuffles or the number of cards shuffled can increase.

---
#### **Twist 4: 3-Card Matches (Triplets)**
* **Introduced In:** World 6: Memory Vault
* **Core Concept:** A fundamental change to the core logic where players must find three identical cards to make a match.
* **Detailed Description:** The matching logic is updated from pairs to triplets. Players must flip and hold three cards in their short-term memory to succeed. The board sizes may be adjusted to accommodate grids divisible by three (e.g., 3x4, 3x6).
* **Design Rationale / Player Focus:** To test **Advanced Pattern Recognition** and significantly increase the memory load, providing a steep but fair increase in difficulty.
* **Evolution:** This becomes the new baseline for matching in later worlds and is combined with all other twists.

---
#### **Twist 5: Advanced Dynamic Obstacles (Flicker Fairy)**
* **Introduced In:** World 7: Fairy Flicker
* **Core Concept:** More complex and varied board manipulations occur mid-level, combined with the triplet mechanic.
* **Detailed Description:** The "Flicker Fairy" character introduces more magical and disruptive effects. These can include temporarily hiding a card (making it un-flippable for a few seconds), making two unflipped cards swap places, or briefly obscuring a portion of the board with a "magical fog."
* **Design Rationale / Player Focus:** To create a sense of **Magical Mayhem** and test players' focus and concentration at a high level.
* **Evolution:** The effects can be combined, for instance, a card swap followed by a brief fogging of the board.

---
#### **Twist 6: The Gauntlet**
* **Introduced In:** World 8: The Final Peek
* **Core Concept:** Levels feature unpredictable combinations of all previously introduced twists.
* **Detailed Description:** Each level in this world is a unique challenge. One level might be Triplets + Timer. Another might be Triplets + Move Limits + Mischievous Monkey. The "Boss Level," "The Grandmaster's Grid," features a massive 6x6 grid with triplets, a strict timer, AND a tight move limit.
* **Design Rationale / Player Focus:** To serve as the ultimate test of **Ultimate Mastery**, requiring players to synthesize all the skills they have learned throughout the game.

### **3.3 Game Flow & Controls**
* **3.3.1 Application Flow**
    1.  Title Screen
    2.  Interactive World Map (Player sees their mascot, Ollie, on a path)
    3.  Tap a Level Node → Game Screen (Grid Flip & Match)
    4.  Level Win / Summary (Collect stars, see rewards)
    5.  Return to World Map (Ollie the Owl moves to the next unlocked level node)
    6.  Unlock the next World after meeting the requirements of the previous one.
* **3.3.2 Controls & Inputs**
    * **Tap:** The primary action for flipping cards and pressing all UI buttons.
    * **Swipe:** Used to navigate horizontally between the different World Maps.

---
## PART 4: SYSTEMS & PROGRESSION
---
*(This section details all the meta-systems that drive long-term engagement.)*

### **4.0 Player Progression**
* **4.1 World & Level Progression**
    * Progression is visualized on an interactive world map where Ollie the Owl travels along a path. Worlds are "gated" and must be unlocked, creating long-term goals. Each world introduces a new core mechanic or "twist" to keep the gameplay fresh and challenging.
    * **World 1: Forest Friends 🌲**
        * **Focus:** Core Memory Mechanics (Tutorial)
        * **Twist:** None. This world is a stress-free introduction to the pure peek-a-pair gameplay.
        * **Unlock Requirement:** Available from the start.
        * **Boss Level (1-5):** Complete "Ollie's Owl Outpost" to unlock Sweet Street.
    * **World 2: Sweet Street 🍰**
        * **Focus:** Strategic Efficiency
        * **Twist:** **Move Limits.** Levels must be completed within a specific number of moves.
        * **Unlock Requirement:** Beat the Boss Level of Forest Friends.
    * **World 3: Night Sky 🚀**
        * **Focus:** Speed & Pressure
        * **Twist:** **Timers.** Levels must be completed before the timer runs out.
        * **Unlock Requirement:** Collect 12 stars in Sweet Street.
    * **World 4: Jungle Jam 🐒**
        * **Focus:** Adaptability
        * **Twist:** **Dynamic Obstacles.** A "Mischievous Monkey" might shuffle one or two unflipped cards mid-level.
        * **Unlock Requirement:** Beat the Boss Level of Night Sky.
    * **World 5: Ocean Quest 🌊**
        * **Focus:** High-Pressure Efficiency
        * **Twist:** **Combined Timers & Move Limits.**
        * **Unlock Requirement:** Collect 30 stars from all previous worlds.
    * **World 6: Memory Vault 🧠**
        * **Focus:** Advanced Pattern Recognition
        * **Twist:** **3-Card Matches (Triplets).**
        * **Unlock Requirement:** Beat the Boss Level of Ocean Quest.
    * **World 7: Fairy Flicker 🧚**
        * **Focus:** Magical Mayhem
        * **Twist:** **3-Card Matches + Advanced Dynamic Obstacles.** A "Flicker Fairy" might temporarily hide a card, make two unflipped cards swap places, or briefly obscure the board.
        * **Unlock Requirement:** Collect 60 stars from all previous worlds.
    * **World 8: The Final Peek 🏆**
        * **Focus:** Ultimate Mastery
        * **Twist:** **The Gauntlet.** Levels in this world feature unpredictable combinations of all previous twists.
        * **Boss Level (8-5):** "The Grandmaster's Grid." A massive 6x6 grid featuring triplets with both a strict timer and a tight move limit.
        * **Unlock Requirement:** Beat the Boss Level of Fairy Flicker.
* **4.2 Star Rating System**
    * Displayed on the Win Summary screen, based on performance (e.g., speed or move efficiency).
    * **⭐:** Complete the level.
    * **⭐⭐:** Beat the target score (e.g., under 30 moves or 60 seconds).
    * **⭐⭐⭐:** Achieve a perfect or near-perfect score.

### **4.1 Economy & Monetization**
* **4.1.1 Currencies**
    * **[PROPOSED] Shiny Buttons:** A soft currency awarded for earning stars, completing daily challenges, and opening mystery boxes. This currency is used exclusively to purchase cosmetic items for personalization features.
* **4.1.2 Monetization Strategy**
    * **[PROPOSED]** The game will be free-to-play. Monetization will focus on purely cosmetic items that do not affect gameplay, such as unique themes for Ollie's Treehouse or premium card back designs. The system will be transparent, with no loot boxes or pay-to-win mechanics, preserving the family-friendly and fair nature of the game.

### **4.2 Player Engagement Systems**
* **4.2.1 Social Features [PROPOSED]**
    * **Principle:** Social Proof & Relatedness.
    * **Rationale:** To make the game feel like a shared journey rather than a solitary experience, creating powerful intrinsic motivation.
    * **Features:**
        * **Friend Path:** Players can connect their game to see their friends' Ollie avatars on the world map at their current level progress.
        * **Cooperative Gifting:** Players can send friends small, daily, single-use helper gifts like "+5 Moves" to foster a positive community loop.
* **4.2.2 Collectibles & Unlocks**
    * **Collectible Card Gallery:** Sections of a gallery are unlocked by earning a certain number of stars. For example, "Collect 20 stars to unlock the 'Sweet Street' gallery!"
    * **Unlockable Card Skins:** Awarded to the player for achieving 3 stars on all levels within a single world.
    * **[PROPOSED] The Grandmaster's Memory Book:** This feature reframes the "Story postcards from the mascot". Instead of being standalone items, postcards unlocked by beating Boss Levels become new pages in a tangible Memory Book inherited from Ollie's ancestors. This leverages the Endowed Progress Effect by making the player feel they are continuing a legacy, not starting from zero.
* **4.2.3 Personalization [PROPOSED]**
    * **Principle:** Investment & Personalization (The IKEA Effect).
    * **Rationale:** To create strong, long-term retention by allowing players to invest time and creativity into a personal space they control.
    * **Feature:**
        * **Ollie's Treehouse:** A persistent hub screen that represents Ollie's home. It starts basic, and players can spend their "Shiny Buttons" to buy cosmetic decorations (furniture, rugs, lamps, wall art) to customize the space. The rarest decorations are tied to significant in-game achievements.

---
## PART 5: CONTENT
---
*(This section is a catalogue of all the specific "stuff" in the game. It is designed to be easily updated.)*

### **5.0 World Breakdown**
* **5.0.1 World 1: Forest Friends 🌲**
    * **Twist:** None (Core Memory Mechanics).
    * **Card Set:** Squirrel, Bear Cub, Fox, Deer Fawn, Rabbit, Hedgehog, Little Owl, Raccoon.
* **5.0.2 World 2: Sweet Street 🍰**
    * **Twist:** Move Limits.
    * **Card Set:** Cupcake, Lollipop, Donut, Ice Cream, Cookie, Hard Candy, Cake Slice, Chocolate Bar.
* **5.0.3 World 3: Night Sky 🚀**
    * **Twist:** Timers.
    * **Card Set:** Rocket Ship, Planet, Moon, Alien UFO, Astronaut, Comet, Star, Constellation.
* **5.0.4 World 4: Jungle Jam 🐒**
    * **Twist:** Dynamic Obstacles.
    * **Card Set:** Monkey, Toucan, Sloth, Tiger Cub, Snake, Dart Frog, Banana, Jungle Leaf.
* **5.0.5 World 5: Ocean Quest 🌊**
    * **Twist:** Combined Timers & Move Limits.
    * **Card Set:** Clownfish, Crab, Octopus, Sea Turtle, Seahorse, Dolphin, Treasure Chest, Starfish.
* **5.0.6 World 6: Memory Vault 🧠**
    * **Twist:** 3-Card Matches (Triplets).
    * **Card Set:** Red Circles, Blue Squares, Yellow Triangles, Green Hexagons, Purple Stars, Orange Plus Signs.
* **5.0.7 World 7: Fairy Flicker 🧚**
    * **Twist:** 3-Card Matches + Advanced Dynamic Obstacles.
    * **Card Set:** Magic Wands, Potion Bottles, Power Crystals, Pixie Mushrooms, Fairy Lanterns, Magic Scrolls.
* **5.0.8 World 8: The Final Peek 🏆**
    * **Twist:** The Gauntlet (All previous twists combined).
    * **Card Set:** Gold Trophy, Diamond, Winner's Crown, Award Ribbon, Laurel Wreath, Gold Medal, Golden Key, Flaming Torch.

### **5.1 Events & Future Features**
* Daily challenges / timed events.
* Zen mode / memory challenge modes.
* **[PROPOSED] Pre-Level Boosts:** A system allowing players to spend "Shiny Buttons" before a level to activate a single-use boost. This adds strategic agency. Examples:
    * **"Focused Mind":** Adds 15 seconds to a timed level.
    * **"Extra Step":** Adds 3 extra moves to a move-limited level.
    * **"Sneak Peek":** At the start of the game, 2 random pairs are briefly revealed.

---
## APPENDICES
---
*(For production assets, granular lists, and reference material.)*

### **Appendix A: UI & Menu Specification**
* **Overlay Buttons on World Map:**
    * `⚙️ Settings`: An icon button, likely in a corner, that opens a settings dialog or screen.
    * `🎨 Themes / Worlds`: This is handled by swiping left/right between world maps in the `WorldPagerScreen`.
    * `👣 How to Play`: An icon button that opens a simple tutorial overlay.
* **Win Summary Buttons:** "Next Level", "Replay", "Map".

### **Appendix B: Asset Production**
* **B1: World Asset Checklist**
    * **1. World Map Screen Assets**
        * [ ] World Map Background
        * [ ] Custom Header / Banner
        * [ ] Level Node (Enabled)
        * [ ] Level Node (Disabled)
        * [ ] Player Mascot on Map
    * **2. Gameplay Screen Assets (Theme-Specific)**
        * [ ] Game Screen Background
        * [ ] Card Back Design
        * [ ] Card Fronts Set
    * **3. General UI & Reward Assets**
        * [ ] Star Icon (Filled)
        * [ ] Star Icon (Empty)
        * [ ] World-Specific Icons (e.g., Timer icon)
        * [ ] Boss Level Unlock Asset
* **B2: Asset Prompts Cookbook (Midjourney)**
    * **1. Branding & Core UI Assets**
        * **App Logo (Classic Mascot)**
            ```
            /imagine prompt: app logo icon, a modern and simple logo for a kids game, a clean and symmetrical icon of a cute baby owl's face (Ollie the mascot), looking directly at the viewer with a friendly smile, minimalist flat 2D vector logo, using simple geometric shapes, clean bold lines, soft pastel color palette, enclosed in a squircle shape with a peachy coral background --no text gradients shadows
            ```
        * **Mascot (Ollie the Owl) (Master Prompt)**
            ```
            /imagine prompt: full-body character design of Ollie the Owl, a super cute and friendly baby owl **wearing a simple [THEMED ACCESSORY]**, standing and waving with a cheerful expression, big curious eyes, flat vector illustration, clean bold lines, whimsical and delightful, soft pastel color palette, isolated character on a solid light grey background --no text --ar 1:1
            ```
    * **2. World-Specific Assets**
        * **World 1: Forest Friends 🌲**
            * **Card Back Design:** `/imagine prompt: game asset, playing card back design, a cute, stylized baby owl logo in the center, surrounded by a subtle symmetrical pattern of leaves and twigs, flat vector illustration, soft pastel colors, mint green and peachy coral, clean lines, whimsical and friendly, for a kids memory game --no text --ar 2:3`
            * **Card Fronts (Master Prompt):** `/imagine prompt: game asset, playing card front, a cute [ANIMAL DESCRIPTION], centered character, on a simple circular background, flat vector illustration, soft pastel colors, sky blue and pale yellow, clean lines, whimsical and friendly --no text --ar 2:3`
            * **World Map Background:** `/imagine prompt: a minimalist and atmospheric mobile game world map background, a soft focus and dreamy forest scene, the background details are blurry and simplified, creating a gentle texture rather than sharp objects, with a faint, blurry path winding through, very subtle and muted color palette of soft greens and gentle earthy browns, designed with low contrast so that UI elements and bright yellow stars will be clearly visible on top --ar 9:16`
            * **Gameplay Screen Background:** `/imagine prompt: subtle background for a mobile game screen, a dreamy, out-of-focus magical forest, sunbeams filtering through a canopy of leaves, minimalist flat vector illustration, ultra soft pastel color palette, gentle gradients of mint green and pale sky blue, calm and serene --ar 9:16`
            * **App Header / Banner (Wide):** `/imagine prompt: game UI header, title banner asset, a long, wide, banner-shaped whimsical hanging wooden sign that stretches across the full width of the image, decorated with cute green ivy vines, held up by ropes, center is a smooth clear space for text, isolated asset on a solid light grey background, flat vector illustration --ar 3:1 --style raw`
            * **Level Node (Enabled):** `/imagine prompt: game UI asset, level select node, a cute, round wooden sign decorated with a small sprig of mint green leaves on the edge, with a light-colored center ready for a number to be placed on it, flat vector illustration, clean bold lines, soft pastel colors, using browns, but with accents of mint green and peachy coral to match the world map, isolated asset on a solid light grey background --no text --ar 1:1`
            * **Level Node (Disabled):** `/imagine prompt: game UI asset, DISABLED level select node, a cute, round wooden sign decorated with a small sprig of leaves, with a simple, cute lock symbol in the center, desaturated grayscale color palette, muted tones, flat vector illustration, isolated asset on a solid light grey background --no text --ar 1:1`
            * **Mascot (Ollie the Owl):** `/imagine prompt: full-body character design of Ollie the Owl, a super cute and friendly baby owl, standing and waving with a cheerful expression, big curious eyes, flat vector illustration, clean bold lines, whimsical and delightful, soft pastel color palette, isolated character on a solid light grey background --no text --ar 1:1`
        * **World 2: Sweet Street 🍰**
            * **Card Back Design:** `/imagine prompt: game asset, playing card back design, a cute, stylized baby owl logo in the center, surrounded by a subtle symmetrical pattern of tiny candy sprinkles and icing swirls, flat vector illustration, soft pastel colors, peachy coral and soft lilac, clean lines, whimsical and friendly, for a kids memory game --no text --ar 2:3`
            * **World Map Background:** `/imagine prompt: game world map background for a mobile game, a whimsical candy land, with cute gingerbread houses, lollipop trees, and a river of chocolate, a clear winding path made of cookie crumbs goes from bottom to top, flat vector illustration, clean bold lines, soft pastel color palette of peachy coral and soft lilac, cheerful and delicious --ar 9:16`
            * **Mascot (Ollie the Owl):** `/imagine prompt: full-body character design of Ollie the Owl, a super cute and friendly baby owl **wearing a simple red-and-white candy-striped scarf**, standing and waving with a cheerful expression, big curious eyes, flat vector illustration, clean bold lines, whimsical and delightful, soft pastel color palette, isolated character on a solid light grey background --no text --ar 1:1`