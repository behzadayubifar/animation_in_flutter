import 'package:animtaions_ba/ui/reset_button.dart';
import 'package:animtaions_ba/ui/start_stop_button.dart';
import 'package:animtaions_ba/ui/stopwatch_renderer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Stopwatch extends StatefulWidget {
  const Stopwatch({super.key});

  @override
  State<Stopwatch> createState() => _StopwatchState();
}

class _StopwatchState extends State<Stopwatch>
    with SingleTickerProviderStateMixin {
  Duration _previouslyElapsed = Duration.zero;
  Duration _currentlyElapsed = Duration.zero;
  Duration get _elapsed => _previouslyElapsed + _currentlyElapsed;
  late final Ticker _ticker;
  bool _isRunning = false;
  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      setState(() {
        _currentlyElapsed = elapsed;
      });
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _toggleRunning() {
    setState(() {
      if (!_isRunning) {
        _ticker.start();
        _previouslyElapsed += _currentlyElapsed;
        _currentlyElapsed = Duration.zero;
      } else {
        _ticker.stop();
      }
      _isRunning = !_isRunning;
    });
  }

  void _reset() {
    _ticker.stop();
    setState(() {
      _isRunning = false;
      _previouslyElapsed = Duration.zero;
      _currentlyElapsed = Duration.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      final radius = constrains.maxWidth / 2;
      return Stack(
        children: [
          StopwatchRenderer(
            elapsed: _elapsed,
            radius: radius,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: SizedBox(
              width: 80,
              height: 80,
              child: ResetButton(
                onPressed: _reset,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              width: 80,
              height: 80,
              child: StartStopButton(
                onPressed: _toggleRunning,
                isRunning: _isRunning,
              ),
            ),
          ),
        ],
      );
    });
  }
}
