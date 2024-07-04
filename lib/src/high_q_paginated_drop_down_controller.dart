import 'dart:async';
import 'package:flutter/material.dart';
import 'package:high_q_paginated_drop_down/src/extensions/string_extension.dart';
import 'package:high_q_paginated_drop_down/src/model/menu_item_model.dart';

// ignore: prefer-match-file-name
enum PaginatedSearchDropdownStatus { initial, busy, error, loaded }

class PaginatedSearchDropdownController<T> {
  PaginatedSearchDropdownController({MenuItemModel<T>? initialItem}) {
    if (initialItem != null) selectedItem.value = initialItem;
  }

  final GlobalKey key = GlobalKey();
  final ValueNotifier<List<MenuItemModel<T>>?> paginatedItemList =
      ValueNotifier<List<MenuItemModel<T>>?>(null);
  final ValueNotifier<MenuItemModel<T>?> selectedItem =
      ValueNotifier<MenuItemModel<T>?>(null);
  final ValueNotifier<PaginatedSearchDropdownStatus> status =
      ValueNotifier<PaginatedSearchDropdownStatus>(
    PaginatedSearchDropdownStatus.initial,
  );

  late Future<List<MenuItemModel<T>>?> Function(
    int page,
    String? key,
  )? paginatedRequest;

  late int requestItemCount;

  late List<MenuItemModel<T>>? items;

  String searchText = '';
  final ValueNotifier<List<MenuItemModel<T>>?> searchedItems =
      ValueNotifier<List<MenuItemModel<T>>?>(null);

  bool _hasMoreData = true;
  int _page = 1;

  int get page => _page;

  Future<void> getItemsWithPaginatedRequest({
    required int page,
    String? searchText,
    bool isNewSearch = false,
  }) async {
    if (paginatedRequest == null) return;
    if (isNewSearch) {
      _page = 1;
      paginatedItemList.value = [];
      _hasMoreData = true;
    }
    if (!_hasMoreData) return;
    status.value = PaginatedSearchDropdownStatus.busy;
    final response = await paginatedRequest!(page, searchText);
    if (response is! List<MenuItemModel<T>>) return;
    // Prevent adding duplicates
    if (paginatedItemList.value == null) {
      paginatedItemList.value = response;
    } else {
      final existingIds = paginatedItemList.value!.map((e) => e.value).toSet();
      paginatedItemList.value!.addAll(
        response.where((item) => !existingIds.contains(item.value)),
      );
    }

    if (response.length < requestItemCount) {
      _hasMoreData = false;
    } else {
      _page += 1;
    }

    status.value = PaginatedSearchDropdownStatus.loaded;
  }

  void fillSearchedList(String? value) {
    if (value == null || value.isEmpty) {
      searchedItems.value = items;
      return;
    }

    final tempList = <MenuItemModel<T>>[];
    for (final element in items ?? <MenuItemModel<T>>[]) {
      if (element.label.containsWithTurkishChars(value)) {
        tempList.add(element);
      }
    }
    searchedItems.value = tempList;
  }

  void clear() {
    selectedItem.value = null;
  }

  void dispose() {
    paginatedItemList.dispose();
    selectedItem.dispose();
    status.dispose();
    searchedItems.dispose();
  }
}
