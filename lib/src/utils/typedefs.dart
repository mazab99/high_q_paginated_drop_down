import 'package:flutter/material.dart';

typedef DropdownSearchOnFind<T> = Future<List<T>> Function(String text);
typedef DropdownSearchItemAsString<T> = String Function(T item);
typedef DropdownSearchFilterFn<T> = bool Function(T item, String filter);
typedef DropdownSearchCompareFn<T> = bool Function(T item1, T item2);
typedef DropdownSearchBuilder<T> = Widget Function(
    BuildContext context, T? selectedItem);
typedef DropdownSearchBuilderMultiSelection<T> = Widget Function(
  BuildContext context,
  List<T> selectedItems,
);
typedef DropdownSearchPopupItemBuilder<T> = Widget Function(
  BuildContext context,
  T item,
  bool isSelected,
);
typedef DropdownSearchPopupItemEnabled<T> = bool Function(T item);
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
