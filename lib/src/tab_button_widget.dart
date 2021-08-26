import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tabbed_view/src/tab_button.dart';
import 'package:tabbed_view/src/tabbed_view_data.dart';
import 'package:tabbed_view/src/tabbed_view_menu_item.dart';
import 'package:tabbed_view/src/theme/button_colors.dart';

/// Widget for tab buttons. Used for any tab button such as the close button.
class TabButtonWidget extends StatefulWidget {
  TabButtonWidget(
      {required this.data,
      required this.button,
      required this.enabled,
      required this.iconSize,
      required this.colors});

  final TabbedViewData data;
  final TabButton button;
  final double iconSize;
  final ButtonColors colors;
  final bool enabled;

  @override
  State<StatefulWidget> createState() => TabButtonWidgetState();
}

/// The [TabButtonWidget] state.
class TabButtonWidgetState extends State<TabButtonWidget> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    Color color = widget.button.color != null
        ? widget.button.color!
        : widget.colors.normal;

    Color hoverColor = widget.button.hoverColor != null
        ? widget.button.hoverColor!
        : widget.colors.hover;

    bool hasEvent =
        widget.button.onPressed != null || widget.button.menuBuilder != null;

    if (hasEvent == false || widget.enabled == false) {
      Color disabledColor = widget.button.disabledColor != null
          ? widget.button.disabledColor!
          : widget.colors.disabled;
      Widget icon =
          Icon(widget.button.icon, color: disabledColor, size: widget.iconSize);
      if (widget.button.padding != null) {
        icon = Padding(child: icon, padding: widget.button.padding!);
      }
      return icon;
    }

    Color finalColor = _hover ? hoverColor : color;
    Widget icon =
        Icon(widget.button.icon, color: finalColor, size: widget.iconSize);
    if (widget.button.padding != null) {
      icon = Padding(child: icon, padding: widget.button.padding!);
    }

    VoidCallback? onPressed = widget.button.onPressed;
    if (widget.button.menuBuilder != null) {
      onPressed = () {
        if (widget.data.menuItems.isEmpty) {
          List<TabbedViewMenuItem> menuItems =
              widget.button.menuBuilder!(context);
          if (menuItems.isNotEmpty) {
            widget.data.menuItemsUpdater(menuItems);
          }
        } else {
          widget.data.menuItemsUpdater([]);
        }
      };
    }

    if (widget.button.toolTip != null) {
      icon = Tooltip(
          message: widget.button.toolTip!,
          child: icon,
          waitDuration: Duration(milliseconds: 500));
    }

    return MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: _onEnter,
        onExit: _onExit,
        child: GestureDetector(child: icon, onTap: onPressed));
  }

  void _onEnter(PointerEnterEvent event) {
    setState(() {
      _hover = true;
    });
  }

  void _onExit(PointerExitEvent event) {
    setState(() {
      _hover = false;
    });
  }
}
