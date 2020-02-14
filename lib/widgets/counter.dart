import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnimatedCounter extends ImplicitlyAnimatedWidget {
  final int number;
  final double fontSize;
  final Color color;
  final Color textColor;

  AnimatedCounter({
    Key key,
    @required this.number,
    this.color,
    Duration duration = const Duration(milliseconds: 500),
    Curve curve = Curves.linear,
    this.fontSize,
    this.textColor
  }) : super(
          key: key,
          duration: duration,
          curve: curve,
        );

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _AnimatedCounterState();
}

class _AnimatedCounterState extends AnimatedWidgetBaseState<AnimatedCounter> {
  IntTween _counter;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color,
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 4.0,
      ),
      child: Text(
        NumberFormat.decimalPattern().format( _counter.evaluate(animation)).toString(),
        style: TextStyle(
          fontSize: widget.fontSize,
          fontFamily: 'Bebas',
          fontWeight: FontWeight.w700,
          color: widget.textColor,
        ),
      ),
    );
  }

  @override
  void forEachTween(visitor) {
    _counter = visitor(
      _counter,
      widget.number,
      (dynamic value) => IntTween(begin: value),
    );
  }
}
