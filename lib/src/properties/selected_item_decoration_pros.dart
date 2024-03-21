import 'package:flutter/material.dart';

class SelectedItemDecorationPros {
  final EdgeInsetsGeometry? selectedItemBoxMargin;
  final EdgeInsetsGeometry? selectedItemBoxPadding;
  final Decoration? selectedItemBoxDecoration;
  final EdgeInsetsGeometry? selectedItemTextPadding;
  final EdgeInsetsGeometry? removeItemWidgetPadding;
  final Widget? removeItemWidget;
  final TextStyle? selectedItemTextStyle;

  const SelectedItemDecorationPros({
    this.selectedItemBoxMargin =
        const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
    this.selectedItemBoxPadding = const EdgeInsets.only(left: 8, right: 1),
    this.selectedItemBoxDecoration,
    this.selectedItemTextPadding,
    this.removeItemWidgetPadding,
    this.removeItemWidget = const Icon(
      Icons.close,
      color: Colors.red,
    ),
    this.selectedItemTextStyle,
  });
}
