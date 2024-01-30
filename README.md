
In this package you have 2 types of DropDown
1 : BasicPaginatedSearchDropdown .
2 : PaginatedSearchDropdownFormField .
2 : MultiSelectDropDown .

** note : don't use the same controller in more Dropdown
every type includes ( Paginated , Future )

if You need to make pagination use BasicPaginatedSearchDropdown.paginated

ex : 
```dart
BasicPaginatedSearchDropdown<int>.paginated(
  requestItemCount: 25,
  backgroundDecoration: (child) => InputDecorator(
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      labelText: 'Pokemons',
    ),
    child: child,
  ),
  hintText: const Text('Search Anime'),
  paginatedRequest: (int page, String? searchText) async {
    final paginatedList = await getAnimeList(page: page, key: searchText);
    return paginatedList?.animeList?.map((e) {
      return MenuItemModel(
        value: e.malId,
        label: e.title ?? '',
        child: Text(
          e.title ?? '',
        ),
      );
    }).toList();
  },
  padding: const EdgeInsets.all(0),
  onChanged: (int? value) {
    debugPrint('$value');
  },
  hasTrailingClearIcon: false,
  trailingIcon: const Icon(
    Icons.arrow_circle_down_outlined,
    color: Colors.red,
  ),
);

```



if You need to make pagination and validation in same time use PaginatedSearchDropdownFormField.paginated

ex : 
```dart
PaginatedSearchDropdownFormField<int>.paginated(
  controller: searchableDropdownController,
  backgroundDecoration: (child) => InputDecorator(
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      labelText: 'Pokemons',
    ),
    child: child,
  ),
  hintText: const Text('Search Anime'),
  padding: const EdgeInsets.all(0),
  paginatedRequest: (int page, String? searchText) async {
    final paginatedList = await getAnimeList(page: page, key: searchText);
    return paginatedList?.animeList
        ?.map((e) => MenuItemModel(
              value: e.malId,
              label: e.title ?? '',
              child: Text(e.title ?? ''),
            ))
        .toList();
  },
  validator: (val) {
    if (val == null) return 'Can\'t be empty';
    return null;
  },
  onSaved: (val) {
    debugPrint('On save: $val');
  },
);
```



if You need to multiselect use MultiSelectDropDown

ex : 
```dart
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
```