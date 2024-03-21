import '../utils/typedefs.dart';

class ItemsLogicProps<T> {
  final List<T> items;
  final List<T> initialSelectedItems;
  final MultiSelectDropDownOnFind<T>? asyncItems;
  final MultiSelectDropDownItemAsString<T>? itemAsString;

  const ItemsLogicProps({
     this.items= const [],
     this.initialSelectedItems= const [],
    this.asyncItems,
    this.itemAsString,
  });
}
