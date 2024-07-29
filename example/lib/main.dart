import 'package:example/pagination_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:high_q_paginated_drop_down/high_q_paginated_drop_down.dart';

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
        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const SizedBox(height: 20),
              HighQPaginatedDropdown<Anime>.paginated(
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
                          color: Colors.green,
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
              FormField<Anime>(
                validator: (Anime? value) {
                  if (value == null) {
                    return 'Please select an anime';
                  }
                  return null;
                },
                builder: (FormFieldState<Anime> state) {
                  return HighQPaginatedDropdown<Anime>.paginated(
                    controller: searchableDropdownController1,
                    requestItemCount: 25,
                    width: 10,
                    loadingWidget: const CircularProgressIndicator(
                      color: Colors.green,
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
                          labelText: 'Anime',
                          errorText: state.errorText,
                        ),
                        child: child,
                      );
                    },
                    hintText: const Text('Search Anime'),
                    paginatedRequest: (
                        int page,
                        String? searchText,
                        ) async {
                      final AnimePaginatedList? paginatedList =
                      await getAnimeList(
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
                      state.didChange(value); // Notify FormField of the change
                    },
                    hasTrailingClearIcon: true,
                    trailingIcon: const Icon(
                      Icons.arrow_circle_down_outlined,
                      color: Colors.green,
                    ),
                    searchHintText: 'Hi search for any thing',
                    trailingClearIcon: const Icon(
                      Icons.delete,
                      color: Colors.green,
                    ),
                    searchDelayDuration: const Duration(milliseconds: 800),
                    leadingIcon: const Icon(
                      Icons.language,
                      color: Colors.green,
                    ),
                    spaceBetweenDropDownAndItemsDialog: 10,
                    isEnabled: true,
                    onTapWhileDisableDropDown: () {},
                    //dropDownMaxHeight: 150,
                    isDialogExpanded: true,
                    paddingValueWhileIsDialogExpanded: 16,
                    noRecordText: const Text('HJKHJKHJKLJKJH'),
                  );
                },
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    // Perform submission actions if form is valid
                    print('Form is valid!');
                  } else {
                    print('Form is invalid!');
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
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
