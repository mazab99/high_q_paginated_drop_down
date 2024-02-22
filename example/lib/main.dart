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

  final PaginatedSearchDropdownController<Anime>
      searchableDropdownController1 =
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
                    'page':page,
                    "q":searchText,
                  },
                );
                return paginatedList?.animeList?.map((e) {
                  return MenuItemModel<Anime>(
                    value: e,
                    label: e.title ?? '',
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: const BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      color: Colors.green,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          e.title ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
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
              dropdownDecoratorProps: DropDownDecoratorProps(
                textAlignVertical: TextAlignVertical.center,
                multiSelectDropDownDecoration: InputDecoration(
                  // icon: Icon(
                  //   Icons.local_activity_outlined,
                  //   color: HexColorManager.mainAppColor,
                  // ),
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
              confirmText: 'done',
              confirmButtonStyle: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                shape: MaterialStateProperty.all(
                   RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                     side: BorderSide(color: Colors.green)
                  ),
                ),
              ),
              confirmTextTextStyle: const TextStyle(color: Colors.white),
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


            ),

            // const SizedBox(height: 20),
            // BasicPaginatedSearchDropdown<int>(
            //   key: dropdownFormFieldKey2,
            //   controller: searchableDropdownController2,
            //   width: 200,
            //   isDialogExpanded: false,
            //   backgroundDecoration: (child) => InputDecorator(
            //     decoration: InputDecoration(
            //       border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(15.0)),
            //       contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            //       labelText: 'Pokemons',
            //     ),
            //     child: child,
            //   ),
            //   hintText: const Text('List of items'),
            //   padding: const EdgeInsets.all(15),
            //   items: List.generate(
            //     10,
            //     (i) => MenuItemModel(
            //       value: i,
            //       label: 'item $i',
            //       child: Text(
            //         'item $i',
            //       ),
            //     ),
            //   ),
            //   onChanged: (int? value) {
            //     debugPrint('$value');
            //   },
            // ),
            // const SizedBox(height: 20),
            // Form(
            //   key: formKey,
            //   child: Column(
            //     children: [
            //       PaginatedSearchDropdownFormField<int>(
            //         key: dropdownFormFieldKey3,
            //         controller: searchableDropdownController3,
            //         backgroundDecoration: (child) => InputDecorator(
            //           decoration: InputDecoration(
            //             border: OutlineInputBorder(
            //                 borderRadius: BorderRadius.circular(15.0)),
            //             contentPadding:
            //                 const EdgeInsets.symmetric(horizontal: 8),
            //             labelText: 'Anime',
            //           ),
            //           child: child,
            //         ),
            //         hintText: const Text('Search Anime'),
            //         padding: const EdgeInsets.all(0),
            //         items: List.generate(
            //             10,
            //             (i) => MenuItemModel(
            //                 value: i,
            //                 label: 'item $i',
            //                 child: Text('item $i'))),
            //         validator: (val) {
            //           if (val == null) return 'Cant be empty';
            //           return null;
            //         },
            //         onSaved: (val) {
            //           debugPrint('On save: $val');
            //         },
            //       ),
            //       const SizedBox(height: 100),
            //       PaginatedSearchDropdownFormField<int>.paginated(
            //         controller: searchableDropdownController4,
            //         key: dropdownFormFieldKey4,
            //         backgroundDecoration: (child) => InputDecorator(
            //           decoration: InputDecoration(
            //             border: OutlineInputBorder(
            //                 borderRadius: BorderRadius.circular(15.0)),
            //             contentPadding:
            //                 const EdgeInsets.symmetric(horizontal: 8),
            //             labelText: 'Pokemons',
            //           ),
            //           child: child,
            //         ),
            //         hintText: const Text('Search Pokemons'),
            //         padding: const EdgeInsets.all(0),
            //         paginatedRequest: (int page, String? searchText) async {
            //           final paginatedList =
            //               await getAnimeList(page: page, key: searchText);
            //           return paginatedList?.animeList
            //               ?.map((e) => MenuItemModel(
            //                   value: e.malId,
            //                   label: e.title ?? '',
            //                   child: Text(e.title ?? '')))
            //               .toList();
            //         },
            //         validator: (val) {
            //           if (val == null) return 'Cant be empty';
            //           return null;
            //         },
            //         onSaved: (val) {
            //           debugPrint('On save: $val');
            //         },
            //       ),
            //     ],
            //   ),
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     TextButton(
            //       onPressed: () {
            //         if (formKey.currentState?.validate() ?? false) {
            //           formKey.currentState?.save();
            //         }
            //       },
            //       child: const Text('Save'),
            //     ),
            //   ],
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

      Response<dynamic> response = await Dio().get(
        url,
        queryParameters: queryParameters,
      ).then((value) {
        return value;
      });
      if (response.statusCode != 200) throw Exception(response.statusMessage);
      return AnimePaginatedList.fromJson(response.data);
    } catch (exception) {
      throw Exception(exception);
    }
  }
}
