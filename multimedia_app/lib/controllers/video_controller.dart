import 'dart:async';

import 'package:flutter/material.dart';
import 'package:floating/floating.dart';
import 'package:get/get.dart';
import 'package:multimedia_app/utils/utils.dart';
import 'package:subtitle/subtitle.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

class VideoPipController extends GetxController {
  // For Video
  late VideoPlayerController videoPlayerController;
  RxBool isInitialized = false.obs;
  RxList<Subtitle> parsedSubtitles = <Subtitle>[].obs;

  // For pip
  final Floating pip = Floating();
  RxBool isPipAvailable = false.obs;

  // Fro subtitle
  late Timer subtitleTimer;
  RxString currentSubtitleText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    initializeVideoPlayer();
    checkPipAvailability();
    loadSubtitles();
    startSubtitleTimer();
  }

  void initializeVideoPlayer() {
    videoPlayerController = VideoPlayerController.asset(Utils.videoPath)
      ..initialize().then((_) {
        videoPlayerController.setLooping(true);
        videoPlayerController.play();
        isInitialized.value = true;
      });
  }

  Future<void> loadSubtitles() async {
    try {
      final srtContent = await rootBundle.loadString(Utils.srtFilePath);

      final subtitleObject = SubtitleObject(
        type: SubtitleType.srt,
        data: srtContent,
      );

      final parser = SubtitleParser(subtitleObject);
      final subtitles = parser.parsing();

      parsedSubtitles.value = subtitles;

      debugPrint(parsedSubtitles.toString());
    } catch (e) {
      debugPrint("Error loading subtitles: $e");
    }
  }

  void startSubtitleTimer() {
    subtitleTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      updateSubtitles();
    });
  }

  void updateSubtitles() {
    if (videoPlayerController.value.isInitialized) {
      //get curr position
      final currentPosition = videoPlayerController.value.position;

      // Update subtitle text based on current position
      for (var subtitle in parsedSubtitles) {
        if (currentPosition >= subtitle.start &&
            currentPosition <= subtitle.end) {
          currentSubtitleText.value = subtitle.data;
        }
      }

      // Update UI
      if (currentSubtitleText.value != currentSubtitleText.value) {
        currentSubtitleText.value = currentSubtitleText.value;
      }
    }
  }

  Future<void> checkPipAvailability() async {
    isPipAvailable.value = await pip.isPipAvailable;
  }

  void enablePip() {
    if (isPipAvailable.value) {
      pip.enable(
        const ImmediatePiP(
          aspectRatio: Rational.landscape(),
        ),
      );
    } else {
      Utils.pipModeNotAvailable();
    }
  }

  @override
  void onClose() {
    subtitleTimer.cancel();
    videoPlayerController.dispose();
    super.onClose();
  }
}
