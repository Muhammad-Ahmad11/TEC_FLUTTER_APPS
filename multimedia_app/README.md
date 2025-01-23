# Multimedia App (Flutter)

This Flutter app is a multimedia player that allows users to view images, listen to audio, and watch videos. It includes a custom audio player, image editing features, and a video player with Picture-in-Picture (PiP) mode. GetX is used for state management to handle media transitions smoothly.

## Features:

### 1. **State Management**
- **GetX** is used for managing the media state transitions (e.g., switching between audio, image, and video screens).

### 2. **Bottom Navigation Bar**
- Persistent navigation between the audio, image, and video screens with a bottom navigation bar.

### 3. **Audio Screen**
- Custom audio player built using any preferred package (e.g., `audioplayers` or `just_audio`).

### 4. **Image Screen**
- Display images and provide basic editing functionality using a preferred image editing package.

### 5. **Video Screen**
- Video playback with a floating player, allowing users to minimize and continue watching in PiP mode.
- **Subtitles:** Option to add and display subtitles (SRT files) during video playback.

## Topics Covered:
- **Multimedia Handling:** Managing audio, images, and video files in a Flutter app.
- **GetX:** Efficient state management for handling transitions between media states.
- **Floating Widgets:** Implementation of floating video player and Picture-in-Picture (PiP) mode.