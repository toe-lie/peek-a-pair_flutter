import 'package:peek_a_pair/core/models/level_model.dart';
import 'package:peek_a_pair/core/models/theme_model.dart';

// This list contains all the data for every world and level in the game.
final List<ThemeModel> allWorlds = [
  //============================================================================
  // WORLD 1: FOREST FRIENDS
  //============================================================================
  ThemeModel(
    id: 'forest-friends',
    name: 'Forest Friends 🌲',
    emoji: '🌲',
    worldMapBackgroundAsset: 'assets/images/maps/forest_map_bg.png',
    gameScreenBackgroundAsset: 'assets/images/backgrounds/forest_game_bg.png',
    headerBannerAsset: 'assets/images/ui/header_banner_forest.png',
    enabledNodeAsset: 'assets/images/nodes/forest_sign.png',
    disabledNodeAsset: 'assets/images/nodes/forest_sign_disabled.png',
    cardBackAsset: 'assets/images/cards/card_back_forest.png',
    mascotAssetPath: 'assets/animations/ollie_mascot.gif',
    levels: [
      LevelModel(
        id: 'forest-friends_1',
        levelNumber: 1,
        name: 'Peek-a-Boo Grove',
        cardValues: ['fox', 'bear'],
        position: {'top': 500, 'left': 80},
      ),
      LevelModel(
        id: 'forest-friends_2',
        levelNumber: 2,
        name: 'Twilight Treehouse',
        cardValues: ['deer', 'owl', 'rabbit'],
        position: {'top': 400, 'left': 200},
      ),
      LevelModel(
        id: 'forest-friends_3',
        levelNumber: 3,
        name: 'Bouncy Burrow',
        cardValues: ['fox', 'bear', 'deer', 'owl'],
        position: {'top': 300, 'left': 100},
      ),
      LevelModel(
        id: 'forest-friends_4',
        levelNumber: 4,
        name: 'The Hidden Hollow',
        cardValues: ['rabbit', 'squirrel', 'bear', 'deer'],
        position: {'top': 200, 'left': 220},
      ),
      LevelModel(
        id: 'forest-friends_5',
        levelNumber: 5,
        name: "Ollie's Owl Outpost",
        cardValues: ['fox', 'bear', 'deer', 'owl', 'rabbit', 'squirrel'],
        position: {'top': 100, 'left': 120},
      ),
    ],
  ),

  //============================================================================
  // WORLD 2: SWEET STREET (Move Limits)
  //============================================================================
  ThemeModel(
    id: 'sweet-street',
    name: 'Sweet Street 🍰',
    emoji: '🍰',
    worldMapBackgroundAsset: 'assets/images/maps/sweet_map_bg.png',
    gameScreenBackgroundAsset: 'assets/images/backgrounds/sweet_game_bg.png',
    headerBannerAsset: 'assets/images/ui/header_banner_sweet.png',
    enabledNodeAsset: 'assets/images/nodes/sweet_sign.png',
    disabledNodeAsset: 'assets/images/nodes/sweet_sign_disabled.png',
    cardBackAsset: 'assets/images/cards/card_back_sweet.png',
    mascotAssetPath: 'assets/animations/ollie_sweet.gif',
    levels: [
      LevelModel(
        id: 'sweet-street_1',
        levelNumber: 1,
        name: 'Donut Drive',
        cardValues: ['donut', 'cupcake'],
        position: {'top': 500, 'left': 80},
        moveLimit: 5,
      ),
      LevelModel(
        id: 'sweet-street_2',
        levelNumber: 2,
        name: 'Cookie Corner',
        cardValues: ['cookie', 'lollipop', 'cake'],
        position: {'top': 400, 'left': 200},
        moveLimit: 8,
      ),
      LevelModel(
        id: 'sweet-street_3',
        levelNumber: 3,
        name: 'Ice Cream Crossing',
        cardValues: ['ice-cream', 'donut', 'cupcake', 'lollipop'],
        position: {'top': 300, 'left': 100},
        moveLimit: 15,
      ),
      LevelModel(
        id: 'sweet-street_4',
        levelNumber: 4,
        name: 'Candy Canyon',
        cardValues: ['cake', 'cookie', 'ice-cream', 'donut'],
        position: {'top': 200, 'left': 220},
        moveLimit: 14,
      ),
      LevelModel(
        id: 'sweet-street_5',
        levelNumber: 5,
        name: 'The Sugar Spire',
        cardValues: [
          'cake',
          'cupcake',
          'donut',
          'ice-cream',
          'lollipop',
          'cookie',
        ],
        position: {'top': 100, 'left': 120},
        moveLimit: 25,
      ),
    ],
  ),

  //============================================================================
  // WORLD 3: NIGHT SKY (Timers)
  //============================================================================
  ThemeModel(
    id: 'night-sky',
    name: 'Night Sky 🚀',
    emoji: '🚀',
    worldMapBackgroundAsset: 'assets/images/maps/forest_map_bg.png',
    gameScreenBackgroundAsset: 'assets/images/backgrounds/forest_game_bg.png',
    headerBannerAsset: 'assets/images/ui/header_banner_forest.png',
    enabledNodeAsset: 'assets/images/nodes/forest_sign.png',
    disabledNodeAsset: 'assets/images/nodes/forest_sign_disabled.png',
    cardBackAsset: 'assets/images/cards/card_back_forest.png',
    mascotAssetPath: 'assets/animations/ollie_mascot.gif',
    levels: [
      LevelModel(
        id: 'night-sky_1',
        levelNumber: 1,
        name: 'Launchpad',
        cardValues: ['rocket', 'star'],
        position: {'top': 500, 'left': 80},
        timerInSeconds: 15,
      ),
      LevelModel(
        id: 'night-sky_2',
        levelNumber: 2,
        name: 'Comet Chase',
        cardValues: ['comet', 'moon', 'alien'],
        position: {'top': 400, 'left': 200},
        timerInSeconds: 25,
      ),
      LevelModel(
        id: 'night-sky_3',
        levelNumber: 3,
        name: 'Asteroid Alley',
        cardValues: ['planet', 'rocket', 'star', 'moon'],
        position: {'top': 300, 'left': 100},
        timerInSeconds: 40,
      ),
      LevelModel(
        id: 'night-sky_4',
        levelNumber: 4,
        name: 'Galaxy Glide',
        cardValues: ['alien', 'comet', 'planet', 'rocket'],
        position: {'top': 200, 'left': 220},
        timerInSeconds: 35,
      ),
      LevelModel(
        id: 'night-sky_5',
        levelNumber: 5,
        name: 'Supernova Sprint',
        cardValues: ['rocket', 'alien', 'star', 'moon', 'planet', 'comet'],
        position: {'top': 100, 'left': 120},
        timerInSeconds: 60,
      ),
    ],
  ),

  //============================================================================
  // WORLD 4: JUNGLE JAM (Shuffle Twist)
  //============================================================================
  ThemeModel(
    id: 'jungle-jam',
    name: 'Jungle Jam 🐒',
    emoji: '🐒',
    worldMapBackgroundAsset: 'assets/images/maps/forest_map_bg.png',
    gameScreenBackgroundAsset: 'assets/images/backgrounds/forest_game_bg.png',
    headerBannerAsset: 'assets/images/ui/header_banner_forest.png',
    enabledNodeAsset: 'assets/images/nodes/forest_sign.png',
    disabledNodeAsset: 'assets/images/nodes/forest_sign_disabled.png',
    cardBackAsset: 'assets/images/cards/card_back_forest.png',
    mascotAssetPath: 'assets/animations/ollie_mascot.gif',
    levels: [
      LevelModel(
        id: 'jungle-jam_1',
        levelNumber: 1,
        name: 'Monkey Vines',
        cardValues: ['monkey', 'snake'],
        position: {'top': 500, 'left': 80},
        hasShuffleTwist: true,
      ),
      LevelModel(
        id: 'jungle-jam_2',
        levelNumber: 2,
        name: 'Treetop Tumble',
        cardValues: ['toucan', 'panther', 'frog'],
        position: {'top': 400, 'left': 200},
        hasShuffleTwist: true,
      ),
      // ...and so on for the rest of the levels
    ],
  ),

  //============================================================================
  // WORLD 5: OCEAN QUEST (Combined Twists)
  //============================================================================
  ThemeModel(
    id: 'ocean-quest',
    name: 'Ocean Quest 🌊',
    emoji: '🌊',
    worldMapBackgroundAsset: 'assets/images/maps/forest_map_bg.png',
    gameScreenBackgroundAsset: 'assets/images/backgrounds/forest_game_bg.png',
    headerBannerAsset: 'assets/images/ui/header_banner_forest.png',
    enabledNodeAsset: 'assets/images/nodes/forest_sign.png',
    disabledNodeAsset: 'assets/images/nodes/forest_sign_disabled.png',
    cardBackAsset: 'assets/images/cards/card_back_forest.png',
    mascotAssetPath: 'assets/animations/ollie_mascot.gif',
    levels: [
      LevelModel(
        id: 'ocean-quest_1',
        levelNumber: 1,
        name: 'Coral Countdown',
        cardValues: ['crab', 'starfish', 'seahorse'],
        position: {'top': 500, 'left': 80},
        moveLimit: 10,
        timerInSeconds: 30,
      ),
      // ...and so on
    ],
  ),

  //============================================================================
  // WORLD 6: MEMORY VAULT (3-Card Matches)
  //============================================================================
  ThemeModel(
    id: 'memory-vault',
    name: 'Memory Vault 🧠',
    emoji: '🧠',
    worldMapBackgroundAsset: 'assets/images/maps/forest_map_bg.png',
    gameScreenBackgroundAsset: 'assets/images/backgrounds/forest_game_bg.png',
    headerBannerAsset: 'assets/images/ui/header_banner_forest.png',
    enabledNodeAsset: 'assets/images/nodes/forest_sign.png',
    disabledNodeAsset: 'assets/images/nodes/forest_sign_disabled.png',
    cardBackAsset: 'assets/images/cards/card_back_forest.png',
    mascotAssetPath: 'assets/animations/ollie_mascot.gif',
    levels: [
      LevelModel(
        id: 'memory-vault_1',
        levelNumber: 1,
        name: 'Triplet Trial',
        cardValues: ['key', 'lock', 'chest'],
        position: {'top': 500, 'left': 80},
        isTriplet: true,
      ),
      // ...and so on
    ],
  ),

  //============================================================================
  // WORLD 7: FAIRY FLICKER (Triplets + Flicker Twist)
  //============================================================================
  ThemeModel(
    id: 'fairy-flicker',
    name: 'Fairy Flicker 🧚',
    emoji: '🧚',
    worldMapBackgroundAsset: 'assets/images/maps/forest_map_bg.png',
    gameScreenBackgroundAsset: 'assets/images/backgrounds/forest_game_bg.png',
    headerBannerAsset: 'assets/images/ui/header_banner_forest.png',
    enabledNodeAsset: 'assets/images/nodes/forest_sign.png',
    disabledNodeAsset: 'assets/images/nodes/forest_sign_disabled.png',
    cardBackAsset: 'assets/images/cards/card_back_forest.png',
    mascotAssetPath: 'assets/animations/ollie_mascot.gif',
    levels: [
      LevelModel(
        id: 'fairy-flicker_1',
        levelNumber: 1,
        name: 'Glimmerwood',
        cardValues: ['gnome', 'pixie', 'wand'],
        position: {'top': 500, 'left': 80},
        isTriplet: true,
        hasFlickerTwist: true,
      ),
      // ...and so on
    ],
  ),

  //============================================================================
  // WORLD 8: THE FINAL PEEK (The Gauntlet)
  //================================G============================================
  ThemeModel(
    id: 'final-peek',
    name: 'The Final Peek 🏆',
    emoji: '🏆',
    worldMapBackgroundAsset: 'assets/images/maps/forest_map_bg.png',
    gameScreenBackgroundAsset: 'assets/images/backgrounds/forest_game_bg.png',
    headerBannerAsset: 'assets/images/ui/header_banner_forest.png',
    enabledNodeAsset: 'assets/images/nodes/forest_sign.png',
    disabledNodeAsset: 'assets/images/nodes/forest_sign_disabled.png',
    cardBackAsset: 'assets/images/cards/card_back_forest.png',
    mascotAssetPath: 'assets/animations/ollie_mascot.gif',
    levels: [
      LevelModel(
        id: 'final-peek_1',
        levelNumber: 1,
        name: 'The Pinnacle',
        cardValues: ['crown', 'goblet', 'scepter'],
        position: {'top': 500, 'left': 80},
        isTriplet: true,
        timerInSeconds: 45,
      ),
      // ...and so on
    ],
  ),
];
