import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:high_q_paginated_drop_down/high_q_paginated_drop_down.dart';

// Include the MultiSelectNotifier class here or import it if it's in a separate file

void main() {
  runApp(MultiSelectionEx());
}

class MultiSelectionEx extends StatelessWidget {
  MultiSelectionEx({Key? key}) : super(key: key);

  final MultiSelectController _controller = MultiSelectController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'MultiSelection Ex',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.green,
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 20),
            HighQMultiSelectDropDown<String>(
              controller: _controller,
              key: UniqueKey(),
              enabled: true,
              moreText: 'عرض المزيد',
              lessText: 'عرض أقل',
              maxDisplayCount: 1,
              clearButtonProps: const ClearButtonProps(
                isVisible: false,
              ),
              itemsLogicProps: ItemsLogicProps(
                items: const [
                  "Story-time",
                  "Outdoor Play",
                  "Board Games",
                  'Creative Play',
                  'Cooking or Baking',
                  'Learning Activities',
                  'Crafts',
                  'Arts',
                ],
                itemAsString: (item) {
                  return item;
                },
              ),
              filterAndCompareProps: FilterAndCompareProps(
                compareFn: (item1, item2) => item1 == item2,
                filterFn: (item, filter) =>
                    item.toLowerCase().contains(filter.toLowerCase()),
              ),
              dropdownDecorator: DropDownDecoratorProps(
                textAlignVertical: TextAlignVertical.center,
                multiSelectDropDownDecoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.green,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.green,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.green,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  hintText: 'Types',
                  contentPadding: const EdgeInsets.all(10),
                ),
                textAlign: TextAlign.start,
              ),
              popupProps: PopupPropsMultiSelection.menu(
                loadingBuilder: (context, searchEntry) {
                  return const CircularProgressIndicator();
                },
                scrollbarProps: const ScrollbarProps(
                  thumbColor: Colors.green,
                  thickness: 3,
                ),
                isFilterOnline: true,
                fit: FlexFit.loose,
                showSearchBox: true,
                textFieldOnChanged: (value) {
                  if (kDebugMode) {
                    print(value);
                  }
                },
                showSelectedItems: true,
              ),
              selectedItemDecorationPros: SelectedItemDecorationPros(
                selectedItemBoxDecoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(5),
                ),
                removeItemWidget: const Icon(
                  Icons.remove_circle_outline,
                  color: Colors.red,
                ),
                removeItemWidgetPadding: const EdgeInsets.all(5),
                selectedItemTextPadding: const EdgeInsets.all(5),
                selectedItemBoxMargin: const EdgeInsets.all(5),
                selectedItemTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
                moreTextStyle: const TextStyle(
                  color: Colors.red,
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
              confirmButtonProps: ConfirmButtonProps(
                confirmText: 'done',
                confirmTextTextStyle: const TextStyle(color: Colors.white),
                confirmButtonStyle: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.red),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                      side: const BorderSide(color: Colors.green),
                    ),
                  ),
                  minimumSize: WidgetStateProperty.all(
                    const Size(
                      double.infinity,
                      30,
                    ),
                  ),
                ),
                confirmButtonPadding: const EdgeInsets.all(8),
              ),
              methodLogicProps: MethodLogicProps(
                onChanged: (value) {
                  if (kDebugMode) {
                    print(value);
                  }
                },
                onSaved: (newValue) {
                  if (kDebugMode) {
                    print(newValue);
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _controller.clearSelection();
              },
              child: const Text('Clear All Items'),
            ),
          ],
        ),
      ),
    );
  }
}
