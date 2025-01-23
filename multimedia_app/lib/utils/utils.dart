import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Utils {
  // Paths
  static const String audioPath = 'assets/audio.mp3';
  static const String videoPath = 'assets/video.mp4';
  static const String srtFilePath = 'assets/file.srt';

  // Video Screen
  static const String videoScreenName = 'Video Screen';
  static const String enablePipText = 'Enable Pip';
  static const String pipNotAvailable = 'Pip not available';

  // Audio Screen
  static const String audioScreenName = 'Audio Screen';
  static const String playBtnText = 'Play';
  static const String pauseBtnText = 'Pause';
  static const String playingStateText = 'Playing';
  static const String pausedStateText = 'Paused';

  // Image Screen
  static const String imageScreenName = 'Image Screen';
  static const noImageSelectedText = 'No image selected';

  // Image Controller Text
  static const String applyFilterText = 'Apply Filter';
  static const String imageFilteredKey = 'image_filtered';

  // functions
  // Image Controller
  static void unableToProcessImage() {
    Get.snackbar("Error", "Unable to process the selected image");
  }

  static void unknownFilteredImage() {
    Get.snackbar("Error", "Unknown filtered image format");
  }

  static void errWhileApplyingFilter() {
    Get.snackbar("Error", "An error occurred while applying the filter");
  }

  // Video Controller
  static void pipModeNotAvailable() {
    Get.snackbar("Error", "PiP mode is not supported on this device.");
  }
}
