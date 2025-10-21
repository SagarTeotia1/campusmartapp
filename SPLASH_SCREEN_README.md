# Crazypeeps Splash Screen

## Overview
A professional splash screen implementation for the Crazypeeps app with smooth animations and modern design.

## Features

### 🎨 Design Elements
- **Company Branding**: Features "Crazypeeps" logo and tagline "Where Ideas Come Alive"
- **Color Scheme**: Uses the app's theme colors (olive green, sage green, cream, taupe)
- **Modern UI**: Clean, professional design with gradient backgrounds and shadows

### ✨ Animations
- **Logo Animation**: Scale and rotation effects with elastic curve
- **Text Animation**: Slide-in effect for company name and tagline
- **Fade Animation**: Smooth fade-in for loading indicator
- **Loading Indicator**: Circular progress indicator with branded colors

### 🏗️ Architecture
- **Clean Code Structure**: Follows Flutter best practices
- **Proper State Management**: Uses AnimationController for smooth animations
- **Navigation**: Automatic navigation to home screen after splash
- **Theme Integration**: Fully integrated with app theme system

## File Structure
```
lib/
├── features/
│   ├── splash/
│   │   └── presentation/
│   │       └── screens/
│   │           └── splash_screen.dart
│   └── home/
│       └── presentation/
│           └── screens/
│               └── home_screen.dart
├── app/
│   ├── app.dart
│   ├── route.dart
│   └── theme.dart
└── main.dart
```

## Key Components

### SplashScreen Widget
- **StatefulWidget** with animation controllers
- **Multiple Animation Controllers** for different animation sequences
- **Automatic Navigation** after splash sequence completes
- **Responsive Design** that works on all screen sizes

### Animation Sequence
1. Logo scales in with elastic effect (1.5s)
2. Text slides in from bottom (1s, delayed 0.5s)
3. Loading indicator fades in (0.8s, delayed 0.8s)
4. Navigation to home screen (after 2s total)

### Theme Integration
- Uses `AppTheme` colors throughout
- Supports both light and dark themes
- Consistent with app's design system

## Usage
The splash screen is automatically shown when the app starts. It will:
1. Display the Crazypeeps branding
2. Play smooth animations
3. Show loading indicator
4. Navigate to the home screen after 2 seconds

## Customization
To customize the splash screen:
1. **Duration**: Modify the `Duration` values in `_startSplashSequence()`
2. **Colors**: Update colors in `AppTheme` class
3. **Logo**: Replace the `Icons.psychology` with your custom logo
4. **Text**: Modify the company name and tagline text

## Testing
The splash screen includes unit tests that verify:
- App loads correctly
- Crazypeeps text is displayed
- Tagline is shown
- Animations complete without errors

Run tests with:
```bash
flutter test
```

## Dependencies
- Flutter SDK 3.9.2+
- No additional dependencies required
- Uses only Flutter's built-in animation and material widgets
