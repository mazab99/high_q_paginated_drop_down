import 'package:flutter/material.dart';

import '../utils/typedefs.dart';

class FilterAndCompareProps<T> {
  final MultiSelectDropDownFilterFn<T>? filterFn;
  final MultiSelectDropDownCompareFn<T>? compareFn;
  final Widget? filterIcon;
  const FilterAndCompareProps({
    this.filterFn,
    this.compareFn,
    this.filterIcon= const Icon(Icons.arrow_drop_down_sharp),
  });
}
