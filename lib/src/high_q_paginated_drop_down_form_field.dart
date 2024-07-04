import 'package:flutter/material.dart';
import 'package:high_q_paginated_drop_down/src/high_q_paginated_drop_down_controller.dart';
import 'high_q_paginated_drop_down.dart';
import 'model/menu_item_model.dart';

@immutable
class PaginatedSearchDropdownFormField<T> extends FormField<T> {
  final bool isEnabled;

  final bool isDialogExpanded;

  final bool hasTrailingClearIcon;

  final double? spaceBetweenDropDownAndItemsDialog;

  final double? dropDownMaxHeight;

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

  final VoidCallback? onTapWhileDisableDropDown;

  final void Function(T? value)? onChanged;

  final Widget? hintText;

  final Widget? noRecordText;

  final Widget? trailingIcon;

  final Widget? trailingClearIcon;

  final Widget? leadingIcon;

  final Widget Function(String? errorText)? errorWidget;

  final Widget Function(Widget child)? backgroundDecoration;

  PaginatedSearchDropdownFormField({
    required List<MenuItemModel<T>>? items,
    Key? key,
    PaginatedSearchDropdownController<T>? controller,
    void Function(T?)? onSaved,
    String? Function(T?)? validator,
    T? initialValue,
    AutovalidateMode? autoValidateMode,
    Widget? hintText,
    EdgeInsetsGeometry? padding,
    bool isEnabled = true,
    VoidCallback? onTapWhileDisableDropDown,
    Widget Function(String?)? errorWidget,
    Widget Function(Widget)? backgroundDecoration,
    void Function(T?)? onChanged,
    Widget? noRecordTex,
    Widget? trailingIcon,
    Widget? trailingClearIcon,
    Widget? leadingIcon,
    String? searchHintText,
    double? dropDownMaxHeight,
    bool isDialogExpanded = true,
    bool hasTrailingClearIcon = true,
    double? spaceBetweenDropDownAndItemsDialog,
  }) : this._(
          controller: controller,
          items: items,
          key: key,
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidateMode: autoValidateMode,
          hintText: hintText,
          padding: padding,
          isEnabled: isEnabled,
          onTapWhileDisableDropDown: onTapWhileDisableDropDown,
          errorWidget: errorWidget,
          backgroundDecoration: backgroundDecoration,
          onChanged: onChanged,
          noRecordText: noRecordTex,
          trailingIcon: trailingIcon,
          trailingClearIcon: trailingClearIcon,
          leadingIcon: leadingIcon,
          searchHintText: searchHintText,
          dropDownMaxHeight: dropDownMaxHeight,
          isDialogExpanded: isDialogExpanded,
          hasTrailingClearIcon: hasTrailingClearIcon,
          spaceBetweenDropDownAndItemsDialog:
              spaceBetweenDropDownAndItemsDialog,
        );

  PaginatedSearchDropdownFormField.paginated({
    required Future<List<MenuItemModel<T>>?> Function(
      int,
      String?,
    )? paginatedRequest,
    int? requestItemCount,
    Key? key,
    PaginatedSearchDropdownController<T>? controller,
    void Function(T?)? onSaved,
    String? Function(T?)? validator,
    MenuItemModel<T>? initialValue,
    AutovalidateMode? autoValidateMode,
    Widget? hintText,
    EdgeInsetsGeometry? padding,
    bool isEnabled = true,
    VoidCallback? onTapWhileDisableDropDown,
    Widget Function(String?)? errorWidget,
    Widget Function(Widget)? backgroundDecoration,
    void Function(T?)? onChanged,
    Widget? noRecordTex,
    Widget? trailingIcon,
    Widget? trailingClearIcon,
    Widget? leadingIcon,
    String? searchHintText,
    Duration? searchDelayDuration,
    double? dropDownMaxHeight,
    bool isDialogExpanded = true,
    bool hasTrailingClearIcon = true,
    double? spaceBetweenDropDownAndItemsDialog,
  }) : this._(
          controller: controller,
          paginatedRequest: paginatedRequest,
          key: key,
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue?.value,
          initialFutureValue: initialValue,
          autovalidateMode: autoValidateMode,
          hintText: hintText,
          padding: padding,
          isEnabled: isEnabled,
          onTapWhileDisableDropDown: onTapWhileDisableDropDown,
          errorWidget: errorWidget,
          backgroundDecoration: backgroundDecoration,
          onChanged: onChanged,
          noRecordText: noRecordTex,
          trailingIcon: trailingIcon,
          trailingClearIcon: trailingClearIcon,
          leadingIcon: leadingIcon,
          searchHintText: searchHintText,
          dropDownMaxHeight: dropDownMaxHeight,
          requestItemCount: requestItemCount,
          searchDelayDuration: searchDelayDuration,
          isDialogExpanded: isDialogExpanded,
          hasTrailingClearIcon: hasTrailingClearIcon,
          spaceBetweenDropDownAndItemsDialog:
              spaceBetweenDropDownAndItemsDialog,
        );

  PaginatedSearchDropdownFormField._({
    this.controller,
    this.items,
    this.paginatedRequest,
    this.requestItemCount,
    super.key,
    super.onSaved,
    super.validator,
    super.initialValue,
    super.autovalidateMode,
    this.initialFutureValue,
    this.hintText,
    this.padding,
    this.isEnabled = true,
    this.onTapWhileDisableDropDown,
    this.errorWidget,
    this.backgroundDecoration,
    this.onChanged,
    this.noRecordText,
    this.trailingIcon,
    this.trailingClearIcon,
    this.leadingIcon,
    this.searchHintText,
    this.dropDownMaxHeight,
    this.searchDelayDuration,
    this.isDialogExpanded = true,
    this.hasTrailingClearIcon = true,
    this.spaceBetweenDropDownAndItemsDialog,
  })  : assert(
            initialValue == null || controller == null,
            'If you use controller, '
            'don\'t add initialValue inside PaginatedSearchDropdownFormField. '
            'Just add it from the controller final.'
            'PaginatedSearchDropdownController<int> searchableDropdownController = '
            'PaginatedSearchDropdownController<int><int>('
            '  initialItem: const MenuItemModel('
            '    value: 2,'
            '    label: Mahmoud,'
            '    child: Text(Mahmoud),'
            '  ),'
            ')'),
        super(
          builder: (FormFieldState<T> state) {
            return Padding(
              padding: padding ?? const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (items != null)
                    HighQPaginatedDropdown<T>(
                      controller: controller,
                      key: key,
                      backgroundDecoration: backgroundDecoration,
                      hintText: hintText,
                      padding: EdgeInsets.zero,
                      leadingIcon: leadingIcon,
                      trailingIcon: trailingIcon,
                      trailingClearIcon: trailingClearIcon,
                      noRecordText: noRecordText,
                      dropDownMaxHeight: dropDownMaxHeight,
                      searchHintText: searchHintText,
                      isEnabled: isEnabled,
                      onTapWhileDisableDropDown: onTapWhileDisableDropDown,
                      items: items,
                      value: initialValue,
                      onChanged: (value) {
                        state.didChange(value);
                        if (onChanged != null) onChanged(value);
                      },
                      isDialogExpanded: isDialogExpanded,
                      spaceBetweenDropDownAndItemsDialog:
                          spaceBetweenDropDownAndItemsDialog,
                    ),
                  if (paginatedRequest != null)
                    HighQPaginatedDropdown<T>.paginated(
                      controller: controller,
                      paginatedRequest: paginatedRequest,
                      requestItemCount: requestItemCount,
                      key: key,
                      backgroundDecoration: backgroundDecoration,
                      hintText: hintText,
                      padding: EdgeInsets.zero,
                      leadingIcon: leadingIcon,
                      trailingIcon: trailingIcon,
                      trailingClearIcon: trailingClearIcon,
                      noRecordText: noRecordText,
                      dropDownMaxHeight: dropDownMaxHeight,
                      searchHintText: searchHintText,
                      isEnabled: isEnabled,
                      onTapWhileDisableDropDown: onTapWhileDisableDropDown,
                      initialValue: initialFutureValue,
                      onChanged: (value) {
                        state.didChange(value);
                        if (onChanged != null) onChanged(value);
                      },
                      searchDelayDuration: searchDelayDuration,
                      isDialogExpanded: isDialogExpanded,
                      spaceBetweenDropDownAndItemsDialog:
                          spaceBetweenDropDownAndItemsDialog,
                    ),
                  if (state.hasError)
                    errorWidget != null
                        ? errorWidget(state.errorText)
                        : Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              state.errorText ?? '',
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                ],
              ),
            );
          },
        );
}
