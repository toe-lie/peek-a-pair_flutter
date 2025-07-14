# Peek-a-Pair: Production Game Design Document
*Version 2.1: "Powers & Rewards Update"*

---
### **DOCUMENT CONTROL**
---
*This section tracks major changes to the GDD, ensuring all team members are aware of the latest decisions.*

#### **Revision History**
| Version  | Date           | Author        | Summary of Changes                                                                                                |
|:---------|:---------------|:--------------|:------------------------------------------------------------------------------------------------------------------|
| **v2.1** | **2025-07-14** | **Gemini AI** | **Expanded and restructured Section 5.2 'Power-Ups & Boosts' with a comprehensive list of brainstormed ideas.**   |
| v2.0     | 2025-07-14     | Gemini AI     | Complete rewrite based on the new "Ollie and the Naga's Tear" narrative. Integrated all systems into a final GDD. |
| v1.1     | 2025-07-13     | Gemini AI     | Refactored GDD into a scalable, modular structure. Integrated [PROPOSED] engagement & social mechanics.           |
| v1.0     | 2025-07-09     | Toe Lie       | Initial creation of the Master GDD.                                                                               |

---
## PART 1: EXECUTIVE PILLARS
---
*(This section is the high-level vision for stakeholders and the team.)*

### **1.1 Game Concept & Hook**
* **Game:** `Peek-a-Pair`
* **Concept:** A story-driven puzzle adventure where players help a young owl named Ollie on a quest to save his village's memories. The core gameplay is a classic "memory match" card game that evolves with new challenges and mechanics.
* **Hook:** A beautiful, heartwarming story inspired by Southeast Asian culture and folklore, combined with satisfying, brain-teasing puzzles. It's a journey of the heart and mind.

### **1.2 Target Audience & Platform**
* **Audience:** A global audience of casual players, families, and anyone looking for a relaxing, beautiful, and engaging puzzle game. The B2-level English narrative ensures broad accessibility.
* **Platform:** Mobile (iOS & Android).

### **1.3 Core Pillars & Design Philosophy**
* **Heartfelt Storytelling:** The player's journey is emotionally engaging. Every level and mechanic serves the narrative of helping Ollie.
* **Accessible Challenge:** The game is easy to learn but offers deep challenges. The difficulty curve is gentle, and systems are in place to help players when they are stuck.
* **Aesthetic Serenity:** The art and sound design are inspired by the beauty of Southeast Asia, creating a calm, welcoming, and immersive experience.

### **1.4 Brand Identity**
* **Official Name:** `Peek-a-Pair` (with hyphens).
* **Tagline:** _"A journey to remember."_

---
## PART 2: NARRATIVE & PRESENTATION
---
*(This section covers the game's "feel," story, and emotional core.)*

### **2.1 Core Narrative: Ollie and the Naga's Tear**
* **Synopsis:** In the hidden Baan Sook Jai village, the magical "Tree of Memories" is fading, causing the villagers to lose their memories. A young owl named Ollie learns he must go on a quest to get a magical tear from the Great Naga to heal the tree. His journey is a test of his mind and heart, where he learns new skills from the wise characters he meets.

### **2.2 Art & Visual Style**
* **Art Direction:** Inspired by Southeast Asian aesthetics. Soft, warm lighting, lush greenery, and designs reminiscent of Thai architecture, textiles, and nature.
* **Color Palette:** A vibrant but gentle palette. Emerald greens, lotus pinks, temple golds, and mango oranges, balanced with earthy tones.
* **UI/UX Philosophy:** Clean, organic, and immersive. Menus and buttons should feel like part of the world (e.g., written on banana leaves or carved into stone). The main progression interface will be a beautiful, interactive "Storybook."

### **2.3 Audio & Sound Design**
* **Music:** A score that uses traditional Southeast Asian instruments (like the Khlui flute or Kim xylophone) blended with gentle, modern orchestral arrangements to create a unique and emotional soundtrack.
* **Sound Effects:** Natural, soft, and satisfying sounds. The flip of a card might sound like a rustling leaf. A successful match could be a pleasant chime from a small temple bell.

---
## PART 3: CORE GAMEPLAY
---
*(This is the mechanical heart of the game—what the player does moment-to-moment.)*

### **3.1 The Core Loop**
1.  **Open the Storybook:** Player selects the current chapter.
2.  **Play a Level:** Player taps an interactive element on the storybook page to start a memory match level.
3.  **Earn Rewards:** Player completes the level, earns stars, and receives **Lotus Petals** (soft currency).
4.  **Advance the Story:** Player returns to the storybook page, where a new part of the path is revealed, moving Ollie closer to his goal.

### **3.2 Core Mechanics**
* **Card Matching:** Tap cards to flip and reveal the images. Match two identical cards to clear them from the board. The level is won when all pairs are matched.

### **3.3 Game Twists & Modifiers**
*These are the special rule changes that are introduced through the story to keep gameplay fresh.*

* **Twist 1: The Shell Game (Dynamic Obstacles)**
    * **Introduced In:** Chapter 2: The Floating Market of Whispers.
    * **Mechanic:** Periodically, a character (Auntie Kai) shuffles the position of two *unflipped* cards.
* **Twist 2: Efficiency & The Spirit's Gift (Move Limits & Power-Up Pairs)**
    * **Introduced In:** Chapter 3: The Emerald Fields.
    * **Mechanic:** Levels must be completed in a set number of moves. Special glowing "Power-Up Pairs" may appear, which grant bonus moves when matched.
* **Twist 3: Restoring the Guardians (Locked & Chained Cards)**
    * **Introduced In:** Chapter 4: The Sunken Temple of Ayutthaya.
    * **Mechanic:** Some cards are "chained." To unlock a chained card, the player must first clear a card that is directly touching it.
* **Twist 4: The Three Faces of Truth (3-Card Matches)**
    * **Introduced In:** Chapter 5: The Hermit of Doi Suthep.
    * **Mechanic:** Players must find and match three identical cards (triplets) instead of pairs.
* **Twist 5: The Final Test (The Gauntlet)**
    * **Introduced In:** Chapter 6: The Naga's Tear.
    * **Mechanic:** Levels feature unpredictable combinations of all previous twists.

---
## PART 4: THE NARRATIVE JOURNEY
---
*(This section details the chapter-by-chapter story progression.)*

| Chapter | Title                           | Location              | Key Character(s)   | Twist Introduced / Mastered  |
|:--------|:--------------------------------|:----------------------|:-------------------|:-----------------------------|
| **1**   | The Fading Village              | Baan Sook Jai Village | Ollie, Grandmother | Core Mechanics               |
| **2**   | The Floating Market of Whispers | Floating Market       | Auntie Kai         | The Shell Game               |
| **3**   | The Emerald Fields              | Rice Paddies          | Rice Spirits       | Move Limits & Power-Up Pairs |
| **4**   | The Sunken Temple of Ayutthaya  | Temple Ruins          | Yaksha Guardians   | Locked & Chained Cards       |
| **5**   | The Hermit of Doi Suthep        | Mountain Hermitage    | The Lersi (Hermit) | 3-Card Matches               |
| **6**   | The Naga's Tear                 | Underwater Naga Realm | The Great Naga     | The Gauntlet (All Twists)    |

---
## PART 5: REWARDS & ECONOMY
---
*(This section details the systems that motivate the player.)*

### **5.1 Currencies**
* **Lotus Petals (Soft Currency):**
    * **Earned:** By completing levels (more stars = more petals).
    * **Used:** To purchase Pre-Level Boosts.
* **Starlight Motes (Endgame/Premium Currency):**
    * **Earned:** From completing Daily Challenges and participating in Seasonal Festivals (Endgame content).
    * **Used:** To purchase permanent cosmetic items for the player's garden and for Ollie.

### **5.2 Power-Ups & Boosts**

#### **5.2.1 Guiding Principles**
* **Thematic:** All powers should feel like a natural part of Ollie's world.
* **Balanced:** Powers should feel helpful and satisfying, but not like "cheat codes." They should assist, not replace, the player's own skill.
* **Strategic Variety:** The system should offer different types of help for different situations and player needs.

#### **5.2.2 Pre-Level Boosts (Strategic Preparation)**
*These are purchased with **Lotus Petals** before a level begins. Players choose one to take with them.*

* **Grandmother's Blessing:**
    * **Mechanic:** Adds 3 extra moves OR 10 extra seconds to the level's starting limit.
* **Auntie Kai's Sharp Eye:**
    * **Mechanic:** At the very start of the level, one random pair is instantly revealed and matched.
* **Rice Spirit's Gift:**
    * **Mechanic:** Guarantees that a special "Power-Up Pair" (from the Chapter 3 twist) will appear in the level.

#### **5.2.3 In-Level Powers (Tactical Help)**
*These are rarer powers that can be used during a level when a player is stuck. They can be earned as special rewards.*

**Common Powers:**

* **Ollie's Hoot:**
    * **Mechanic:** When activated, all cards of a single, random type (e.g., all the "Yaksha" cards) briefly wiggle, revealing their locations without flipping them.
* **Lersi's Focus:**
    * **Mechanic:** Instantly adds 15 seconds to the timer. A powerful tool for timed levels.
* **The Serpent's Path:**
    * **Mechanic:** The player taps a revealed card. A path of light briefly illuminates the row OR column containing its matching partner.
* **Echoing Chirp:**
    * **Mechanic:** A hint provided by sound. The player taps a revealed card, and a "chirp" sound plays from the location of its hidden match, helping the player locate it via directional audio.
* **Auntie Kai's Reshuffle:**
    * **Mechanic:** Shuffles the positions of all *unflipped* cards on the board, giving the player a fresh board state without losing progress. A nod to the "Shell Game" twist.
* **Sticky Palm:**
    * **Mechanic:** When activated, the next single card the player flips will remain face-up, even if they fail to find its match on the next turn.

**Rare "Ultimate" Powers:**

* **Naga's Gaze:**
    * **Mechanic:** The Great Naga's eyes flash on screen, and one random, unmatched pair on the board is instantly found and cleared.
* **Tree of Memories' Bloom:**
    * **Mechanic:** A beautiful animation plays. For 2 brief seconds, all remaining unmatched pairs on the board glow with a soft, golden light, revealing all solutions at once. This requires intense player focus to absorb the information before it fades.

---
## PART 6: ENDGAME & LIVE SYSTEMS
---
*(This section details the systems designed to retain players after the main story is complete.)*

### **6.1 Player Role Shift**
* Upon completing Chapter 6, the player's role shifts from **Hero on a Quest** to **Guardian of the Village**. The goal is now to help the Tree of Memories thrive.

### **6.2 Endgame Loops**
* **System 1: Tending the Tree of Memories (Daily Engagement)**
    * **Mechanic:** A new, procedurally generated Daily Challenge level appears at the Tree of Memories every 24 hours.
    * **Reward:** Starlight Motes.
* **System 2: Beautifying Baan Sook Jai (Long-Term Investment)**
    * **Mechanic:** A new area, "My Spirit Garden," is unlocked. Players use Starlight Motes to buy cosmetic decorations and build their own beautiful, personal space.
* **System 3: The Naga's Reflections (Mastery & Prestige)**
    * **Mechanic:** An Endless Mode with a leaderboard where players face increasingly difficult levels to achieve a high score.
    * **Reward:** Prestige cosmetics for reaching high ranks.
* **System 4: Seasonal Festivals (Community & Events)**
    * **Mechanic:** Time-limited events themed around real Southeast Asian festivals (e.g., Loy Krathong, Songkran), with unique levels, rewards, and community goals.

---
## PART 7: PRE-IMPLEMENTATION PRINCIPLES
---
*(This section contains key strategic reminders for the development team before implementation begins.)*

### **7.1 The First Five Minutes (FTUE)**
* The game must be engaging immediately. The tutorial should be integrated seamlessly into Chapter 1. The first level must be simple and provide an immediate, satisfying sense of accomplishment. Avoid long, unskippable text or cinematics at the start.

### **7.2 Economy & Pacing Balance**
* The numerical values for the economy (costs vs. earnings) must be planned and balanced in a spreadsheet *before* coding. The goal is to make rewards feel valuable but achievable, preventing player frustration or boredom.

### **7.3 Technical Foundation**
* **State Management (Flutter):** A robust state management solution (e.g., Riverpod, BLoC) must be chosen and used consistently for all game state.
* **Asset Management (Flutter):** A strategy for loading and unloading assets efficiently between scenes is required to prevent lag.
* **Secure Save Data (Backend):** All player progress, currency, and inventory must be stored securely on the server (MongoDB) and validated via the API (Next.js) to prevent cheating. Player state should not be trusted on the client side.

### **7.4 The Emotional Journey Map**
* The difficulty of the levels should be mapped to the emotional arc of the story. Early chapters should feel hopeful, mid-game chapters should introduce thoughtful challenges, and the final chapter should build tension before a triumphant finish.

### **7.5 The Minimum Viable Product (MVP)**
* **Version 1.0 Scope:** The initial release should focus on delivering a polished and complete core narrative experience.
    * **IN SCOPE:** The full 6-chapter story, all core mechanics and twists, the Lotus Petal currency, and the Pre-Level Boost system.
* **Post-Launch Scope (Updates):**
    * **OUT OF SCOPE for v1.0:** The full endgame loop (Daily Challenges, Garden, Endless Mode), seasonal events, and social features. These will be added in subsequent updates to keep players engaged after launch.