library rolling_bottom_bar;

import 'package:flutter/material.dart';
import 'constants.dart';
/// Class to generate the unactive icon on bottom bar
class RollingItem extends StatelessWidget {
  const RollingItem(this.index, {this.icon, this.onTap});

  /// Int value to indicate the index on app bar
  final int index;

  /// Value necessary to render the icon
  final Widget? icon;

  /// Function called when an item was tapped
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: SizedBox.fromSize(
        size: const Size(kCircleRadius * 2, kCircleRadius * 2),
        child: RawMaterialButton(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: kItemSize,width: kItemSize,child: icon,),
            ],
          ),
          onPressed: () => onTap!(index),
        ),
      ),
    );
  }
}

/// Class to generate the active icon on bottom bar
class RollingActiveItem extends StatelessWidget {
  const RollingActiveItem(
    this.index, {
    this.icon,
    this.scrollPosition,
    this.onTap,
  });

  /// Int value to indicate the index on app bar
  final int index;

  /// Value necessary to render the icon
  final Widget? icon;

  /// Double value to indicate the item position
  final double? scrollPosition;

  /// Function called when an item was tapped
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    var media=MediaQuery.of(context);

    return InkWell(
    //  child: SizedBox.fromSize(
       // size: Size(kCircleRadius * 2.5*media.size.aspectRatio, kCircleRadius * 2.5*media.size.aspectRatio),
        child: icon,
    //  ),
      onTap: () => onTap!(index),
    );
  }
}
