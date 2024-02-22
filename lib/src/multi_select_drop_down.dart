import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paginated_search_drop_down/src/properties/clear_button_props.dart';
import 'package:paginated_search_drop_down/src/properties/dropdown_button_props.dart';
import 'package:paginated_search_drop_down/src/properties/dropdown_decorator_props.dart';
import 'package:paginated_search_drop_down/src/properties/popup_props.dart';
import 'package:paginated_search_drop_down/src/utils/typedefs.dart';
import 'package:paginated_search_drop_down/src/widgets/popup_menu.dart';
import 'package:paginated_search_drop_down/src/widgets/selection_widget.dart';

class MultiSelectDropDown<T> extends StatefulWidget {
  final List<T> items;

  final T? selectedItem;

  final List<T> selectedItems;

  final MultiSelectDropDownOnFind<T>? asyncItems;

  final ValueChanged<T?>? onChanged;

  final ValueChanged<List<T>>? onChangedMultiSelection;

  final MultiSelectDropDownBuilder<T>? dropdownBuilder;

  final MultiSelectDropDownBuilderMultiSelection<T>? dropdownBuilderMultiSelection;

  final MultiSelectDropDownItemAsString<T>? itemAsString;

  final MultiSelectDropDownFilterFn<T>? filterFn;

  final bool enabled;
  final String? confirmText;
  final ButtonStyle? confirmButtonStyle;
  final TextStyle? confirmTextTextStyle;

  final MultiSelectDropDownCompareFn<T>? compareFn;

  final AutovalidateMode? autoValidateMode;

  final FormFieldSetter<T>? onSaved;

  final FormFieldSetter<List<T>>? onSavedMultiSelection;

  final FormFieldValidator<T>? validator;

  final FormFieldValidator<List<T>>? validatorMultiSelection;

  final BeforeChange<T>? onBeforeChange;

  final BeforeChangeMultiSelection<T>? onBeforeChangeMultiSelection;

  final bool isMultiSelectionMode;

  final ClearButtonProps clearButtonProps;

  final DropdownButtonProps dropdownButtonProps;

  final PopupPropsMultiSelection<T> popupProps;
  final Function(String)? textFieldOnChanged;

  final DropDownDecoratorProps dropdownDecoratorProps;

  final BeforePopupOpening<T>? onBeforePopupOpening;

  final BeforePopupOpeningMultiSelection<T>? onBeforePopupOpeningMultiSelection;

  MultiSelectDropDown({
    Key? key,
    this.onSaved,
    this.validator,
    this.textFieldOnChanged,
    this.confirmButtonStyle,
    this.confirmTextTextStyle,
    this.confirmText,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.onChanged,
    this.items = const [],
    this.selectedItem,
    this.asyncItems,
    this.dropdownBuilder,
    this.dropdownDecoratorProps = const DropDownDecoratorProps(),
    this.clearButtonProps = const ClearButtonProps(),
    this.dropdownButtonProps = const DropdownButtonProps(),
    this.enabled = true,
    this.filterFn,
    this.itemAsString,
    this.compareFn,
    this.onBeforeChange,
    this.onBeforePopupOpening,
    PopupProps<T> popupProps = const PopupProps.menu(),
  })  : assert(
          !popupProps.showSelectedItems || T == String || compareFn != null,
        ),
        popupProps = PopupPropsMultiSelection.from(popupProps),
        isMultiSelectionMode = false,
        dropdownBuilderMultiSelection = null,
        validatorMultiSelection = null,
        onBeforeChangeMultiSelection = null,
        selectedItems = const [],
        onSavedMultiSelection = null,
        onChangedMultiSelection = null,
        onBeforePopupOpeningMultiSelection = null,
        super(key: key);

  MultiSelectDropDown.multiSelection({
    Key? key,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.items = const [],
    this.asyncItems,
    this.textFieldOnChanged,
    this.confirmText,
    this.confirmButtonStyle,
    this.confirmTextTextStyle,
    this.dropdownDecoratorProps = const DropDownDecoratorProps(),
    this.clearButtonProps = const ClearButtonProps(),
    this.dropdownButtonProps = const DropdownButtonProps(),
    this.enabled = true,
    this.filterFn,
    this.itemAsString,
    this.compareFn,
    this.selectedItems = const [],
    this.popupProps = const PopupPropsMultiSelection.menu(),
    FormFieldSetter<List<T>>? onSaved,
    ValueChanged<List<T>>? onChanged,
    BeforeChangeMultiSelection<T>? onBeforeChange,
    BeforePopupOpeningMultiSelection<T>? onBeforePopupOpening,
    FormFieldValidator<List<T>>? validator,
    MultiSelectDropDownBuilderMultiSelection<T>? dropdownBuilder,
  })  : assert(
          !popupProps.showSelectedItems || T == String || compareFn != null,
        ),
        onChangedMultiSelection = onChanged,
        onBeforePopupOpeningMultiSelection = onBeforePopupOpening,
        onSavedMultiSelection = onSaved,
        onBeforeChangeMultiSelection = onBeforeChange,
        validatorMultiSelection = validator,
        dropdownBuilderMultiSelection = dropdownBuilder,
        isMultiSelectionMode = true,
        dropdownBuilder = null,
        validator = null,
        onBeforeChange = null,
        selectedItem = null,
        onSaved = null,
        onChanged = null,
        onBeforePopupOpening = null,
        super(key: key);

  @override
  MultiSelectDropDownState<T> createState() => MultiSelectDropDownState<T>();
}

class MultiSelectDropDownState<T> extends State<MultiSelectDropDown<T>> {
  final ValueNotifier<List<T>> _selectedItemsNotifier = ValueNotifier([]);
  final ValueNotifier<bool> _isFocused = ValueNotifier(false);
  final _popupStateKey = GlobalKey<SelectionWidgetState<T>>();

  @override
  void initState() {
    super.initState();
    _selectedItemsNotifier.value = isMultiSelectionMode
        ? List.from(widget.selectedItems)
        : _itemToList(widget.selectedItem);
  }

  @override
  void didUpdateWidget(MultiSelectDropDown<T> oldWidget) {
    List<T> oldSelectedItems = isMultiSelectionMode
        ? oldWidget.selectedItems
        : _itemToList(oldWidget.selectedItem);

    List<T> newSelectedItems = isMultiSelectionMode
        ? widget.selectedItems
        : _itemToList(widget.selectedItem);

    if (!listEquals(oldSelectedItems, newSelectedItems)) {
      _selectedItemsNotifier.value = List.from(newSelectedItems);
    }

    if (widget.popupProps.containerBuilder !=
        oldWidget.popupProps.containerBuilder) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _popupStateKey.currentState?.setState(() {});
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<T?>>(
      valueListenable: _selectedItemsNotifier,
      builder: (context, data, wt) {
        return IgnorePointer(
          ignoring: !widget.enabled,
          child: InkWell(
            onTap: () => _selectSearchMode(),
            child: _formField(),
          ),
        );
      },
    );
  }

  List<T> _itemToList(T? item) {
    List<T?> nullableList = List.filled(1, item);
    return nullableList.whereType<T>().toList();
  }

  Widget _defaultSelectedItemWidget() {
    Widget defaultItemMultiSelectionMode(T item) {
      return Container(
        height: 32,
        padding: EdgeInsets.only(left: 8, right: 1),
        margin: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColorLight,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                _selectedItemAsString(item),
                style: Theme.of(context).textTheme.titleSmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            MaterialButton(
              height: 20,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(0),
              minWidth: 20,
              onPressed: () {
                removeItem(item);
              },
              child: Icon(
                Icons.close_outlined,
                size: 20,
              ),
            )
          ],
        ),
      );
    }

    Widget selectedItemWidget() {
      if (widget.dropdownBuilder != null) {
        return widget.dropdownBuilder!(
          context,
          getSelectedItem,
        );
      } else if (widget.dropdownBuilderMultiSelection != null) {
        return widget.dropdownBuilderMultiSelection!(
          context,
          getSelectedItems,
        );
      } else if (isMultiSelectionMode) {
        return Wrap(
          children: getSelectedItems
              .map((e) => defaultItemMultiSelectionMode(e))
              .toList(),
        );
      }
      return Text(
        _selectedItemAsString(getSelectedItem),
        style: widget.dropdownDecoratorProps.baseStyle,
        textAlign: widget.dropdownDecoratorProps.textAlign,
      );
    }

    return selectedItemWidget();
  }

  Widget _formField() {
    return isMultiSelectionMode
        ? _formFieldMultiSelection()
        : _formFieldSingleSelection();
  }

  Widget _formFieldSingleSelection() {
    return FormField<T>(
      enabled: widget.enabled,
      onSaved: widget.onSaved,
      validator: widget.validator,
      autovalidateMode: widget.autoValidateMode,
      initialValue: widget.selectedItem,
      builder: (FormFieldState<T> state) {
        if (state.value != getSelectedItem) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              state.didChange(getSelectedItem);
            }
          });
        }
        return ValueListenableBuilder<bool>(
            valueListenable: _isFocused,
            builder: (context, isFocused, w) {
              return InputDecorator(
                baseStyle: widget.dropdownDecoratorProps.baseStyle,
                textAlign: widget.dropdownDecoratorProps.textAlign,
                textAlignVertical:
                    widget.dropdownDecoratorProps.textAlignVertical,
                isEmpty:
                    getSelectedItem == null && widget.dropdownBuilder == null,
                isFocused: isFocused,
                decoration: _manageDropdownDecoration(state),
                child: _defaultSelectedItemWidget(),
              );
            });
      },
    );
  }

  Widget _formFieldMultiSelection() {
    return FormField<List<T>>(
      enabled: widget.enabled,
      onSaved: widget.onSavedMultiSelection,
      validator: widget.validatorMultiSelection,
      autovalidateMode: widget.autoValidateMode,
      initialValue: widget.selectedItems,
      builder: (FormFieldState<List<T>> state) {
        if (state.value != getSelectedItems) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              state.didChange(getSelectedItems);
            }
          });
        }
        return ValueListenableBuilder<bool>(
            valueListenable: _isFocused,
            builder: (context, isFocused, w) {
              return InputDecorator(
                baseStyle: widget.dropdownDecoratorProps.baseStyle,
                textAlign: widget.dropdownDecoratorProps.textAlign,
                textAlignVertical:
                    widget.dropdownDecoratorProps.textAlignVertical,
                isEmpty: getSelectedItems.isEmpty &&
                    widget.dropdownBuilderMultiSelection == null,
                isFocused: isFocused,
                decoration: _manageDropdownDecoration(state),
                child: _defaultSelectedItemWidget(),
              );
            });
      },
    );
  }

  InputDecoration _manageDropdownDecoration(FormFieldState state) {
    return (widget.dropdownDecoratorProps.multiSelectDropDownDecoration ??
            const InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
              border: OutlineInputBorder(),
            ))
        .applyDefaults(Theme.of(state.context).inputDecorationTheme)
        .copyWith(
          enabled: widget.enabled,
          suffixIcon: _manageSuffixIcons(),
          errorText: state.errorText,
        );
  }

  String _selectedItemAsString(T? data) {
    if (data == null) {
      return "";
    } else if (widget.itemAsString != null) {
      return widget.itemAsString!(data);
    } else {
      return data.toString();
    }
  }

  Widget _manageSuffixIcons() {
    clearButtonPressed() => clear();
    dropdownButtonPressed() => _selectSearchMode();

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        if (widget.clearButtonProps.isVisible && getSelectedItems.isNotEmpty)
          IconButton(
            style: widget.clearButtonProps.style,
            isSelected: widget.clearButtonProps.isSelected,
            selectedIcon: widget.clearButtonProps.selectedIcon,
            onPressed: widget.clearButtonProps.onPressed ?? clearButtonPressed,
            icon: widget.clearButtonProps.icon,
            constraints: widget.clearButtonProps.constraints,
            hoverColor: widget.clearButtonProps.hoverColor,
            highlightColor: widget.clearButtonProps.highlightColor,
            splashColor: widget.clearButtonProps.splashColor,
            color: widget.clearButtonProps.color,
            focusColor: widget.clearButtonProps.focusColor,
            iconSize: widget.clearButtonProps.iconSize,
            padding: widget.clearButtonProps.padding,
            splashRadius: widget.clearButtonProps.splashRadius,
            alignment: widget.clearButtonProps.alignment,
            autofocus: widget.clearButtonProps.autofocus,
            disabledColor: widget.clearButtonProps.disabledColor,
            enableFeedback: widget.clearButtonProps.enableFeedback,
            focusNode: widget.clearButtonProps.focusNode,
            mouseCursor: widget.clearButtonProps.mouseCursor,
            tooltip: widget.clearButtonProps.tooltip,
            visualDensity: widget.clearButtonProps.visualDensity,
          ),
        if (widget.dropdownButtonProps.isVisible)
          IconButton(
            style: widget.dropdownButtonProps.style,
            isSelected: widget.dropdownButtonProps.isSelected,
            selectedIcon: widget.dropdownButtonProps.selectedIcon,
            onPressed:
                widget.dropdownButtonProps.onPressed ?? dropdownButtonPressed,
            icon: widget.dropdownButtonProps.icon,
            constraints: widget.dropdownButtonProps.constraints,
            hoverColor: widget.dropdownButtonProps.hoverColor,
            highlightColor: widget.dropdownButtonProps.highlightColor,
            splashColor: widget.dropdownButtonProps.splashColor,
            color: widget.dropdownButtonProps.color,
            focusColor: widget.dropdownButtonProps.focusColor,
            iconSize: widget.dropdownButtonProps.iconSize,
            padding: widget.dropdownButtonProps.padding,
            splashRadius: widget.dropdownButtonProps.splashRadius,
            alignment: widget.dropdownButtonProps.alignment,
            autofocus: widget.dropdownButtonProps.autofocus,
            disabledColor: widget.dropdownButtonProps.disabledColor,
            enableFeedback: widget.dropdownButtonProps.enableFeedback,
            focusNode: widget.dropdownButtonProps.focusNode,
            mouseCursor: widget.dropdownButtonProps.mouseCursor,
            tooltip: widget.dropdownButtonProps.tooltip,
            visualDensity: widget.dropdownButtonProps.visualDensity,
          ),
      ],
    );
  }

  RelativeRect _position(RenderBox popupButtonObject, RenderBox overlay) {
    return RelativeRect.fromSize(
      Rect.fromPoints(
        popupButtonObject.localToGlobal(
            popupButtonObject.size.bottomLeft(Offset.zero),
            ancestor: overlay),
        popupButtonObject.localToGlobal(
            popupButtonObject.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Size(overlay.size.width, overlay.size.height),
    );
  }

  Future _openSelectDialog() {
    return showGeneralDialog(
      context: context,
      barrierDismissible: widget.popupProps.dialogProps.barrierDismissible,
      barrierLabel: widget.popupProps.dialogProps.barrierLabel,
      transitionDuration: widget.popupProps.dialogProps.transitionDuration,
      barrierColor:
          widget.popupProps.dialogProps.barrierColor ?? Colors.black54,
      useRootNavigator: widget.popupProps.dialogProps.useRootNavigator,
      anchorPoint: widget.popupProps.dialogProps.anchorPoint,
      transitionBuilder: widget.popupProps.dialogProps.transitionBuilder,
      pageBuilder: (context, animation, secondaryAnimation) {
        return AlertDialog(
          buttonPadding: widget.popupProps.dialogProps.buttonPadding,
          actionsOverflowButtonSpacing:
              widget.popupProps.dialogProps.actionsOverflowButtonSpacing,
          insetPadding: widget.popupProps.dialogProps.insetPadding,
          actionsPadding: widget.popupProps.dialogProps.actionsPadding,
          actionsOverflowDirection:
              widget.popupProps.dialogProps.actionsOverflowDirection,
          actionsOverflowAlignment:
              widget.popupProps.dialogProps.actionsOverflowAlignment,
          actionsAlignment: widget.popupProps.dialogProps.actionsAlignment,
          actions: widget.popupProps.dialogProps.actions,
          alignment: widget.popupProps.dialogProps.alignment,
          clipBehavior: widget.popupProps.dialogProps.clipBehavior,
          elevation: widget.popupProps.dialogProps.elevation,
          contentPadding: widget.popupProps.dialogProps.contentPadding,
          shape: widget.popupProps.dialogProps.shape,
          backgroundColor: widget.popupProps.dialogProps.backgroundColor,
          semanticLabel: widget.popupProps.dialogProps.semanticLabel,
          content: _popupWidgetInstance(),
        );
      },
    );
  }

  Future _openModalBottomSheet() {
    final sheetTheme = Theme.of(context).bottomSheetTheme;
    return showModalBottomSheet<T>(
      context: context,
      useSafeArea: widget.popupProps.modalBottomSheetProps.useSafeArea,
      barrierColor: widget.popupProps.modalBottomSheetProps.barrierColor,
      backgroundColor:
          widget.popupProps.modalBottomSheetProps.backgroundColor ??
              sheetTheme.modalBackgroundColor ??
              sheetTheme.backgroundColor ??
              Colors.white,
      isDismissible: widget.popupProps.modalBottomSheetProps.barrierDismissible,
      isScrollControlled:
          widget.popupProps.modalBottomSheetProps.isScrollControlled,
      enableDrag: widget.popupProps.modalBottomSheetProps.enableDrag,
      clipBehavior: widget.popupProps.modalBottomSheetProps.clipBehavior,
      elevation: widget.popupProps.modalBottomSheetProps.elevation,
      shape: widget.popupProps.modalBottomSheetProps.shape,
      anchorPoint: widget.popupProps.modalBottomSheetProps.anchorPoint,
      useRootNavigator:
          widget.popupProps.modalBottomSheetProps.useRootNavigator,
      transitionAnimationController:
          widget.popupProps.modalBottomSheetProps.animation,
      constraints: widget.popupProps.modalBottomSheetProps.constraints,
      builder: (ctx) => _popupWidgetInstance(),
    );
  }

  Future _openMenu() {
    // Here we get the render object of our physical button, later to get its size & position
    final popupButtonObject = context.findRenderObject() as RenderBox;
    // Get the render object of the overlay used in `Navigator` / `MaterialApp`, i.e. screen size reference
    var overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    return showCustomMenu<T>(
      menuModeProps: widget.popupProps.menuProps,
      context: context,
      position: (widget.popupProps.menuProps.positionCallback ?? _position)(
        popupButtonObject,
        overlay,
      ),
      child: _popupWidgetInstance(),
    );
  }

  Widget _popupWidgetInstance() {
    return SelectionWidget<T>(
      key: _popupStateKey,
      textFieldOnChanged: widget.textFieldOnChanged,
      popupProps: widget.popupProps,
      itemAsString: widget.itemAsString,
      filterFn: widget.filterFn,
      confirmText: widget.confirmText,
      items: widget.items,
      confirmButtonStyle: widget.confirmButtonStyle,
      confirmTextTextStyle: widget.confirmTextTextStyle,
      asyncItems: widget.asyncItems,
      onChanged: _handleOnChangeSelectedItems,
      compareFn: widget.compareFn,
      isMultiSelectionMode: isMultiSelectionMode,
      defaultSelectedItems: List.from(getSelectedItems),
    );
  }

  void _handleFocus(bool isFocused) {
    if (isFocused && !_isFocused.value) {
      FocusScope.of(context).unfocus();
      _isFocused.value = true;
    } else if (!isFocused && _isFocused.value) {
      _isFocused.value = false;
    }
  }

  void _handleOnChangeSelectedItems(List<T> selectedItems) {
    changeItem() {
      _selectedItemsNotifier.value = List.from(selectedItems);
      if (widget.onChanged != null) {
        widget.onChanged!(getSelectedItem);
      } else if (widget.onChangedMultiSelection != null) {
        widget.onChangedMultiSelection!(selectedItems);
      }
    }

    if (widget.onBeforeChange != null) {
      widget.onBeforeChange!(getSelectedItem,
              selectedItems.isEmpty ? null : selectedItems.first)
          .then((value) {
        if (value == true) {
          changeItem();
        }
      });
    } else if (widget.onBeforeChangeMultiSelection != null) {
      widget.onBeforeChangeMultiSelection!(getSelectedItems, selectedItems)
          .then((value) {
        if (value == true) {
          changeItem();
        }
      });
    } else {
      changeItem();
    }

    _handleFocus(false);
  }

  bool _isEqual(T i1, T i2) {
    if (widget.compareFn != null) {
      return widget.compareFn!(i1, i2);
    } else {
      return i1 == i2;
    }
  }

  Future<void> _selectSearchMode() async {
    if (widget.onBeforePopupOpening != null) {
      if (await widget.onBeforePopupOpening!(getSelectedItem) == false) return;
    } else if (widget.onBeforePopupOpeningMultiSelection != null) {
      if (await widget.onBeforePopupOpeningMultiSelection!(getSelectedItems) ==
          false) return;
    }

    _handleFocus(true);
    if (widget.popupProps.mode == Mode.menu) {
      await _openMenu();
    } else if (widget.popupProps.mode == Mode.modelBottomSheet) {
      await _openModalBottomSheet();
    } else {
      await _openSelectDialog();
    }
    widget.popupProps.onDismissed?.call();
    _handleFocus(false);
  }

  void changeSelectedItem(T? selectedItem) =>
      _handleOnChangeSelectedItems(_itemToList(selectedItem));

  void changeSelectedItems(List<T> selectedItems) =>
      _handleOnChangeSelectedItems(selectedItems);

  void removeItem(T itemToRemove) => _handleOnChangeSelectedItems(
      getSelectedItems..removeWhere((i) => _isEqual(itemToRemove, i)));

  void clear() => _handleOnChangeSelectedItems([]);

  T? get getSelectedItem =>
      getSelectedItems.isEmpty ? null : getSelectedItems.first;

  List<T> get getSelectedItems => _selectedItemsNotifier.value;

  bool get isFocused => _isFocused.value;

  bool get isMultiSelectionMode => widget.isMultiSelectionMode;

  void popupDeselectItems(List<T> itemsToDeselect) {
    _popupStateKey.currentState?.deselectItems(itemsToDeselect);
  }

  void popupDeselectAllItems() {
    _popupStateKey.currentState?.deselectAllItems();
  }

  void popupSelectAllItems() {
    _popupStateKey.currentState?.selectAllItems();
  }

  void popupSelectItems(List<T> itemsToSelect) {
    _popupStateKey.currentState?.selectItems(itemsToSelect);
  }

  void popupOnValidate() {
    _popupStateKey.currentState?.onValidate();
  }

  void popupValidate(List<T> itemsToValidate) {
    closeMultiSelectDropDown();
    changeSelectedItems(itemsToValidate);
  }

  void openMultiSelectDropDown() => _selectSearchMode();

  SelectionWidgetState<T>? get getPopupState => _popupStateKey.currentState;

  void closeMultiSelectDropDown() => _popupStateKey.currentState?.closePopup();

  bool get popupIsAllItemSelected =>
      _popupStateKey.currentState?.isAllItemSelected ?? false;

  List<T> get popupGetSelectedItems =>
      _popupStateKey.currentState?.getSelectedItem ?? [];

  void updatePopupState() => _popupStateKey.currentState?.setState(() {});
}

