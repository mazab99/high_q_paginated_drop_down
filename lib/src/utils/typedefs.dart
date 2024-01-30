import 'package:flutter/material.dart';

typedef MultiSelectDropDownOnFind<T> = Future<List<T>> Function(String text);
typedef MultiSelectDropDownItemAsString<T> = String Function(T item);
typedef MultiSelectDropDownFilterFn<T> = bool Function(T item, String filter);
typedef MultiSelectDropDownCompareFn<T> = bool Function(T item1, T item2);
typedef MultiSelectDropDownBuilder<T> = Widget Function(
    BuildContext context, T? selectedItem);
typedef MultiSelectDropDownBuilderMultiSelection<T> = Widget Function(
  BuildContext context,
  List<T> selectedItems,
);
typedef MultiSelectDropDownPopupItemBuilder<T> = Widget Function(
  BuildContext context,
  T item,
  bool isSelected,
);
typedef MultiSelectDropDownPopupItemEnabled<T> = bool Function(T item);
typedef ErrorBuilder<T> = Widget Function(
  BuildContext context,
  String searchEntry,
  dynamic exception,
);
typedef EmptyBuilder<T> = Widget Function(
    BuildContext context, String searchEntry);
typedef LoadingBuilder<T> = Widget Function(
    BuildContext context, String searchEntry);
typedef BeforeChange<T> = Future<bool?> Function(T? prevItem, T? nextItem);
typedef BeforePopupOpening<T> = Future<bool?> Function(T? selectedItem);
typedef BeforePopupOpeningMultiSelection<T> = Future<bool?> Function(
    List<T> selItems);
typedef BeforeChangeMultiSelection<T> = Future<bool?> Function(
  List<T> prevItems,
  List<T> nextItems,
);
typedef FavoriteItemsBuilder<T> = Widget Function(
  BuildContext context,
  T item,
  bool isSelected,
);
typedef ValidationMultiSelectionBuilder<T> = Widget Function(
  BuildContext context,
  List<T> item,
);

typedef PositionCallback = RelativeRect Function(
  RenderBox popupButtonObject,
  RenderBox overlay,
);

typedef OnItemAdded<T> = void Function(List<T> selectedItems, T addedItem);
typedef OnItemRemoved<T> = void Function(List<T> selectedItems, T removedItem);
typedef PopupBuilder = Widget Function(
    BuildContext context, Widget popupWidget);

typedef FavoriteItems<T> = List<T> Function(List<T> items);

enum Mode {
  dialog,
  modelBottomSheet,
  menu,
}
