import 'package:example/pagination_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:paginated_search_drop_down/paginated_search_drop_down.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final TextEditingController _userEditTextController = TextEditingController();
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
          backgroundColor: Colors.green,
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // const SizedBox(height: 20),
            // BasicPaginatedSearchDropdown<Anime>.paginated(
            //   hintText: Text(
            //     'search_for_city',
            //     style: Theme.of(context).inputDecorationTheme.hintStyle,
            //     textScaler: const TextScaler.linear(1.0),
            //   ),
            //   searchHintText: 'search_for_city',
            //   paginatedRequest: (
            //     int page,
            //     String? searchText,
            //   ) async {
            //     final paginatedList = await getAnimeList(
            //       page: page,
            //       queryParameters: {
            //         'page': page,
            //         "q": searchText,
            //       },
            //     );
            //     return paginatedList?.animeList?.map((e) {
            //       return MenuItemModel<Anime>(
            //         value: e,
            //         label: e.title ?? '',
            //         child: Text(
            //           e.title ?? '',
            //           style: const TextStyle(
            //             color: Colors.green,
            //             fontSize: 5,
            //           ),
            //         ),
            //       );
            //     }).toList();
            //   },
            //   padding: const EdgeInsets.all(0),
            //   hasTrailingClearIcon: false,
            //   searchDelayDuration: const Duration(milliseconds: 800),
            //   spaceBetweenDropDownAndItemsDialog: 10,
            //   isEnabled: true,
            //   onTapWhileDisableDropDown: () {},
            //   dropDownMaxHeight: 200,
            //   isDialogExpanded: true,
            //   paddingValueWhileIsDialogExpanded: 16,
            //   backgroundDecoration: (child) {
            //     return InputDecorator(
            //       decoration: InputDecoration(
            //         border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(
            //             15.0,
            //           ),
            //         ),
            //         contentPadding: const EdgeInsets.symmetric(
            //           horizontal: 8,
            //         ),
            //       ),
            //       child: child,
            //     );
            //   },
            //   onChanged: (Anime? data) {},
            // ),
            // const SizedBox(height: 20),
            // BasicPaginatedSearchDropdown<Anime>.paginated(
            //   key: dropdownFormFieldKey1,
            //   controller: searchableDropdownController1,
            //   requestItemCount: 25,
            //   width: 10,
            //   loadingWidget: const CircularProgressIndicator(
            //     color: Colors.green,
            //   ),
            //   backgroundDecoration: (child) {
            //     return InputDecorator(
            //       decoration: InputDecoration(
            //         border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(
            //             15.0,
            //           ),
            //         ),
            //         contentPadding: const EdgeInsets.symmetric(
            //           horizontal: 8,
            //         ),
            //         labelText: 'Pokemons',
            //       ),
            //       child: child,
            //     );
            //   },
            //   hintText: const Text('Search Anime'),
            //   paginatedRequest: (
            //     int page,
            //     String? searchText,
            //   ) async {
            //     final AnimePaginatedList? paginatedList = await getAnimeList(
            //       page: page,
            //       queryParameters: {
            //         'page': page,
            //         "q": searchText,
            //       },
            //     );
            //     return paginatedList?.animeList?.map((e) {
            //       return MenuItemModel<Anime>(
            //         value: e,
            //         label: e.title ?? '',
            //         child: Text(
            //           e.title ?? '',
            //           style: const TextStyle(
            //             color: Colors.white,
            //           ),
            //         ),
            //       );
            //     }).toList();
            //   },
            //
            //   padding: const EdgeInsets.all(0),
            //   onChanged: (Anime? value) {
            //     debugPrint('$value');
            //   },
            //   hasTrailingClearIcon: true,
            //   trailingIcon: const Icon(
            //     Icons.arrow_circle_down_outlined,
            //     color: Colors.green,
            //   ),
            //   searchHintText: 'Hi search for any thing',
            //   trailingClearIcon: const Icon(
            //     Icons.delete,
            //     color: Colors.green,
            //   ),
            //   searchDelayDuration: const Duration(milliseconds: 800),
            //   leadingIcon: const Icon(
            //     Icons.language,
            //     color: Colors.green,
            //   ),
            //   spaceBetweenDropDownAndItemsDialog: 10,
            //   isEnabled: true,
            //   onTapWhileDisableDropDown: () {},
            //   //dropDownMaxHeight: 150,
            //   isDialogExpanded: true,
            //   paddingValueWhileIsDialogExpanded: 16,
            //   noRecordText: const Text('HJKHJKHJKLJKJH'),
            // ),
            // const SizedBox(height: 50),
            MultiSelectDropDown<String>(
              key: UniqueKey(),
              enabled: true,
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
                filterFn: (item, filter) => item.toLowerCase().contains(filter.toLowerCase()),
                filterIcon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.green,
                ),
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
                searchFieldProps: TextFieldProps(
                  controller: _userEditTextController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _userEditTextController.clear();
                      },
                    ),
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
                        color: Colors.green,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.green,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    hintText: 'Choose'
                  ),
                ),
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
                selectedItemTextStyle: const TextStyle(color: Colors.white, fontSize: 15),
              ),
              confirmButtonProps: ConfirmButtonProps(
                confirmText: 'done',
                confirmTextTextStyle: const TextStyle(color: Colors.white),
                confirmButtonStyle: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                      side: const BorderSide(color: Colors.green),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(const Size(double.infinity,30,),),
                ),
                confirmButtonPadding: const EdgeInsets.all(8),
              ),
              validatorProps: ValidatorProps(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'required filed';
                  } else if (value.length > 3) {
                    return "only 1 to 3 items are allowed";
                  }
                  return null;
                },
                autoValidateMode: AutovalidateMode.always,
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
          ],
        ),
      ),
    );
  }
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
