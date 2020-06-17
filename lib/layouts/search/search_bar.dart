import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../constants/app_colors.dart';
import '../../constants/strings.dart';
import '../../model/meal_filter.dart';
import '../common/hand_cursor_inkwell.dart';
import '../common/horizontal_spacer.dart';
import '../common/hud_overlay.dart';
import '../filter/filter_overlay.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    @required this.initialFilter,
    this.onSearchTextChange,
    this.onFilterApply,
    Key key,
  }) : super(key: key);
  final ValueChanged<String> onSearchTextChange;
  final ValueChanged<MealFilter> onFilterApply;
  final MealFilter initialFilter;

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();
  static OverlayEntry _overlayEntry;

  @override
  Widget build(BuildContext context) {
    _controller.addListener(() => widget.onSearchTextChange(_controller.text));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              filled: true,
              hintText: Strings.search,
              fillColor: AppColors.textFormField,
              focusColor: AppColors.textFormField,
              hoverColor: AppColors.textFormField,
              disabledBorder: InputBorder.none,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Card(
          child: HandCursorInkWell(
            onClick: _onFilterButtonClick,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: const [
                  Icon(
                    MaterialIcons.filter_list,
                    size: 16,
                  ),
                  HorizontalSpacer(),
                  Text(
                    Strings.filter,
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  static void _insertOverlay(BuildContext context) {
    final overlay = Overlay.of(context);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => overlay.insert(_overlayEntry));
  }

  static void _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry.remove();
      _overlayEntry = null;
    }
  }

  void _onFilterButtonClick() {
    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(
        builder: (context) => HUDOverlay(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .3,
            height: MediaQuery.of(context).size.height * .85,
            child: Card(
              child: FilterOverlay(
                onCloseButtonClick: _removeOverlay,
                onApplyFilterClick: (value) {
                  widget.onFilterApply(value);
                  _removeOverlay();
                },
                mealFilter: widget.initialFilter,
              ),
            ),
          ),
        ),
      );
      _insertOverlay(context);
    }
  }
}
