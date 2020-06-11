import 'dart:html' as html;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

enum CursorType { text, pointer, grab, none }

class CursorWidget extends MouseRegion {
  CursorWidget({
    @required Widget child,
    Function(PointerHoverEvent) onHover,
    Function(PointerExitEvent) onExit,
    CursorType cursorType = CursorType.pointer,
  }) : super(
          onHover: (evt) {
            if (onHover != null) {
              onHover(evt);
            }
            switch (cursorType) {
              case CursorType.text:
                _appContainer.style.cursor = 'text';
                break;
              case CursorType.pointer:
                _appContainer.style.cursor = 'pointer';
                break;
              case CursorType.grab:
                _appContainer.style.cursor = 'grab';
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
            if (onExit != null) {
              onExit(evt);
            }
            _appContainer.style.cursor = 'default';
          },
          child: child,
        );

  static final _appContainer =
      html.window.document.getElementById('app-container');
}
