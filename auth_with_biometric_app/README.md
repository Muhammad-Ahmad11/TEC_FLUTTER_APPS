# User Authentication with Hive Database (Flutter)

This Flutter app implements user authentication using Hive for secure local storage and Riverpod for reactive state management. It includes biometric authentication (fingerprint/face unlock) and profile picture upload.

## Features:

### 1. **Signup Screen**
- **Profile Picture Upload:** Allows users to upload a profile picture using the `image_picker` package.
- **Biometric Authentication:** Registers and stores biometric authentication data using `Riverpod` for state management.

### 2. **Login Screen**
- **Biometric Login:** Supports login using biometric methods (fingerprint/face unlock) for a seamless user experience.

### 3. **Main Screen**
- Displays user data (profile picture, username, etc.) in a reactive manner using `Riverpod`.
- **Logout:** Clears stored user data from Hive and resets Riverpod state.

## Topics Covered:
- **Hive:** Secure local storage with encryption for user data.
- **Riverpod:** Reactive state management for real-time updates.
- **File Handling:** Managing image uploads using the `image_picker` package.
- **Biometric Authentication:** Implementing biometric login (fingerprint/face unlock) for added security.

