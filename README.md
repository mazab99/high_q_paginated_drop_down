
In this package you have 2 types of DropDown
1 : BasicPaginatedSearchDropdown .
2 : PaginatedSearchDropdownFormField .
2 : MultiSelectDropDown .

** note : don't use the same controller in more Dropdown
every type includes ( Paginated , Future )

if You need to make pagination use BasicPaginatedSearchDropdown.paginated

HighQPaginatedDropdown<int>.paginated

ex : 
```dart
HighQPaginatedDropdown<int>.paginated(
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
HighQPaginatedDropdown<int>.paginated(
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

