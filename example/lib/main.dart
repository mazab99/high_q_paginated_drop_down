import 'package:example/pagination_model.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:paginated_search_drop_down/paginated_search_drop_down.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final PaginatedSearchDropdownController<Anime> searchableDropdownController1 =
      PaginatedSearchDropdownController<Anime>();
  final PaginatedSearchDropdownController<int> searchableDropdownController2 =
      PaginatedSearchDropdownController<int>();
  final PaginatedSearchDropdownController<int> searchableDropdownController3 =
      PaginatedSearchDropdownController<int>();
  final PaginatedSearchDropdownController<int> searchableDropdownController4 =
      PaginatedSearchDropdownController<int>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>(
    debugLabel: '_formKey',
  );

  final GlobalKey<FormFieldState<int>> dropdownFormFieldKey1 =
      GlobalKey<FormFieldState<int>>();
  final GlobalKey<FormFieldState<int>> dropdownFormFieldKey2 =
      GlobalKey<FormFieldState<int>>();
  final GlobalKey<FormFieldState<int>> dropdownFormFieldKey3 =
      GlobalKey<FormFieldState<int>>();
  final GlobalKey<FormFieldState<int>> dropdownFormFieldKey4 =
      GlobalKey<FormFieldState<int>>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Example',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          children: [
            const SizedBox(height: 20),
            BasicPaginatedSearchDropdown<Anime>.paginated(
              hintText: Text(
                'search_for_city',
                style: Theme.of(context).inputDecorationTheme.hintStyle,
                textScaler: const TextScaler.linear(1.0),
              ),
              searchHintText: 'search_for_city',
              paginatedRequest: (
                int page,
                String? searchText,
              ) async {
                final paginatedList = await getAnimeList(
                  page: page,
                  queryParameters: {
                    'page': page,
                    "q": searchText,
                  },
                );
                return paginatedList?.animeList?.map((e) {
                  return MenuItemModel<Anime>(
                    value: e,
                    label: e.title ?? '',
                    child: Text(
                      e.title ?? '',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 5,
                      ),
                    ),
                  );
                }).toList();
              },
              padding: const EdgeInsets.all(0),
              hasTrailingClearIcon: false,
              searchDelayDuration: const Duration(milliseconds: 800),
              spaceBetweenDropDownAndItemsDialog: 10,
              isEnabled: true,
              onTapWhileDisableDropDown: () {},
              dropDownMaxHeight: 200,
              isDialogExpanded: true,
              paddingValueWhileIsDialogExpanded: 16,
              backgroundDecoration: (child) {
                return InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        15.0,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                  ),
                  child: child,
                );
              },
              onChanged: (Anime? data) {},
            ),
            const SizedBox(height: 20),
            BasicPaginatedSearchDropdown<Anime>.paginated(
              key: dropdownFormFieldKey1,
              controller: searchableDropdownController1,
              requestItemCount: 25,
              width: 10,
              loadingWidget: const CircularProgressIndicator(
                color: Colors.red,
              ),
              backgroundDecoration: (child) {
                return InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        15.0,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    labelText: 'Pokemons',
                  ),
                  child: child,
                );
              },
              hintText: const Text('Search Anime'),
              paginatedRequest: (
                int page,
                String? searchText,
              ) async {
                final AnimePaginatedList? paginatedList = await getAnimeList(
                  page: page,
                  queryParameters: {
                    'page': page,
                    "q": searchText,
                  },
                );
                return paginatedList?.animeList?.map((e) {
                  return MenuItemModel<Anime>(
                    value: e,
                    label: e.title ?? '',
                    child: Text(
                      e.title ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                }).toList();
              },

              padding: const EdgeInsets.all(0),
              onChanged: (Anime? value) {
                debugPrint('$value');
              },
              hasTrailingClearIcon: true,
              trailingIcon: const Icon(
                Icons.arrow_circle_down_outlined,
                color: Colors.red,
              ),
              searchHintText: 'Hi search for any thing',
              trailingClearIcon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              searchDelayDuration: const Duration(milliseconds: 800),
              leadingIcon: const Icon(
                Icons.language,
                color: Colors.red,
              ),
              spaceBetweenDropDownAndItemsDialog: 10,
              isEnabled: true,
              onTapWhileDisableDropDown: () {},
              //dropDownMaxHeight: 150,
              isDialogExpanded: true,
              paddingValueWhileIsDialogExpanded: 16,
              noRecordText: const Text('HJKHJKHJKLJKJH'),
            ),
            const SizedBox(height: 50),
            MultiSelectDropDown<String>(
              selectedItems: ['1'],
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
              compareFn: (item1, item2) => item1 == item2,
              filterFn: (item, filter) => true,
              dropdownDecoratorProps: DropDownDecoratorProps(
                textAlignVertical: TextAlignVertical.center,
                multiSelectDropDownDecoration: InputDecoration(
                  icon: const Icon(
                    Icons.local_activity_outlined,
                    color: Colors.red,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(
                      color: Colors.greenAccent,
                      width: 0.5,
                    ),
                  ),
                  hintText: 'choose',
                  contentPadding: const EdgeInsets.all(10),
                ),
                textAlign: TextAlign.start,
              ),

              popupProps: PopupPropsMultiSelection.menu(
                title: const Column(
                  children: [
                    SizedBox(height: 15),
                    Text(
                      'choose_activities_practiced_by_the_babysitter',
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 10),
                  ],
                ),
                loadingBuilder: (context, searchEntry) {
                  return const CircularProgressIndicator();
                },
                scrollbarProps: const ScrollbarProps(
                  thumbColor: Colors.green,
                  thickness: 3,
                ),
                isFilterOnline: true,
                fit: FlexFit.loose,
              ),
              // confirmButtonProps: ConfirmButtonProps(
              //   confirmText: 'done',
              //   confirmButtonStyle: ButtonStyle(
              //     backgroundColor: MaterialStateProperty.all(Colors.red),
              //     shape: MaterialStateProperty.all(
              //       RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(3),
              //         side: const BorderSide(color: Colors.green),
              //       ),
              //     ),
              //     textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white)),
              //   ),
              // ),
              enabled: true,
              removeItemWidget: const Icon(Icons.remove),
            ),
            // MultiSelectDropDown<String>(
            //   itemsLogicProps: ItemsLogicProps(
            //     initialSelectedItems: ['1'],
            //     items: const [
            //       "Story-time",
            //       "Outdoor Play",
            //       "Board Games",
            //       'Creative Play',
            //       'Cooking or Baking',
            //       'Learning Activities',
            //       'Crafts',
            //       'Arts',
            //     ],
            //     itemAsString: (item) {
            //       return item;
            //     },
            //   ),
            //   filterAndCompareProps: FilterAndCompareProps(
            //     compareFn: (item1, item2) => item1 == item2,
            //     filterFn: (item, filter) => true,
            //     filterIcon: const Icon(
            //       Icons.add,
            //       color: Colors.red,
            //     ),
            //   ),
            //   dropdownDecorator: DropDownDecoratorProps(
            //     textAlignVertical: TextAlignVertical.center,
            //     multiSelectDropDownDecoration: InputDecoration(
            //       icon: const Icon(
            //         Icons.local_activity_outlined,
            //         color: Colors.red,
            //       ),
            //       enabledBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(6),
            //         borderSide: const BorderSide(
            //           color: Colors.greenAccent,
            //           width: 0.5,
            //         ),
            //       ),
            //       hintText: 'choose',
            //       contentPadding: const EdgeInsets.all(10),
            //     ),
            //     textAlign: TextAlign.start,
            //   ),
            //   selectedItemDecorationPros: SelectedItemDecorationPros(
            //     selectedItemBoxDecoration: BoxDecoration(
            //       color: Colors.grey,
            //       borderRadius: BorderRadius.circular(5),
            //     ),
            //     removeItemWidget: const Icon(
            //       Icons.remove_circle_outline,
            //       color: Colors.red,
            //     ),
            //     removeItemWidgetPadding: const EdgeInsets.only(right: 5),
            //     selectedItemTextPadding: const EdgeInsets.all(5),
            //     selectedItemBoxMargin: EdgeInsets.all(5),
            //     selectedItemTextStyle:
            //         const TextStyle(color: Colors.white, fontSize: 10),
            //   ),
            //   popupProps: PopupPropsMultiSelection.menu(
            //     title: const Column(
            //       children: [
            //         SizedBox(height: 15),
            //         Text(
            //           'choose_activities_practiced_by_the_babysitter',
            //           textAlign: TextAlign.start,
            //         ),
            //         SizedBox(height: 10),
            //       ],
            //     ),
            //     loadingBuilder: (context, searchEntry) {
            //       return const CircularProgressIndicator();
            //     },
            //     scrollbarProps: const ScrollbarProps(
            //       thumbColor: Colors.green,
            //       thickness: 3,
            //     ),
            //     isFilterOnline: true,
            //     fit: FlexFit.loose,
            //   ),
            //   validatorProps: ValidatorProps(
            //     validator: (value) {
            //       if (value!.isEmpty) {
            //         return 'select at-least one';
            //       } else {
            //         return null;
            //       }
            //     },
            //     autoValidateMode: AutovalidateMode.always,
            //   ),
            //   // confirmButtonProps: ConfirmButtonProps(
            //   //   confirmText: 'done',
            //   //   confirmButtonStyle: ButtonStyle(
            //   //     backgroundColor: MaterialStateProperty.all(Colors.red),
            //   //     shape: MaterialStateProperty.all(
            //   //       RoundedRectangleBorder(
            //   //         borderRadius: BorderRadius.circular(3),
            //   //         side: const BorderSide(color: Colors.green),
            //   //       ),
            //   //     ),
            //   //     textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white)),
            //   //   ),
            //   // ),
            //   enabled: true,
            // ),
          ],
        ),
      ),
    );
  }

  Future<AnimePaginatedList?> getAnimeList({
    required int page,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      String url = "https://api.jikan.moe/v4/anime";

      Response<dynamic> response = await Dio()
          .get(
        url,
        queryParameters: queryParameters,
      )
          .then((value) {
        return value;
      });
      if (response.statusCode != 200) throw Exception(response.statusMessage);
      return AnimePaginatedList.fromJson(response.data);
    } catch (exception) {
      throw Exception(exception);
    }
  }
}
