library rolling_bottom_bar;

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:rolling_bottom_bar/constants.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';
import 'package:rolling_bottom_bar/rolling_painter.dart';

/// Class to generate the rolling bottom bar
class RollingBottomBar extends StatefulWidget {
  /// Controller for animation
  final PageController? controller;

  /// List of items to render into the bottom bar
  final List<Widget>? items;

  /// Function called when an item was tapped
  final ValueChanged<int>? onTap;

  /// Color to paint the custom paint and draw the bottom bar
  final ui.Gradient? barGradient;
  final ui.Gradient? circleGradient;

  RollingBottomBar(
      {Key? key,
      @required this.controller,
      @required this.items,
      @required this.onTap,
      this.barGradient,
      this.circleGradient,})
      : super(key: key);

  @override
  _RollingBottomBarState createState() => _RollingBottomBarState();
}

class _RollingBottomBarState extends State<RollingBottomBar> {
  double? _screenWidth;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenWidth = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final width = _size.width;
    const height = kHeight + kMargin * 2;

    return AnimatedBuilder(
      animation: widget.controller!,
      builder: (BuildContext _, Widget? child) {
        double _scrollPosition = 0.0;
        int _currentIndex = 0;
        if (widget.controller?.hasClients ?? false) {
          _scrollPosition = widget.controller!.page!;
          _currentIndex = (widget.controller!.page! + 0.5).toInt();
        }

        return Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            CustomPaint(
              size: Size(width, height),
              painter: RollingPainter(
                x: _itemXByScrollPosition(_scrollPosition),
                barGradient: widget.barGradient,
                circleGradient: widget.circleGradient,
              ),
            ),
            for (var i = 0; i < widget.items!.length; i++) ...[
              if (i == _currentIndex)
                Positioned(
                  top: (kMargin - kCircleRadius)+7.5,
                  left: kCircleMargin + _itemXByScrollPosition(_scrollPosition)+7.5,
                  width: 25,
                  height: 25,
                  child:RollingActiveItem(
                    i,
                    icon: widget.items![i],
                    scrollPosition: _scrollPosition,
                    onTap: widget.onTap,
                  ),
                ),
              if (i != _currentIndex)
                Positioned(
                  top: kMargin + (kHeight - kCircleRadius * 2) / 2,
                  left: kCircleMargin + _itemXByIndex(i),
                  child: RollingItem(
                    i,
                    icon: widget.items![i],
                    onTap: widget.onTap,
                  ),
                ),
            ],
          ],
        );
      },
    );
  }

  double _firstItemX() {
    return kMargin + (_screenWidth! - kMargin * 2) * 0.1;
  }

  double _lastItemX() {
    return _screenWidth! - kMargin - (_screenWidth! - kMargin * 2) * 0.1 - (kCircleRadius + kCircleMargin) * 2;
  }

  double _itemDistance() {
    return (_lastItemX() - _firstItemX()) / (widget.items!.length - 1);
  }

  double _itemXByScrollPosition(double scrollPosition) {
    return _firstItemX() + _itemDistance() * scrollPosition;
  }

  double _itemXByIndex(int index) {
    return _firstItemX() + _itemDistance() * index;
  }
}
