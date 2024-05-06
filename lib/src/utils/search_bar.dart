import 'package:async/async.dart';
import 'package:flutter/material.dart';

import 'package_inkwell_widget.dart';

class PackageSearchBar extends StatelessWidget {
  final bool isOutlined;
  final Duration searchDelayDuration;
  final FocusNode? focusNode;
  final String? hintText;
  final TextEditingController? controller;
  final TextStyle? style;
  final InputDecoration? textFieldDecoration;

  final void Function(String value)? onChangeComplete;
  final Widget? leadingIcon;

  const PackageSearchBar({
    super.key,
    this.onChangeComplete,
    this.searchDelayDuration = const Duration(milliseconds: 800),
    this.hintText,
    this.leadingIcon,
    this.isOutlined = false,
    this.focusNode,
    this.controller,
    this.style,
    this.textFieldDecoration = const InputDecoration( isDense: true,),
  });

  @override
  Widget build(BuildContext context) {
    final FocusNode myFocusNode = focusNode ?? FocusNode();

    return PackageInkwellWidget(
      padding: EdgeInsets.zero,
      disableTabEffect: true,
      onTap: myFocusNode.requestFocus,
      child: isOutlined
          ? DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                border: Border.all(
                  color: (style?.color ?? Colors.black).withOpacity(0.5),
                ),
              ),
              child: SearchTextFormField(
                onChangeComplete: onChangeComplete,
                searchDelayDuration: searchDelayDuration,
                hintText: hintText,
                leadingIcon: leadingIcon,
                focusNode: focusNode,
                controller: controller,
                style: style,
                textFieldDecoration: textFieldDecoration,
              ),
            )
          : Card(
              margin: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: SearchTextFormField(
                onChangeComplete: onChangeComplete,
                searchDelayDuration: searchDelayDuration,
                hintText: hintText,
                leadingIcon: leadingIcon,
                focusNode: focusNode,
                controller: controller,
                style: style,
                textFieldDecoration: textFieldDecoration,
              ),
            ),
    );
  }
}

class SearchTextFormField extends StatelessWidget {
  final Duration searchDelayDuration;
  final FocusNode? focusNode;
  final String? hintText;
  final TextEditingController? controller;
  final TextStyle? style;
  final void Function(String value)? onChangeComplete;
  final Widget? leadingIcon;
  final InputDecoration? textFieldDecoration;

  const SearchTextFormField({
    this.onChangeComplete,
    this.searchDelayDuration = const Duration(milliseconds: 800),
    this.hintText,
    this.leadingIcon,
    this.focusNode,
    this.controller,
    this.style,
    this.textFieldDecoration = const InputDecoration(
      isDense: true,
    ),
  });

  @override
  Widget build(BuildContext context) {
    CancelableOperation<dynamic>? cancelableOperation;

    void startCancelableOperation() {
      cancelableOperation = CancelableOperation.fromFuture(
        Future.delayed(
          searchDelayDuration,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        onChanged: (value) async {
          await cancelableOperation?.cancel();
          startCancelableOperation();
          await cancelableOperation?.value.whenComplete(
            () {
              onChangeComplete?.call(value);
            },
          );
        },
        style: style,
        decoration: textFieldDecoration ??
            InputDecoration(
              contentPadding: EdgeInsets.zero,
              isDense: true,
              border: InputBorder.none,
              hintText: hintText,
              icon: leadingIcon,
            ),
      ),
    );
  }
}
