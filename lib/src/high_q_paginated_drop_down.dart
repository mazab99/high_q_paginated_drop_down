import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:high_q_paginated_drop_down/src/extensions/context_extension.dart';
import 'package:high_q_paginated_drop_down/src/extensions/global_paint_bounds.dart';
import 'package:high_q_paginated_drop_down/src/utils/package_inkwell_widget.dart';
import 'package:high_q_paginated_drop_down/src/utils/search_bar.dart';
import '../high_q_paginated_drop_down.dart';

class HighQPaginatedDropdown<T> extends StatefulWidget {
  final bool isEnabled;
  final bool showTextField;
  final bool enableValidation;
  final String? Function(T?)? validate;
  final GlobalKey<FormFieldState<T>> formKey;
  final bool isDialogExpanded;

  final bool hasTrailingClearIcon;

  final double? dropDownMaxHeight;
  final double? paddingValueWhileIsDialogExpanded;

  final double? width;

  final double? spaceBetweenDropDownAndItemsDialog;
  final InputDecoration? textFieldDecoration;

  final Duration? searchDelayDuration;

  final EdgeInsetsGeometry? padding;

  final Future<List<MenuItemModel<T>>?> Function(
    int page,
    String? searchText,
  )? paginatedRequest;

  final int? requestItemCount;

  final List<MenuItemModel<T>>? items;

  final PaginatedSearchDropdownController<T>? controller;

  final MenuItemModel<T>? initialFutureValue;

  final String? searchHintText;

  final T? initialValue;

  final VoidCallback? onTapWhileDisableDropDown;

  final void Function(T? value)? onChanged;

  final Widget? hintText;
  final Widget? loadingWidget;

  final Widget? noRecordText;

  final Widget? trailingIcon;

  final Widget? trailingClearIcon;

  final Widget? leadingIcon;

  final Widget Function(Widget child)? backgroundDecoration;

  const HighQPaginatedDropdown({
    Key? key,
    required GlobalKey<FormFieldState<T>> formKey,
    PaginatedSearchDropdownController<T>? controller,
    Widget? hintText,
    Widget? loadingWidget,
    Widget Function(Widget)? backgroundDecoration,
    InputDecoration? textFieldDecoration,
    String? searchHintText,
    Widget? noRecordText,
    double? dropDownMaxHeight,
    EdgeInsetsGeometry? padding,
    Widget? trailingIcon,
    Widget? trailingClearIcon,
    Widget? leadingIcon,
    bool enableValidation = false,
    String? Function(T?)? validate,
    void Function(T?)? onChanged,
    List<MenuItemModel<T>>? items,
    T? value,
    bool isEnabled = true,
    VoidCallback? onTapWhileDisableDropDown,
    double? width,
    bool isDialogExpanded = true,
    bool hasTrailingClearIcon = true,
    bool showTextField = true,
    double? spaceBetweenDropDownAndItemsDialog,
    Duration? searchDelayDuration,
    double? paddingValueWhileIsDialogExpanded,
    MenuItemModel<T>? initialValue,
  }) : this._(
          key: key,
          hintText: hintText,
          formKey: formKey,
          loadingWidget: loadingWidget ?? const CircularProgressIndicator.adaptive(),
          controller: controller,
          backgroundDecoration: backgroundDecoration,
          searchHintText: searchHintText,
          noRecordText: noRecordText,
          dropDownMaxHeight: dropDownMaxHeight,
          padding: padding,
          trailingIcon: trailingIcon,
          trailingClearIcon: trailingClearIcon,
          leadingIcon: leadingIcon,
          onChanged: onChanged,
          items: items,
          initialValue: value,
          isEnabled: isEnabled,
          onTapWhileDisableDropDown: onTapWhileDisableDropDown,
          width: width,
          showTextField: showTextField,
          textFieldDecoration: textFieldDecoration,
          isDialogExpanded: isDialogExpanded,
          hasTrailingClearIcon: hasTrailingClearIcon,
          spaceBetweenDropDownAndItemsDialog:
              spaceBetweenDropDownAndItemsDialog,
          paddingValueWhileIsDialogExpanded: paddingValueWhileIsDialogExpanded,
          searchDelayDuration: searchDelayDuration,
          initialFutureValue: initialValue,
          enableValidation: enableValidation,
          validate: validate,
        );

  const HighQPaginatedDropdown.paginated({
    required Future<List<MenuItemModel<T>>?> Function(
      int,
      String?,
    )? paginatedRequest,
    int? requestItemCount,
    Key? key,
    required GlobalKey<FormFieldState<T>> formKey,
    InputDecoration? textFieldDecoration,
    PaginatedSearchDropdownController<T>? controller,
    Widget? loadingWidget,
    Widget? hintText,
    Widget Function(Widget)? backgroundDecoration,
    String? searchHintText,
    Widget? noRecordText,
    double? dropDownMaxHeight,
    EdgeInsetsGeometry? padding,
    Widget? trailingIcon,
    Widget? trailingClearIcon,
    Widget? leadingIcon,
    void Function(T?)? onChanged,
    bool isEnabled = true,
    bool showTextField = true,
    VoidCallback? onTapWhileDisableDropDown,
    Duration? searchDelayDuration,
    double? width,
    double? paddingValueWhileIsDialogExpanded,
    bool isDialogExpanded = true,
    bool hasTrailingClearIcon = true,
    MenuItemModel<T>? initialValue,
    double? spaceBetweenDropDownAndItemsDialog,
    bool enableValidation = false,
    String? Function(T?)? validate,
  }) : this._(
          key: key,
          formKey: formKey,
          controller: controller,
          textFieldDecoration: textFieldDecoration,
          paddingValueWhileIsDialogExpanded: paddingValueWhileIsDialogExpanded,
          loadingWidget:
              loadingWidget ?? const CircularProgressIndicator.adaptive(),
          enableValidation: enableValidation,
          validate: validate,
          paginatedRequest: paginatedRequest,
          requestItemCount: requestItemCount,
          hintText: hintText,
          backgroundDecoration: backgroundDecoration,
          searchHintText: searchHintText,
          noRecordText: noRecordText,
          dropDownMaxHeight: dropDownMaxHeight,
          padding: padding,
          trailingIcon: trailingIcon,
          trailingClearIcon: trailingClearIcon,
          leadingIcon: leadingIcon,
          onChanged: onChanged,
          isEnabled: isEnabled,
          showTextField: showTextField,
          onTapWhileDisableDropDown: onTapWhileDisableDropDown,
          searchDelayDuration: searchDelayDuration,
          width: width,
          isDialogExpanded: isDialogExpanded,
          hasTrailingClearIcon: hasTrailingClearIcon,
          initialFutureValue: initialValue,
          spaceBetweenDropDownAndItemsDialog:
              spaceBetweenDropDownAndItemsDialog,
        );

  const HighQPaginatedDropdown._({
    super.key,
    this.controller,
    required this.formKey,
    this.enableValidation = false,
    this.showTextField = true,
    this.loadingWidget,
    this.validate,
    this.hintText,
    this.textFieldDecoration = const InputDecoration(),
    this.paddingValueWhileIsDialogExpanded,
    this.backgroundDecoration,
    this.searchHintText,
    this.noRecordText,
    this.dropDownMaxHeight,
    this.padding,
    this.trailingIcon,
    this.trailingClearIcon,
    this.leadingIcon,
    this.onChanged,
    this.items,
    this.initialValue,
    this.initialFutureValue,
    this.isEnabled = true,
    this.onTapWhileDisableDropDown,
    this.paginatedRequest,
    this.requestItemCount,
    this.searchDelayDuration,
    this.width,
    this.isDialogExpanded = true,
    this.hasTrailingClearIcon = true,
    this.spaceBetweenDropDownAndItemsDialog,
  });

  @override
  State<HighQPaginatedDropdown<T>> createState() =>
      _HighQPaginatedDropdownState<T>();
}

class _HighQPaginatedDropdownState<T> extends State<HighQPaginatedDropdown<T>> {
  late final PaginatedSearchDropdownController<T> dropdownController;

  @override
  void initState() {
    dropdownController =
        widget.controller ?? PaginatedSearchDropdownController<T>();
    dropdownController
      ..paginatedRequest = widget.paginatedRequest
      ..requestItemCount = widget.requestItemCount ?? 0
      ..items = widget.items
      ..searchedItems.value = widget.items;
    if (widget.initialFutureValue != null) {
      dropdownController.selectedItem.value = widget.initialFutureValue;
    }
    for (final element in widget.items ?? <MenuItemModel<T>>[]) {
      if (element.value == widget.initialValue) {
        dropdownController.selectedItem.value = element;
        return;
      }
    }

    if (dropdownController.paginatedRequest == null) return;
    super.initState();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      dropdownController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dropdownWidget = _DropDown(
      loadingWidget: widget.loadingWidget!,
      enableValidation: widget.enableValidation,
      validate: widget.validate,
      controller: dropdownController,
      showTextField: widget.showTextField,
      isEnabled: widget.isEnabled,
      paddingValueWhileIsDialogExpanded:
          widget.paddingValueWhileIsDialogExpanded,
      onTapWhileDisableDropDown: widget.onTapWhileDisableDropDown,
      dropDownMaxHeight: widget.dropDownMaxHeight,
      hintText: widget.hintText,
      leadingIcon: widget.leadingIcon,
      padding: widget.padding,
      noRecordText: widget.noRecordText,
      onChanged: widget.onChanged,
      paginatedRequest: widget.paginatedRequest,
      searchHintText: widget.searchHintText,
      trailingIcon: widget.trailingIcon,
      trailingClearIcon: widget.trailingClearIcon,
      searchDelayDuration: widget.searchDelayDuration,
      isDialogExpanded: widget.isDialogExpanded,
      hasTrailingClearIcon: widget.hasTrailingClearIcon,
      spaceBetweenDropDownAndItemsDialog:
          widget.spaceBetweenDropDownAndItemsDialog,
      textFieldDecoration: widget.textFieldDecoration,
    );

    return SizedBox(
      key: dropdownController.key,
      width: widget.width ?? MediaQuery.of(context).size.width,
      child:
          widget.backgroundDecoration?.call(dropdownWidget) ?? dropdownWidget,
    );
  }
}

class _DropDown<T> extends StatelessWidget {
  final bool isEnabled;
  final bool showTextField;
  final bool enableValidation;
  final Widget loadingWidget;
  final String? Function(T?)? validate;
  final bool isDialogExpanded;
  final InputDecoration? textFieldDecoration;
  final double? paddingValueWhileIsDialogExpanded;
  final bool hasTrailingClearIcon;
  final double? dropDownMaxHeight;
  final double? spaceBetweenDropDownAndItemsDialog;

  //Delay of DropDown's search callback after typing complete.
  final Duration? searchDelayDuration;
  final EdgeInsetsGeometry? padding;
  final Future<List<MenuItemModel<T>>?> Function(
    int page,
    String? searchText,
  )? paginatedRequest;
  final PaginatedSearchDropdownController<T> controller;
  final String? searchHintText;
  final VoidCallback? onTapWhileDisableDropDown;
  final void Function(T? value)? onChanged;
  final Widget? trailingIcon;
  final Widget? trailingClearIcon;
  final Widget? leadingIcon;
  final Widget? hintText;
  final Widget? noRecordText;

  const _DropDown({
    required this.controller,
    required this.showTextField,
    required this.isEnabled,
    required this.isDialogExpanded,
    this.leadingIcon,
    this.trailingIcon,
    this.paddingValueWhileIsDialogExpanded,
    this.trailingClearIcon,
    this.onTapWhileDisableDropDown,
    this.padding,
    this.loadingWidget = const CircularProgressIndicator.adaptive(),
    this.textFieldDecoration = const InputDecoration(
      isDense: true,
    ),
    this.hintText,
    this.dropDownMaxHeight,
    this.enableValidation = false,
    this.validate,
    this.paginatedRequest,
    this.noRecordText,
    this.onChanged,
    this.searchHintText,
    this.searchDelayDuration,
    this.hasTrailingClearIcon = true,
    this.spaceBetweenDropDownAndItemsDialog,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (isEnabled) {
          showDropdownDialog(
            context,
            controller,
            spaceBetweenDropDownAndItemsDialog:
                spaceBetweenDropDownAndItemsDialog,
          );
        } else {
          if (kDebugMode) {
            PrintManager.printColoredText(
              item: 'You Disabled the DropDown',
              color: ConsoleColor.brightRedBg,
            );
          }
          onTapWhileDisableDropDown?.call();
        }
      },
      child: Padding(
        padding: padding ?? const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  if (leadingIcon != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 3),
                      child: leadingIcon,
                    ),
                  Flexible(
                    child: _DropDownText(
                      controller: controller,
                      hintText: hintText,
                    ),
                  ),
                ],
              ),
            ),
            ValueListenableBuilder(
              valueListenable: controller.selectedItem,
              builder: (context, value, child) {
                if (value == null || !hasTrailingClearIcon) {
                  return trailingIcon ??
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 24,
                      );
                }
                return PackageInkwellWidget(
                  padding: EdgeInsets.zero,
                  onTap: () {
                    controller.selectedItem.value = null;
                    onChanged?.call(null);
                  },
                  child: trailingClearIcon ??
                      const Icon(
                        Icons.clear,
                        color: Colors.red,
                        size: 24,
                      ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void showDropdownDialog(
    BuildContext context,
    PaginatedSearchDropdownController<T> controller, {
    double? spaceBetweenDropDownAndItemsDialog,
  }) {
    final spaceBetweenDropDownAndItemsDialog0 =
        spaceBetweenDropDownAndItemsDialog ?? 35;
    var isReversed = false;
    final deviceHeight = context.deviceHeight;
    final dropdownGlobalPointBounds = controller.key.globalPaintBounds;
    final alertDialogMaxHeight = dropDownMaxHeight ?? deviceHeight * 0.35;

    final dropdownPositionFromBottom = dropdownGlobalPointBounds != null
        ? deviceHeight - dropdownGlobalPointBounds.bottom
        : null;
    var dialogPositionFromBottom = dropdownPositionFromBottom != null
        ? dropdownPositionFromBottom - alertDialogMaxHeight
        : null;
    if (dialogPositionFromBottom != null) {
      //If dialog couldn't fit the screen, reverse it
      if (dialogPositionFromBottom <= 0) {
        isReversed = true;
        final dropdownHeight = dropdownGlobalPointBounds?.height ?? 54;
        dialogPositionFromBottom += alertDialogMaxHeight +
            dropdownHeight -
            spaceBetweenDropDownAndItemsDialog0;
      } else {
        dialogPositionFromBottom -= spaceBetweenDropDownAndItemsDialog0;
      }
    }
    if (controller.items == null) {
      if (paginatedRequest != null) {
        controller.getItemsWithPaginatedRequest(page: 1, isNewSearch: true);
      }
    } else {
      controller.searchedItems.value = controller.items;
    }
    //Show the dialog
    showDialog<void>(
      context: context,
      builder: (context) {
        var reCalculatePosition = dialogPositionFromBottom;
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
        //If keyboard pushes the dialog, recalculate the dialog's position.
        if (reCalculatePosition != null &&
            reCalculatePosition <= keyboardHeight) {
          reCalculatePosition =
              (keyboardHeight - reCalculatePosition) + reCalculatePosition;
        }
        return Padding(
          padding: EdgeInsets.only(
            bottom: reCalculatePosition ?? 0,
            left: isDialogExpanded
                ? paddingValueWhileIsDialogExpanded != null
                    ? paddingValueWhileIsDialogExpanded!
                    : 16
                : dropdownGlobalPointBounds?.left ?? 0,
            right: isDialogExpanded
                ? paddingValueWhileIsDialogExpanded != null
                    ? paddingValueWhileIsDialogExpanded!
                    : 16
                : 0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: isDialogExpanded
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: alertDialogMaxHeight,
                width:
                    isDialogExpanded ? null : dropdownGlobalPointBounds?.width,
                child: _DropDownCard(
                  controller: controller,
                  isReversed: isReversed,
                  showTextField: showTextField,
                  noRecordText: noRecordText,
                  onChanged: onChanged,
                  paginatedRequest: paginatedRequest,
                  searchHintText: searchHintText,
                  searchDelayDuration: searchDelayDuration,
                  textFieldDecoration: textFieldDecoration,
                  validate: validate,
                  enableValidation: enableValidation,
                  loadingWidget: loadingWidget,
                ),
              ),
            ],
          ),
        );
      },
      barrierColor: Colors.transparent,
    );
  }
}

class _DropDownText<T> extends StatelessWidget {
  final PaginatedSearchDropdownController<T> controller;
  final Widget? hintText;

  const _DropDownText({
    required this.controller,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.selectedItem,
      builder: (context, MenuItemModel<T>? selectedItem, child) =>
          selectedItem?.child ??
          (selectedItem?.label != null
              ? Text(
                  selectedItem!.label,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                )
              : hintText) ??
          const SizedBox.shrink(),
    );
  }
}

class _DropDownCard<T> extends StatelessWidget {
  final bool isReversed;
  final bool showTextField;
  final Duration? searchDelayDuration;
  final InputDecoration? textFieldDecoration;
  final Future<List<MenuItemModel<T>>?> Function(
    int page,
    String? searchText,
  )? paginatedRequest;
  final bool enableValidation;
  final String? Function(T?)? validate;
  final PaginatedSearchDropdownController<T> controller;
  final String? searchHintText;
  final void Function(T? value)? onChanged;
  final Widget? loadingWidget;
  final Widget? noRecordText;

  const _DropDownCard({
    required this.controller,
    required this.showTextField,
    required this.isReversed,
    this.searchHintText,
    this.validate,
    this.enableValidation = false,
    this.textFieldDecoration = const InputDecoration(
      isDense: true,
    ),
    this.paginatedRequest,
    this.onChanged,
    this.loadingWidget,
    this.noRecordText,
    this.searchDelayDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
          isReversed ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Card(
            margin: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                verticalDirection:
                    isReversed ? VerticalDirection.up : VerticalDirection.down,
                children: [
                  if (showTextField == true)
                    _MultiSelectDropDownBar(
                      controller: controller,
                      searchHintText: searchHintText,
                      searchDelayDuration: searchDelayDuration,
                      textFieldDecoration: textFieldDecoration,
                    ),
                  Flexible(
                    child: _DropDownListView(
                      dropdownController: controller,
                      paginatedRequest: paginatedRequest,
                      isReversed: isReversed,
                      noRecordText: noRecordText,
                      onChanged: onChanged,
                      loadingWidget: loadingWidget,
                      enableValidation: enableValidation,
                      validate: validate,
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
}

class _MultiSelectDropDownBar<T> extends StatelessWidget {
  final Duration? searchDelayDuration;
  final PaginatedSearchDropdownController<T> controller;
  final String? searchHintText;
  final InputDecoration? textFieldDecoration;

  const _MultiSelectDropDownBar({
    required this.controller,
    this.searchHintText,
    this.searchDelayDuration,
    this.textFieldDecoration = const InputDecoration(
      isDense: true,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: PackageSearchBar(
        searchDelayDuration: searchDelayDuration ??
            const Duration(
              milliseconds: 200,
            ),
        hintText: searchHintText ?? 'Search',
        isOutlined: true,
        leadingIcon: const Icon(Icons.search, size: 24),
        onChangeComplete: (value) {
          controller.searchText = value;
          if (controller.items != null) {
            controller.fillSearchedList(value);
            return;
          }
          controller.getItemsWithPaginatedRequest(
            searchText: value == '' ? null : value,
            page: 1,
            isNewSearch: true,
          );
        },
        textFieldDecoration: textFieldDecoration,
      ),
    );
  }
}

class _DropDownListView<T> extends StatefulWidget {
  final bool isReversed;
  final bool enableValidation;
  final String? Function(T?)? validate;
  final Widget? loadingWidget;

  final Future<List<MenuItemModel<T>>?> Function(
    int page,
    String? searchText,
  )? paginatedRequest;
  final PaginatedSearchDropdownController<T> dropdownController;
  final void Function(T? value)? onChanged;
  final Widget? noRecordText;

  const _DropDownListView({
    required this.dropdownController,
    required this.isReversed,
    this.enableValidation = false,
    this.paginatedRequest,
    this.validate,
    this.noRecordText,
    this.onChanged,
    this.loadingWidget,
  });

  @override
  State<_DropDownListView<T>> createState() => _DropDownListViewState<T>();
}

class _DropDownListViewState<T> extends State<_DropDownListView<T>> {
  ScrollController scrollController = ScrollController();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollControllerListener);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController
      ..removeListener(scrollControllerListener)
      ..dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      validator: widget.enableValidation ? widget.validate : null,
      builder: (field) {
        return ValueListenableBuilder(
          valueListenable: widget.paginatedRequest != null
              ? widget.dropdownController.paginatedItemList
              : widget.dropdownController.searchedItems,
          builder: (
            context,
            List<MenuItemModel<T>>? itemList,
            child,
          ) {
            return itemList == null
                ? widget.loadingWidget != null
                    ? widget.loadingWidget!
                    : const Center(child: CircularProgressIndicator.adaptive())
                : itemList.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(
                          8,
                        ),
                        child: widget.noRecordText ?? const Text('No record'),
                      )
                    : Scrollbar(
                        thumbVisibility: true,
                        controller: scrollController,
                        child: NotificationListener(
                          child: ListView.builder(
                            controller: scrollController,
                            padding: listViewPadding(
                              isReversed: widget.isReversed,
                            ),
                            itemCount: itemList.length + 1,
                            shrinkWrap: true,
                            reverse: widget.isReversed,
                            itemBuilder: (context, index) {
                              if (index < itemList.length) {
                                final item = itemList.elementAt(index);
                                return PackageInkwellWidget(
                                  child: item.child,
                                  onTap: () {
                                    widget.dropdownController.selectedItem
                                        .value = item;
                                    widget.onChanged?.call(item.value);
                                    Navigator.pop(context);
                                    item.onTap?.call();
                                  },
                                );
                              } else {
                                return ValueListenableBuilder(
                                  valueListenable:
                                      widget.dropdownController.status,
                                  builder: (
                                    context,
                                    PaginatedSearchDropdownStatus state,
                                    child,
                                  ) {
                                    if (state ==
                                        PaginatedSearchDropdownStatus.busy) {
                                      return Center(
                                        child: widget.loadingWidget != null
                                            ? widget.loadingWidget!
                                            : const Center(
                                                child: CircularProgressIndicator
                                                    .adaptive(),
                                              ),
                                      );
                                    }
                                    return const SizedBox.shrink();
                                  },
                                );
                              }
                            },
                          ),
                        ),
                      );
          },
        );
      },
    );
  }

  EdgeInsets listViewPadding({required bool isReversed}) {
    final itemHeight = widget.paginatedRequest != null ? 48.0 : 0.0;
    return EdgeInsets.only(
      left: 8,
      right: 8,
      bottom: isReversed ? 0 : itemHeight,
      top: isReversed ? itemHeight : 0,
    );
  }

  void scrollControllerListener({
    double sensitivity = 150.0,
    Duration throttleDuration = const Duration(milliseconds: 400),
  }) {
    if (timer != null) return;

    timer = Timer(throttleDuration, () => timer = null);

    final position = scrollController.position;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = position.pixels;
    final dropdownController = widget.dropdownController;
    final searchText = dropdownController.searchText;
    if (maxScroll - currentScroll <= sensitivity) {
      if (searchText.isNotEmpty) {
        dropdownController.getItemsWithPaginatedRequest(
          page: dropdownController.page,
          searchText: searchText,
        );
      } else {
        dropdownController.getItemsWithPaginatedRequest(
          page: dropdownController.page,
        );
      }
    }
  }
}
