import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:multimedia_app/theme/colors.dart';
import 'package:multimedia_app/utils/utils.dart';

import '../controllers/audio_controller.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  final audioController = Get.put(AudioController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(Utils.audioScreenName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          final duration = audioController.duration.value.inSeconds.toDouble();
          final position = audioController.position.value.inSeconds.toDouble();
          final progress =
              (position / (duration == 0 ? 1 : duration)).clamp(0.0, 1.0);

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Slider(
                  value: progress,
                  onChanged: (value) async {
                    final newPosition =
                        Duration(seconds: (value * duration).toInt());
                    await audioController.audioPlayer.seek(newPosition);
                  },
                  activeColor: AppColors.primaryColor,
                  inactiveColor: AppColors.secondaryColor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      audioController
                          .formatDuration(audioController.position.value),
                      style: const TextStyle(color: AppColors.textColor),
                    ),
                    Text(
                      audioController
                          .formatDuration(audioController.duration.value),
                      style: const TextStyle(color: AppColors.textColor),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: audioController.playAudio,
                      icon: Icon(
                        audioController.isPlaying.value
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: AppColors.primaryColor,
                        size: 40,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  audioController.isPlaying.value
                      ? Utils.playingStateText
                      : (audioController.position.value >=
                                  audioController.duration.value &&
                              audioController.duration.value > Duration.zero
                          ? Utils.playingStateText
                          : Utils.pausedStateText),
                  style:
                      const TextStyle(fontSize: 16, color: AppColors.textColor),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
