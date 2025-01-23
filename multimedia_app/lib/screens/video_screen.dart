import 'package:floating/floating.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:multimedia_app/controllers/video_controller.dart';
import 'package:video_player/video_player.dart';

import '../theme/colors.dart';
import '../utils/utils.dart';

class VideoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VideoPipController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(Utils.videoScreenName),
        automaticallyImplyLeading: false,
      ),
      body: Obx(
        () {
          return PiPSwitcher(
            // Displayed when PiP is disabled or in the foreground
            childWhenDisabled: SingleChildScrollView(
              child: Column(
                children: [
                  controller.isInitialized.value
                      ? _buildVideoWidget(controller)
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: controller.enablePip,
                    child: Text(
                      controller.isPipAvailable.value
                          ? Utils.enablePipText
                          : Utils.pipNotAvailable,
                      style: const TextStyle(color: AppColors.backgroundColor),
                    ),
                  ),
                ],
              ),
            ),
            // Displayed when PiP is enabled or in he background
            childWhenEnabled: _buildVideoWidget(controller),
          );
        },
      ),
    );
  }

  Widget _buildVideoWidget(VideoPipController controller) {
    return Center(
      child: AspectRatio(
        aspectRatio: controller.videoPlayerController.value.aspectRatio,
        child: Stack(
          children: [
            VideoPlayer(controller.videoPlayerController),
            _buildSubtitles(controller.currentSubtitleText),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: VideoProgressIndicator(
                controller.videoPlayerController,
                allowScrubbing: true,
                padding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubtitles(RxString subtitleText) {
    return Obx(() {
      return Positioned(
        bottom: 30,
        left: 20,
        right: 20,
        child: Text(
          subtitleText.value,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            backgroundColor: Colors.black.withOpacity(0.6),
          ),
          textAlign: TextAlign.center,
        ),
      );
    });
  }
}
