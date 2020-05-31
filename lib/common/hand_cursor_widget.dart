import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

enum CursorType { text, pointer, none }

class HandCursor extends MouseRegion {
  HandCursor({
    @required Widget child,
    CursorType cursorType = CursorType.pointer,
  }) : super(
          onHover: (evt) {
            switch (cursorType) {
              case CursorType.text:
                _appContainer.style.cursor = 'text';
                break;
              case CursorType.pointer:
                _appContainer.style.cursor = 'pointer';
                break;
              case CursorType.none:
                _appContainer.style.cursor = 'default';
                break;
              default:
                _appContainer.style.cursor = 'pointer';
                break;
            }
          },
          onExit: (evt) {
            _appContainer.style.cursor = 'default';
          },
          child: child,
        );

  static final _appContainer =
      html.window.document.getElementById('app-container');
}
