import 'package:flutter/material.dart';


class PopUpRoute extends ModalRoute {
  final Widget child;
  double up, down, left, right;

  PopUpRoute({
    this.child,
    this.up,
    this.down,
    this.left,
    this.right,
  }) {
    if (up == null) up = 20.0;
    if (down == null) down = 20.0;
    if (left == null) left = 20.0;
    if (right == null) right = 20.0;
  }

  @override
  Color get barrierColor => Colors.blueGrey.withOpacity(0.4);

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => 'PopUp';

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: Container(
          margin:
              EdgeInsets.only(top: up, bottom: down, left: left, right: right),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }

  @override
  bool get maintainState => false;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => Duration(milliseconds: 400);
}
