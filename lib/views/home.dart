import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:spotify_clone/views/drawer/drawer.dart';
import 'dart:io';
import 'MusicPlayerPage.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<FileSystemEntity> _audioFiles = [];
  final ValueNotifier<Duration> _currentPositionNotifier =
      ValueNotifier(Duration.zero);
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  int _currentIndex = -1;
  Duration _totalDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    requestPermissions();

    _audioPlayer.onPositionChanged.listen((position) {
      _currentPositionNotifier.value = position;
    });

    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _totalDuration = duration;
      });
    });

    _audioPlayer.onPlayerComplete.listen((_) {
      _playNext();
    });
  }

  Future<void> requestPermissions() async {
    await Permission.storage.request();
    if (await Permission.storage.isGranted) {
      fetchAudioFiles();
    }
  }

  Future<void> fetchAudioFiles() async {
    List<FileSystemEntity> files = [];
    List<FileSystemEntity> music =
        Directory('/storage/emulated/0/Music').listSync(recursive: true);
    List<FileSystemEntity> download =
        Directory('/storage/emulated/0/Download').listSync(recursive: true);
    files.addAll([...music, ...download]);
    List<FileSystemEntity> audioFiles = files.where((file) {
      final path = file.path.toLowerCase();
      return path.endsWith('.mp3') ||
          path.endsWith('.wav') ||
          path.endsWith('.m4a') ||
          path.endsWith('.aac');
    }).toList();

    setState(() {
      _audioFiles = audioFiles;
    });
  }

  Future<void> _playAudio(int index) async {
    if (index >= 0 && index < _audioFiles.length) {
      final file = _audioFiles[index];
      await _audioPlayer.play(DeviceFileSource(file.path));
      setState(() {
        _isPlaying = true;
        _currentIndex = index;
      });
    }
  }

  Future<void> _togglePlayPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      if (_currentIndex == -1 && _audioFiles.isNotEmpty) {
        await _playAudio(0);
      } else {
        await _audioPlayer.resume();
      }
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  Future<void> _playNext() async {
    if (_currentIndex + 1 < _audioFiles.length) {
      await _playAudio(_currentIndex + 1);
    }
  }

  Future<void> _playPrevious() async {
    if (_currentIndex - 1 >= 0) {
      await _playAudio(_currentIndex - 1);
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 249, 208, 1),
        title: Text("Club 14"),
        

        
      ),
      body: Column(
        children: [
          Expanded(
            child: _audioFiles.isNotEmpty
                ? ListView.builder(
                    itemCount: _audioFiles.length,
                    itemBuilder: (context, index) {
                      final file = _audioFiles[index];
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom:
                                5), // Adds 5 pixels of space below each ListTile
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          tileColor: Colors.yellow[100],
                          title: Text(
                            file.path.split('/').last,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            "Unknown Artist",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[400],
                            ),
                          ),
                          leading: Icon(
                            Icons.music_note,
                            size: 40,
                            color: Colors.yellow,
                          ),
                          trailing: _currentIndex == index && _isPlaying
                              ? Icon(Icons.play_arrow_rounded,
                                  color: Colors.white, size: 26)
                              : null,
                          onTap: () {
                            _playAudio(index);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MusicPlayerPage(
                                  file: file,
                                  audioPlayer: _audioPlayer,
                                  currentPositionNotifier:
                                      _currentPositionNotifier,
                                  audioFiles: _audioFiles,
                                  onPlayNext: _playNext,
                                  onPlayPrevious: _playPrevious,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  )
                : Center(child: CircularProgressIndicator()),
          ),
          if (_audioFiles.isNotEmpty) ...[
            ValueListenableBuilder<Duration>(
              valueListenable: _currentPositionNotifier,
              builder: (context, position, child) {
                return LinearProgressIndicator(
                  value: _totalDuration.inMilliseconds > 0
                      ? position.inMilliseconds / _totalDuration.inMilliseconds
                      : 0,
                  backgroundColor: Colors.grey[400],
                  color: Colors.yellow,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 20.0), // Adjust the vertical padding as needed
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.black
                      .withOpacity(0.3), // Semi-transparent dark background
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, 5), // Offset for a soft shadow effect
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.skip_previous),
                      iconSize: 36,
                      color: Colors.white, // Icon color for better contrast
                      onPressed: _playPrevious,
                    ),
                    SizedBox(width: 15), // Space between the icons
                    IconButton(
                      icon: Icon(
                          _isPlaying ? Icons.pause_circle : Icons.play_circle),
                      iconSize: 48,
                      color:
                          Colors.yellow, // Stand-out color for play/pause icon
                      onPressed: _togglePlayPause,
                    ),
                    SizedBox(width: 15),
                    IconButton(
                      icon: Icon(Icons.skip_next),
                      iconSize: 36,
                      color: Colors.white,
                      onPressed: _playNext,
                    ),
                  ],
                ),
              ),
            )
          ],
        ],
      ),
      drawer: CustomDrawer(),
    );
  }
}
