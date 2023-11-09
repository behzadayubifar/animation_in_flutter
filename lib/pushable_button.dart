library pushable_button;

import 'package:animtaions_ba/animation_cotroller_state.dart';
import 'package:flutter/material.dart';

class PushableButton extends StatefulWidget {
  const PushableButton(
      {Key? key,
      this.child,
      required this.hslColor,
      required this.height,
      required this.elevation,
      this.onPressed, this.shadow,})
      : assert(height > 0),
        super(key: key);

  final Widget? child;
  final HSLColor hslColor;
  final double height;
  final double elevation;
  final BoxShadow? shadow;
  final VoidCallback? onPressed;

  @override
  _PushableButtonState createState() =>
      _PushableButtonState(Duration(milliseconds: 100));
}

class _PushableButtonState extends AnimationControllerState<PushableButton> {
  _PushableButtonState(Duration duration) : super(duration);

  bool _isDragInProgress = false;
  Offset _gestureLocation = Offset.zero;

  void _handleTapDown(TapDownDetails details){
    _gestureLocation = details.localPosition;
    animationController.forward();
  }
  void _handleTapUp(TapUpDetails details){
    animationController.reverse();
    widget.onPressed?.call();
  }
  void _handleTapCancel(){
    Future.delayed(Duration(milliseconds: 100), (){
      if (!_isDragInProgress && mounted) {
        animationController.reverse();
      }
    });
  }




  @override
  Widget build(BuildContext context) {
    final totalHeight = widget.height + widget.elevation;
    return SizedBox(
      height: totalHeight,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final buttonSize = Size(constraints.maxWidth, constraints.maxHeight);
          return GestureDetector(
            onTapDown: ,
            onTapUp: ,
            onTapCancel: ,
            onHorizontalDragStart: ,
            onHorizontalDragEnd: ,
            onHorizontalDragUpdate: ,
            onVerticalDragStart: ,
            onVerticalDragEnd: ,
            onVerticalDragCancel: ,
            onVerticalDragUpdate: ,
            child: AnimatedBuilder(animation: animationController,
            builder: (context, child) {
              final top = animationController.value * widget.elevation;
              final hslColor = widget.hslColor;
              final bottomHslColor = hslColor.withLightness(hslColor.lightness - 0.15);
              return Stack(
                children: [
                  Positioned(left: 0, right: 0, bottom: 0, child: Container(
                    height: totalHeight,
                    decoration: BoxDecoration(
                      color: bottomHslColor.toColor(),
                      boxShadow: widget.shadow != null ? [widget.shadow!] : [],borderRadius: BorderRadius.circular(
                        widget.height / 2,
                      ),
                    ),
                  )),
                  Positioned(left: 0, right: 0, top: top, child: Container(
                    height: widget.height,
                    decoration: ShapeDecoration(color: hslColor.toColor(), shape: StadiumBorder(), ),child: Center(child: widget.child,),
                  )),
                ],
              );
            },),
          );
        },
      ),
    );
  }
}
