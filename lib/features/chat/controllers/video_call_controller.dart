import 'dart:async';
import 'package:get/get.dart';
import '../models/video_call_model.dart';

class VideoCallController extends GetxController {
  // Model
  late VideoCallModel callData;

  // Reactive state
  final isMuted = false.obs;
  final isSpeaker = false.obs;
  final seconds = 0.obs;

  Timer? _timer;

  void initCall(VideoCallModel model) {
    callData = model;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      seconds.value += 1;
    });
  }

  void toggleMute() => isMuted.toggle();
  void toggleSpeaker() => isSpeaker.toggle();

  void endCall() {
    _timer?.cancel();
    // Add cleanup logic here (signal server, dispose streams, etc.)
    Get.back();
  }

  String get formattedTime {
    final s = seconds.value;
    final mm = (s ~/ 60).toString().padLeft(2, '0');
    final ss = (s % 60).toString().padLeft(2, '0');
    return "$mm:$ss";
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
