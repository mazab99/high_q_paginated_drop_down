import 'package:flutter/material.dart';
import '../utils/typedefs.dart';

class FavoriteItemProps<T> {
  final bool showFavoriteItems;

  final FavoriteItemsBuilder<T>? favoriteItemBuilder;


  final FavoriteItems<T>? favoriteItems;


  final MainAxisAlignment favoriteItemsAlignment;

  const FavoriteItemProps({
    this.favoriteItemBuilder,
    this.favoriteItems,
    this.favoriteItemsAlignment = MainAxisAlignment.start,
    this.showFavoriteItems = false,
  });
}
