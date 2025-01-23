# User Authentication with Shared Preferences (Flutter)

This project demonstrates user authentication functionality in a Flutter app using Shared Preferences for local data storage and Provider for state management.

## Features:

### 1. **Splash Screen**
- Displays a 3-second animated splash screen with a logo using Flutter's `AnimationController`.

### 2. **Signup Screen**
- **Fields:** Username, email, password (with strength indicator).
- **Validations:** Ensures proper email format and non-empty fields.
- **State Management:** Updates the signup button state using `Provider` based on field validation.

### 3. **Login Screen**
- **Remember Me:** Checkbox to remember the user's login state.
- **Login State Management:** Login state managed with `Provider`.

### 4. **Main Screen**
- Displays user data (username, email) stored in Shared Preferences.
- **Logout:** Clears user data, resets `Provider` state, and removes data from Shared Preferences.

## Topics Covered:
- **Provider:** For managing app state (authentication, form validation).
- **Animations:** Flutter's `AnimationController` to display an animated splash screen.
- **Form Validation:** Validating inputs like email format and password strength.
- **Shared Preferences:** Storing and retrieving user authentication data locally.
