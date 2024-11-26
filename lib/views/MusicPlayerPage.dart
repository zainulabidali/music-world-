import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io';
import 'package:lottie/lottie.dart';

class MusicPlayerPage extends StatefulWidget {
  final FileSystemEntity file;
  final AudioPlayer audioPlayer;
  final ValueNotifier<Duration> currentPositionNotifier;
  final List<FileSystemEntity> audioFiles;
  final VoidCallback onPlayNext;
  final VoidCallback onPlayPrevious;

  MusicPlayerPage({
    required this.file,
    required this.audioPlayer,
    required this.currentPositionNotifier,
    required this.audioFiles,
    required this.onPlayNext,
    required this.onPlayPrevious,
  });

  @override
  _MusicPlayerPageState createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage>
    with SingleTickerProviderStateMixin {
  bool isPlaying = false;
  bool isFavorited = false;
  bool isMuted = false;
  double previousVolume = 1.0;
  Duration totalDuration = Duration.zero;
  late AnimationController _animationController;
  double _backgroundOpacity = 120.0;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(seconds: 10), vsync: this)
          ..forward()
          ..repeat();

    widget.audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        totalDuration = duration;
      });
    });

    widget.audioPlayer.onPositionChanged.listen((position) {
      widget.currentPositionNotifier.value = position;
    });

    playAudio();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _backgroundOpacity = 1.0;
      });
    });
  }

  Future<void> playAudio() async {
    await widget.audioPlayer.setSourceDeviceFile(widget.file.path);
    await widget.audioPlayer.resume();
    setState(() {
      isPlaying = true;
    });
  }

  Future<void> _playPause() async {
    if (isPlaying) {
      await widget.audioPlayer.pause();
      _animationController.stop();
    } else {
      await widget.audioPlayer.resume();
      _animationController.forward();
      _animationController.repeat();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void _toggleMute() {
    setState(() {
      if (isMuted) {
        widget.audioPlayer.setVolume(previousVolume);
      } else {
        previousVolume = widget.audioPlayer.volume;
        widget.audioPlayer.setVolume(0.0);
      }
      isMuted = !isMuted;
    });
  }

  void _toggleFavorite() {
    setState(() {
      isFavorited = !isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text("Club 14"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background Image that fills the entire screen
          Positioned.fill(
            child: AnimatedOpacity(
              opacity: _backgroundOpacity,
              duration: Duration(seconds: 2),
              child: Image.asset(
                'assets/img3.jpg', // Replace with your image path
                fit: BoxFit.cover, // Ensure the image covers the entire screen
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Lottie.asset(
                        'assets/play_time.json',
                        controller: _animationController,
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: ValueListenableBuilder<Duration>(
                          valueListenable: widget.currentPositionNotifier,
                          builder: (context, position, child) {
                            return CircularProgressIndicator(
                              value: totalDuration.inMilliseconds > 0
                                  ? position.inMilliseconds /
                                      totalDuration.inMilliseconds
                                  : 0,
                              backgroundColor: Colors.white,
                              color: Colors.yellow,
                              strokeWidth: 5,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 100),

                // Unified container for song details and controls
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.file.path.split('/').last,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Listen Music",
                          style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.skip_previous,
                                  color: Colors.white),
                              iconSize: 40,
                              onPressed: widget.onPlayPrevious,
                            ),
                            SizedBox(width: 20),
                            IconButton(
                              iconSize: 64,
                              icon: Icon(
                                isPlaying
                                    ? Icons.pause_circle
                                    : Icons.play_circle,
                                color: Colors.white,
                              ),
                              onPressed: _playPause,
                            ),
                            SizedBox(width: 20),
                            IconButton(
                              icon: Icon(Icons.skip_next, color: Colors.white),
                              iconSize: 40,
                              onPressed: widget.onPlayNext,
                            ),
                            SizedBox(width: 20),
                            IconButton(
                              icon: Icon(
                                  isMuted ? Icons.volume_off : Icons.volume_up),
                              iconSize: 25,
                              color: Colors.white,
                              onPressed: _toggleMute,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: IconButton(
              icon: Icon(
                isFavorited ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
              iconSize: 36,
              onPressed: _toggleFavorite,
            ),
          ),
        ],
      ),
    );
  }
}
