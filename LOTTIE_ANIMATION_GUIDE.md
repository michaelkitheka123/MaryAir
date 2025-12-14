# How to Add Lottie Animation to MaryAir Welcome Screen

## ✨ Yes! You can use JSON animations (Lottie) for the logo!

### Step 1: Get a Lottie Animation

**Option A: Download from LottieFiles**
1. Go to [LottieFiles.com](https://lottiefiles.com)
2. Search for "airplane", "flight", "aviation", or "logo"
3. Download the JSON file (free animations available)
4. Popular choices:
   - Airplane taking off
   - Rotating globe with airplane
   - Paper airplane
   - Aviation badge

**Option B: Create Your Own**
- Use Adobe After Effects with Bodymovin plugin
- Use online tools like Haiku Animator

### Step 2: Add Animation to Project

1. Create folder structure:
   ```
   MaryAir/
   └── assets/
       └── animations/
           └── logo_animation.json
   ```

2. Place your downloaded JSON file in `assets/animations/`

### Step 3: Update Welcome Screen

Replace the logo Container (lines 67-92 in welcome_screen.dart) with:

```dart
import 'package:lottie/lottie.dart';  // Add this at top of file

// Replace the Container with:
Container(
  width: 200,
  height: 200,
  child: Lottie.asset(
    'assets/animations/logo_animation.json',
    fit: BoxFit.contain,
    repeat: true,  // Loop animation
    animate: true, // Auto-play
  ),
)
```

### Step 4: Advanced Options

**Control Animation Speed:**
```dart
Lottie.asset(
  'assets/animations/logo_animation.json',
  width: 200,
  height: 200,
  repeat: true,
  animate: true,
  frameRate: FrameRate(60), // Smooth 60fps
)
```

**Play Once on Load:**
```dart
class _WelcomeScreenState extends State<WelcomeScreen> 
    with TickerProviderStateMixin {
  late AnimationController _lottieController;

  @override
  void initState() {
    super.initState();
    _lottieController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ... other widgets
          Container(
            width: 200,
            height: 200,
            child: Lottie.asset(
              'assets/animations/logo_animation.json',
              controller: _lottieController,
              onLoaded: (composition) {
                _lottieController
                  ..duration = composition.duration
                  ..forward(); // Play once
              },
            ),
          ),
        ],
      ),
    );
  }
}
```

**Interactive Animation (Play on Hover):**
```dart
MouseRegion(
  onEnter: (_) => _lottieController.forward(),
  onExit: (_) => _lottieController.reverse(),
  child: Lottie.asset(
    'assets/animations/logo_animation.json',
    controller: _lottieController,
    width: 200,
    height: 200,
  ),
)
```

### Step 5: Recommended Free Animations

Search these on LottieFiles:
1. **"airplane takeoff"** - Dynamic flight animation
2. **"aviation logo"** - Professional airline branding
3. **"plane loading"** - Great for splash screens
4. **"world travel"** - Globe with airplane
5. **"flight path"** - Animated route lines

### Example: Complete Implementation

```dart
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../utils/constants.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  // ... existing animation controllers

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Stack(
        children: [
          // Top section with animated logo
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Text(
                    'WELCOME',
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w200,
                      color: Colors.grey[800],
                      letterSpacing: 12,
                    ),
                  ),
                  const SizedBox(height: 70),
                  
                  // 🎬 ANIMATED LOGO HERE
                  Container(
                    width: 200,
                    height: 200,
                    child: Lottie.asset(
                      'assets/animations/logo_animation.json',
                      fit: BoxFit.contain,
                      repeat: true,
                      animate: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // ... rest of your arcs and buttons
        ],
      ),
    );
  }
}
```

## 🎨 Styling Tips

**Add Background Circle:**
```dart
Container(
  width: 220,
  height: 220,
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    gradient: LinearGradient(
      colors: [Colors.blue[100]!, Colors.blue[50]!],
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.blue.withValues(alpha: 0.2),
        blurRadius: 30,
        offset: Offset(0, 10),
      ),
    ],
  ),
  child: Center(
    child: Lottie.asset(
      'assets/animations/logo_animation.json',
      width: 180,
      height: 180,
    ),
  ),
)
```

## 📦 Package Already Added!

✅ `lottie: ^3.1.3` is now in your pubspec.yaml
✅ Assets folder configured
✅ Ready to use!

## Next Steps

1. **Download** a Lottie animation from LottieFiles
2. **Create** `assets/animations/` folder in your project
3. **Add** the JSON file to that folder
4. **Update** welcome_screen.dart with the code above
5. **Run** `flutter pub get` (already done!)
6. **Test** the animation!

Would you like me to implement this in your welcome screen now?
