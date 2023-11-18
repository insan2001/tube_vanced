// Copyright 2020 Sarbagya Dhaubanjar. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/duration_formatter.dart';
import '../utils/youtube_player_controller.dart';

/// A widget to display darkened translucent overlay, when video area is touched.
///
/// Also provides ability to seek video by dragging horizontally.
class TouchShutter extends StatefulWidget {
  /// Overrides the default [YoutubePlayerController].
  final YoutubePlayerController? controller;

  /// If true, disables the drag to seek functionality.
  ///
  /// Default is false.
  final bool disableDragSeek;

  /// Sets the timeout until when the controls hide.
  final Duration timeOut;

  /// Creates [TouchShutter] widget.
  TouchShutter({
    this.controller,
    this.disableDragSeek = false,
    required this.timeOut,
  });

  @override
  _TouchShutterState createState() => _TouchShutterState();
}

class _TouchShutterState extends State<TouchShutter> {
  double dragStartPos = 0.0;
  double delta = 0.0;
  double scaleAmount = 0.0;
  int seekToPosition = 0;
  String seekDuration = "";
  String seekPosition = "";
  bool _dragging = false;
  Timer? _timer;

  late YoutubePlayerController _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final controller = YoutubePlayerController.of(context);
    if (controller == null) {
      assert(
        widget.controller != null,
        '\n\nNo controller could be found in the provided context.\n\n'
        'Try passing the controller explicitly.',
      );
      _controller = widget.controller!;
    } else {
      _controller = controller;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _toggleControls() {
    _controller.updateValue(
      _controller.value.copyWith(
        isControlsVisible: !_controller.value.isControlsVisible,
      ),
    );
    _timer?.cancel();
    _timer = Timer(widget.timeOut, () {
      if (!_controller.value.isDragging) {
        _controller.updateValue(
          _controller.value.copyWith(
            isControlsVisible: false,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.disableDragSeek
        ? GestureDetector(onTap: _toggleControls)
        : GestureDetector(
            onTap: _toggleControls,
            onDoubleTapDown: (details) {
              if (details.globalPosition.dx >
                  MediaQuery.of(context).size.width / 2) {
                _controller.seekTo(Duration(
                    seconds: _controller.value.position.inSeconds +
                        _controller.flags.skipDuration));
              } else {
                _controller.seekTo(Duration(
                    seconds: _controller.value.position.inSeconds -
                        _controller.flags.skipDuration));
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              color: _controller.value.isControlsVisible
                  ? Colors.black.withAlpha(150)
                  : Colors.transparent,
              child: _dragging
                  ? Center(
                      child: Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                          color: Colors.black.withAlpha(150),
                        ),
                        child: Text(
                          "$seekDuration ($seekPosition)",
                          style: const TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ),
          );
  }
}
