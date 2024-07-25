import '../utils/typedefs.dart';

class FilterAndCompareProps<T> {
  final MultiSelectDropDownFilterFn<T>? filterFn;
  final MultiSelectDropDownCompareFn<T>? compareFn;
  //final Widget? filterIcon;
  const FilterAndCompareProps({
    this.filterFn,
    this.compareFn,
    //this.filterIcon,
  });
}
