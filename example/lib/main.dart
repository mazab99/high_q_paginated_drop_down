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

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final PaginatedSearchDropdownController<Anime> searchableDropdownController1 =
  PaginatedSearchDropdownController<Anime>();

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
          key: formKey, // Assign the form key
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const SizedBox(height: 20),
              FormField<Anime>(
                validator: (value) {
                  if (value == null) {
                    return 'Please select an anime';
                  }
                  return null;
                },
                builder: (FormFieldState<Anime> state) {
                  return  HighQPaginatedDropdown<Anime>.paginated(
                    controller: searchableDropdownController1,
                    requestItemCount: 25,
                    width: double.infinity,
                    loadingWidget: const CircularProgressIndicator(
                      color: Colors.green,
                    ),
                    backgroundDecoration: (child) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
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
                              color: Colors.black12,
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
                    if (kDebugMode) {
                      print('Form is valid!');
                    }
                  } else {
                    if (kDebugMode) {
                      print('Form is invalid!');
                    }
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
