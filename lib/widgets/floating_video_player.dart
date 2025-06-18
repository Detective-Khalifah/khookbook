import "package:flutter/material.dart";
import "package:khookbook/widgets/youtube_player.dart";
import "package:youtube_player_flutter/youtube_player_flutter.dart";

class FloatingVideoPlayer extends StatefulWidget {
  final String videoId;
  final VoidCallback onClose;

  const FloatingVideoPlayer({
    super.key,
    required this.videoId,
    required this.onClose,
  });

  @override
  State<FloatingVideoPlayer> createState() => _FloatingVideoPlayerState();
}

class _FloatingVideoPlayerState extends State<FloatingVideoPlayer> {
  late YoutubePlayerController _controller;
  Offset _position = const Offset(20, 100);
  Size _size = const Size(200, 120);
  bool _isExpanded = false;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    // Ensure cleanup
    widget.onClose();
    super.dispose();
  }

  void _toggleSize() {
    setState(() {
      _isExpanded = !_isExpanded;
      _size = _isExpanded ? const Size(320, 180) : const Size(200, 120);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _position.dx,
      top: _position.dy,
      child: GestureDetector(
        onPanStart: (details) {
          setState(() => _isDragging = true);
        },
        onPanEnd: (details) {
          setState(() => _isDragging = false);
        },
        onPanUpdate: (details) {
          if (!_isDragging) return;
          final newPosition = _position + details.delta;
          // Keep within screen bounds
          final size = MediaQuery.of(context).size;
          setState(() {
            _position = Offset(
              newPosition.dx.clamp(0, size.width - _size.width),
              newPosition.dy.clamp(0, size.height - _size.height - 40),
            );
          });
        },
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: _size.width,
            height: _size.height + 40,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: _size.height,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    child: YTPlayer(initialVideoId: widget.videoId),
                    // YoutubePlayer(
                    //   controller: _controller,
                    //   showVideoProgressIndicator: true,
                    //   progressIndicatorColor: Colors.red,
                    //   progressColors: const ProgressBarColors(
                    //     playedColor: Colors.red,
                    //     handleColor: Colors.redAccent,
                    //   ),
                    // ),
                  ),
                ),
                Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(_isExpanded ? Icons.compress : Icons.expand),
                        onPressed: _toggleSize,
                        color: Colors.white,
                        iconSize: 20,
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: widget.onClose,
                        color: Colors.white,
                        iconSize: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
