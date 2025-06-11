import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YTPlayer extends StatefulWidget {
  const YTPlayer({
    super.key,
    required this.initialVideoId,
  });

  final String initialVideoId;

  @override
  State<YTPlayer> createState() => _YTPlayerState();
}

class _YTPlayerState extends State<YTPlayer> {
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late final YoutubePlayerController? _ytController;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  void listener() {
    if (_isPlayerReady && mounted && !_ytController!.value.isFullScreen) {
      setState(() {
        _playerState = _ytController.value.playerState;
        _videoMetaData = _ytController.metadata;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _ytController = YoutubePlayerController(
      initialVideoId: widget.initialVideoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  @override
  void activate() {
    // TODO: implement activate
    super.activate();
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _ytController?.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    // _ytController?.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: _ytController!,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.orange,
        progressColors: const ProgressBarColors(
          playedColor: Colors.amber,
          handleColor: Colors.amberAccent,
        ),
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              _ytController.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
              size: 25.0,
            ),
            onPressed: () {
              print('Settings Tapped!');
            },
          ),
        ],
        onReady: () {
          _isPlayerReady = true;
          // _ytController?.addListener(listener);
        },
        bottomActions: [
          CurrentPosition(controller: _ytController),
          ProgressBar(isExpanded: true),
          RemainingDuration(controller: _ytController),
          PlaybackSpeedButton(),
          FullScreenButton(controller: _ytController),
        ],
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Youtube Player',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: ListView(
            children: [
              player,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _space,
                    _text('Title', _videoMetaData.title),
                    _space,
                    _text('Channel', _videoMetaData.author),
                    // _space,
                    // _text('Video Id', _videoMetaData.videoId),
                    _space,
                    Row(
                      children: [
                        _text(
                          'Playback Quality',
                          _ytController.value.playbackQuality ?? '',
                        ),
                        const Spacer(),
                        _text(
                          'Playback Rate',
                          '${_ytController.value.playbackRate}x  ',
                        ),
                      ],
                    ),
                    _space,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(
                            _ytController.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                          ),
                          onPressed: _isPlayerReady
                              ? () {
                                  _ytController.value.isPlaying
                                      ? _ytController.pause()
                                      : _ytController.play();
                                  setState(() {});
                                }
                              : null,
                        ),
                        IconButton(
                          icon:
                              Icon(_muted ? Icons.volume_off : Icons.volume_up),
                          onPressed: _isPlayerReady
                              ? () {
                                  _muted
                                      ? _ytController.unMute()
                                      : _ytController.mute();
                                  setState(() {
                                    _muted = !_muted;
                                  });
                                }
                              : null,
                        ),
                        FullScreenButton(
                          controller: _ytController,
                          color: Colors.orangeAccent,
                        ),
                      ],
                    ),
                    _space,
                    Row(
                      children: <Widget>[
                        const Text(
                          "Volume",
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                        Expanded(
                          child: Slider(
                            // inactiveColor: Colors.transparent,
                            value: _volume,
                            min: 0.0,
                            max: 100.0,
                            divisions: 10,
                            label: '${(_volume).round()}',
                            onChanged: _isPlayerReady
                                ? (value) {
                                    setState(() {
                                      _volume = value;
                                    });
                                    _ytController.setVolume(_volume.round());
                                  }
                                : null,
                          ),
                        ),
                      ],
                    ),
                    _space,
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 800),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: _getStateColor(_playerState),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _playerState.name.substring(0, 1).toUpperCase() +
                            _playerState.name.substring(1),
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _text(String title, String value) {
    return RichText(
      text: TextSpan(
        text: '$title : ',
        style: const TextStyle(
          color: Colors.orangeAccent,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
              color: Colors.orangeAccent,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStateColor(PlayerState state) {
    switch (state) {
      case PlayerState.unknown:
        return Colors.grey[700]!;
      case PlayerState.unStarted:
        return Colors.pink;
      case PlayerState.ended:
        return Colors.red;
      case PlayerState.playing:
        return Colors.orangeAccent;
      case PlayerState.paused:
        return Colors.orange;
      case PlayerState.buffering:
        return Colors.yellow;
      case PlayerState.cued:
        return Colors.blue[900]!;
    }
  }

  Widget get _space => const SizedBox(height: 10);

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}
