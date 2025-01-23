import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:multimedia_app/utils/utils.dart';

class AudioController extends GetxController {
  late AudioPlayer audioPlayer;
  var isPlaying = false.obs;
  var duration = Duration.zero.obs;
  var position = Duration.zero.obs;

  @override
  void onInit() {
    super.onInit();
    audioPlayer = AudioPlayer();
    setPath();

    // check for duration curr value and position
    audioPlayer.positionStream.listen((pos) => position.value = pos);
    audioPlayer.durationStream
        .listen((dur) => duration.value = dur ?? Duration.zero);

    // check for duration ended or not
    audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        isPlaying.value = false;
        audioPlayer.pause();
        audioPlayer.seek(Duration.zero);
      }
    });
  }

  Future<void> setPath() async {
    await audioPlayer.setAsset(Utils.audioPath);
  }

  void playAudio() {
    if (isPlaying.value) {
      isPlaying.value = false;
      audioPlayer.pause();
    } else {
      isPlaying.value = true;
      audioPlayer.play();
    }
  }

  void pauseAudio() {
    isPlaying.value = false;
    audioPlayer.pause();
  }

  @override
  void onClose() {
    super.onClose();
    audioPlayer.dispose();
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
