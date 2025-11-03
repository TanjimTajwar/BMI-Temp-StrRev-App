# Trio-Angle 🎯

A beautiful Flutter application that combines three powerful tools in one app:
- **BMI Calculator** - Calculate your Body Mass Index with gender-specific inputs
- **String Reverser** - Reverse any text string instantly
- **Temperature Converter** - Convert between Celsius, Fahrenheit, and Kelvin

## 🚀 Features

### ✨ Home Page
- Modern gradient background
- Three attractive navigation cards with icons
- Smooth navigation between tools

### 📊 BMI Calculator
- Gender selection (Male/Female) with toggle buttons
- Input fields for Height (cm), Weight (kg), and Age
- Real-time BMI calculation
- Color-coded BMI categories (Underweight, Normal, Overweight, Obese)
- Health messages and recommendations
- Beautiful gradient cards and shadows

### 🔤 String Reverser
- Clean and elegant UI
- Text input field with validation
- Instant string reversal
- Empty input handling with Snackbar alerts
- Centered layout with proper spacing

### 🌡️ Temperature Converter
- Dropdown menus for From/To unit selection
- Support for Celsius, Fahrenheit, and Kelvin
- Visual unit indicators with icons
- Swap units functionality
- Colorful, minimal design with rounded containers

## 🎨 Design Highlights

- **Material 3 Design** - Built with Flutter's latest Material 3 design system
- **Responsive Layout** - Works beautifully on all device sizes
- **Gradient Backgrounds** - Eye-catching gradients throughout the app
- **Consistent Theming** - Unified color scheme and typography
- **Smooth Animations** - Polished user experience

## 📋 Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Android Emulator / iOS Simulator / Physical Device

## 🔧 Installation & Setup

1. **Navigate to the project directory:**
   ```bash
   cd trio_angle
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

## 📱 Usage

1. Launch the app to see the home screen with three feature cards
2. Tap on any card to navigate to that tool:
   - **BMI Calculator**: Enter your details and calculate your BMI
   - **String Reverser**: Type any text and reverse it
   - **Temperature Converter**: Select units and convert temperatures
3. Use the back button or system back gesture to return to the home screen

## 📁 Project Structure

```
trio_angle/
├── lib/
│   ├── main.dart              # App entry point and Material 3 theme
│   ├── home.dart              # Home screen with navigation cards
│   ├── bmi_calculator.dart    # BMI calculator with gender selection
│   ├── string_reverser.dart   # String reversal tool
│   └── temperature_converter.dart  # Temperature unit converter
├── pubspec.yaml               # Project dependencies
└── README.md                  # This file
```

## 🛠️ Technical Details

- **State Management**: StatefulWidget for local state
- **Navigation**: Navigator.push() and Navigator.pop()
- **Design System**: Material 3 with custom color scheme
- **Responsive**: Works on phones and tablets
- **Error Handling**: Input validation with user-friendly messages

## 📝 Code Quality

- Clean, modular code structure
- Well-commented code
- Proper widget separation
- Consistent naming conventions
- Material 3 best practices

## 🎯 Future Enhancements

Possible improvements for future versions:
- Dark mode support
- History/saved calculations
- More unit conversions
- Share functionality
- Animations and transitions

## 📄 License

This project is created for educational and demonstration purposes.

---

**Enjoy using Trio-Angle!** 🎉

