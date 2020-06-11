import 'package:flutter/material.dart';

import 'cursor_widget.dart';

class HandCursorInkWell extends StatelessWidget {
  const HandCursorInkWell({
    @required this.child,
    this.onClick,
    this.borderRadius = const RoundedRectangleBorder(),
    Key key,
  }) : super(key: key);
  final Widget child;
  final Function onClick;
  final ShapeBorder borderRadius;

  @override
  Widget build(BuildContext context) {
    return _handCursorInkWell;
  }

  Widget get _handCursorInkWell {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        customBorder: borderRadius,
        onTap: onClick,
        child: CursorWidget(
          cursorType: onClick != null ? CursorType.pointer : CursorType.none,
          child: child,
        ),
      ),
    );
  }
}
