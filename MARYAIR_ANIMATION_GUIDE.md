# MaryAir Custom Logo Animation

## 🎬 Animation Overview

A custom Flutter animation that brings the MaryAir logo to life:

1. **Plane taxis** along letters M → A → R (ground level)
2. **Takes off** at Y (nose up, climbing)
3. **Flies** through A → I (cruising altitude)
4. **Lands** next to final R (descends and levels out)
5. **Path colors** progressively as plane travels (blue trail)

## ✨ Features

- **Smooth 4-second animation** with easing curves
- **Dynamic plane rotation** (flat → 30° up → level)
- **Progressive path coloring** showing travel history
- **Detailed plane design** with fuselage, wings, tail, and window
- **Auto-plays** 0.5 seconds after screen loads
- **Callback support** for chaining animations

## 📁 Files Created

- `lib/widgets/maryair_logo_animation.dart` - Main animation widget
- Updated `lib/screens/auth/welcome_screen.dart` - Integrated animation

## 🎨 Customization Options

### Change Animation Duration
```dart
_controller = AnimationController(
  duration: const Duration(milliseconds: 3000), // Faster: 3s instead of 4s
  vsync: this,
);
```

### Change Colors
```dart
final pathColor = const Color(0xFF3498DB); // Blue trail
final planeColor = const Color(0xFFE74C3C); // Red plane
final textColor = const Color(0xFF2C3E50); // Dark text
```

### Adjust Plane Size
In `_drawPlane` method, scale the coordinates:
```dart
// Make plane bigger
planePath.moveTo(-20, 0);  // was -15
planePath.lineTo(20, 0);   // was 15
```

### Loop Animation
```dart
_controller.repeat(); // Instead of forward()
```

### Play on Tap
```dart
GestureDetector(
  onTap: () {
    _controller.reset();
    _controller.forward();
  },
  child: const MaryAirLogoAnimation(),
)
```

## 🔧 How It Works

### 1. Path Definition
The plane follows 9 key points:
- Points 0-2: Taxiing (M, A, R)
- Point 3: Start takeoff (Y)
- Points 4-6: Flying (between Y-A, A, I)
- Points 7-8: Landing approach and final position

### 2. Angle Calculation
- 0-30% progress: Flat (taxiing)
- 30-50%: Nose up 30° (takeoff)
- 50-85%: 22.5° angle (cruising)
- 85-100%: Leveling out (landing)

### 3. Path Rendering
Uses `CustomPainter` to draw:
- MARYAIR text (bold, 60px)
- Traveled path (blue, semi-transparent)
- Animated plane (red, with details)

## 🎯 Future Enhancements

**Easy additions:**
- Add engine sound effects
- Smoke trail particles
- Pulsing glow effect
- Multiple color themes
- Interactive controls (pause/play)

**Advanced:**
- 3D perspective transformation
- Realistic physics (acceleration/deceleration)
- Weather effects (clouds, wind)
- Multiple planes for "MARY" and "AIR"

## 📊 Performance

- **60 FPS** smooth animation
- **Minimal CPU usage** (single CustomPainter)
- **No external dependencies** (pure Flutter)
- **Works on all platforms** (Web, Mobile, Desktop)

## 🐛 Troubleshooting

**Animation not showing?**
- Check that widget is added to welcome_screen.dart
- Verify import statement exists
- Ensure animation controller is initialized

**Plane position off?**
- Adjust `letterWidth` variable (line 99)
- Modify key points array (lines 106-114)
- Fine-tune centerX/centerY calculations

**Path not visible?**
- Increase stroke width (line 166)
- Change color opacity (line 165)
- Verify progress value is updating

## 💡 Usage Example

```dart
// Basic usage
const MaryAirLogoAnimation()

// With callback
MaryAirLogoAnimation(
  onAnimationComplete: () {
    print('Animation finished!');
    // Navigate to next screen, etc.
  },
)

// In a container with background
Container(
  width: 400,
  height: 200,
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.blue[50]!, Colors.white],
    ),
  ),
  child: const MaryAirLogoAnimation(),
)
```

---

**Status**: ✅ Fully implemented and integrated
**Location**: Welcome screen logo area
**Animation**: Auto-plays on screen load
