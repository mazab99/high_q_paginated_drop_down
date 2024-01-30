import 'package:flutter/material.dart';
import 'package:paginated_search_drop_down/src/properties/scrollbar_props.dart';
import 'package:paginated_search_drop_down/src/properties/text_field_props.dart';
import '../utils/typedefs.dart';
import 'dialog_props.dart';
import 'favorite_item_props.dart';
import 'list_view_props.dart';
import 'menu_props.dart';
import 'modal_bottom_sheet_props.dart';

class PopupProps<T> {
  final Widget? title;

  final bool showSearchBox;

  final MultiSelectDropDownPopupItemBuilder<T>? itemBuilder;

  final TextFieldProps searchFieldProps;

  final ListViewProps listViewProps;

  final ScrollbarProps scrollbarProps;

  final Duration searchDelay;

  final VoidCallback? onDismissed;

  final EmptyBuilder? emptyBuilder;

  final LoadingBuilder? loadingBuilder;

  final ErrorBuilder? errorBuilder;

  final MultiSelectDropDownPopupItemEnabled<T>? disabledItemFn;

  final Mode mode;

  final bool showSelectedItems;

  final bool isFilterOnline;

  final FavoriteItemProps<T> favoriteItemProps;

  final DialogProps dialogProps;

  //final BottomSheetProps bottomSheetProps;

  final ModalBottomSheetProps modalBottomSheetProps;

  final MenuProps menuProps;

  final FlexFit fit;

  final PopupBuilder? containerBuilder;

  final BoxConstraints constraints;

  final bool interceptCallBacks;

  const PopupProps._({
    this.mode = Mode.menu,
    this.fit = FlexFit.tight,
    this.title,
    this.showSearchBox = false,
    //this.bottomSheetProps = const BottomSheetProps(),
    this.dialogProps = const DialogProps(),
    this.modalBottomSheetProps = const ModalBottomSheetProps(),
    this.menuProps = const MenuProps(),
    this.searchFieldProps = const TextFieldProps(),
    this.scrollbarProps = const ScrollbarProps(),
    this.listViewProps = const ListViewProps(),
    this.favoriteItemProps = const FavoriteItemProps(),
    this.searchDelay = const Duration(seconds: 1),
    this.onDismissed,
    this.emptyBuilder,
    this.itemBuilder,
    this.errorBuilder,
    this.loadingBuilder,
    this.showSelectedItems = false,
    this.disabledItemFn,
    this.isFilterOnline = false,
    this.containerBuilder,
    this.constraints = const BoxConstraints(),
    this.interceptCallBacks = false,
  });

  const PopupProps.menu({
    this.title,
    this.fit = FlexFit.tight,
    this.showSearchBox = false,
    this.menuProps = const MenuProps(),
    this.searchFieldProps = const TextFieldProps(),
    this.scrollbarProps = const ScrollbarProps(),
    this.listViewProps = const ListViewProps(),
    this.favoriteItemProps = const FavoriteItemProps(),
    this.searchDelay = const Duration(seconds: 1),
    this.onDismissed,
    this.emptyBuilder,
    this.itemBuilder,
    this.errorBuilder,
    this.loadingBuilder,
    this.showSelectedItems = false,
    this.disabledItemFn,
    this.isFilterOnline = false,
    this.containerBuilder,
    this.constraints = const BoxConstraints(maxHeight: 350),
    this.interceptCallBacks = false,
  })  : mode = Mode.menu,
        //bottomSheetProps = const BottomSheetProps(),
        dialogProps = const DialogProps(),
        modalBottomSheetProps = const ModalBottomSheetProps();

  const PopupProps.dialog({
    this.fit = FlexFit.tight,
    this.title,
    this.showSearchBox = false,
    this.dialogProps = const DialogProps(),
    this.searchFieldProps = const TextFieldProps(),
    this.scrollbarProps = const ScrollbarProps(),
    this.listViewProps = const ListViewProps(),
    this.favoriteItemProps = const FavoriteItemProps(),
    this.searchDelay = const Duration(seconds: 1),
    this.onDismissed,
    this.emptyBuilder,
    this.itemBuilder,
    this.errorBuilder,
    this.loadingBuilder,
    this.showSelectedItems = false,
    this.disabledItemFn,
    this.isFilterOnline = false,
    this.containerBuilder,
    this.constraints = const BoxConstraints(
      minWidth: 500,
      maxWidth: 500,
      maxHeight: 600,
    ),
    this.interceptCallBacks = false,
  })  : mode = Mode.dialog,
        menuProps = const MenuProps(),
        //bottomSheetProps = const BottomSheetProps(),
        modalBottomSheetProps = const ModalBottomSheetProps();

  const PopupProps.modalBottomSheet({
    this.title,
    this.fit = FlexFit.tight,
    this.showSearchBox = false,
    this.modalBottomSheetProps = const ModalBottomSheetProps(),
    this.searchFieldProps = const TextFieldProps(),
    this.scrollbarProps = const ScrollbarProps(),
    this.listViewProps = const ListViewProps(),
    this.favoriteItemProps = const FavoriteItemProps(),
    this.searchDelay = const Duration(seconds: 1),
    this.onDismissed,
    this.emptyBuilder,
    this.itemBuilder,
    this.errorBuilder,
    this.loadingBuilder,
    this.showSelectedItems = false,
    this.disabledItemFn,
    this.isFilterOnline = false,
    this.containerBuilder,
    this.constraints = const BoxConstraints(maxHeight: 500),
    this.interceptCallBacks = false,
  })  : mode = Mode.modelBottomSheet,
        menuProps = const MenuProps(),
        dialogProps = const DialogProps();
//bottomSheetProps = const BottomSheetProps()
}

class PopupPropsMultiSelection<T> extends PopupProps<T> {
  ///called when a new item added on Multi selection mode
  final OnItemAdded<T>? onItemAdded;

  ///called when a new item added on Multi selection mode
  final OnItemRemoved<T>? onItemRemoved;

  ///widget used to show checked items in multiSelection mode
  final MultiSelectDropDownPopupItemBuilder<T>? selectionWidget;

  ///widget used to validate items in multiSelection mode
  final ValidationMultiSelectionBuilder<T>? validationWidgetBuilder;

  final TextDirection textDirection;

  const PopupPropsMultiSelection._({
    super.mode = Mode.menu,
    super.fit = FlexFit.tight,
    super.title,
    super.isFilterOnline,
    super.itemBuilder,
    super.disabledItemFn,
    super.showSearchBox,
    super.searchFieldProps = const TextFieldProps(),
    super.favoriteItemProps = const FavoriteItemProps(),
    super.modalBottomSheetProps = const ModalBottomSheetProps(),
    super.scrollbarProps = const ScrollbarProps(),
    super.listViewProps = const ListViewProps(),
    super.searchDelay,
    super.onDismissed,
    super.emptyBuilder,
    super.errorBuilder,
    super.loadingBuilder,
    super.showSelectedItems,
    //super.bottomSheetProps = const BottomSheetProps(),
    super.dialogProps = const DialogProps(),
    super.menuProps = const MenuProps(),
    super.containerBuilder,
    super.constraints = const BoxConstraints(maxHeight: 350),
    super.interceptCallBacks = false,
    this.onItemAdded,
    this.onItemRemoved,
    this.selectionWidget,
    this.validationWidgetBuilder,
    this.textDirection = TextDirection.ltr,
  }) : super._();

  const PopupPropsMultiSelection.menu({
    super.title,
    super.fit = FlexFit.tight,
    super.showSearchBox = false,
    super.searchFieldProps = const TextFieldProps(),
    super.menuProps = const MenuProps(),
    super.favoriteItemProps = const FavoriteItemProps(),
    super.scrollbarProps = const ScrollbarProps(),
    super.listViewProps = const ListViewProps(),
    super.searchDelay,
    super.onDismissed,
    super.emptyBuilder,
    super.itemBuilder,
    super.errorBuilder,
    super.loadingBuilder,
    super.showSelectedItems = false,
    super.disabledItemFn,
    super.isFilterOnline = false,
    super.containerBuilder,
    super.constraints = const BoxConstraints(maxHeight: 350),
    super.interceptCallBacks = false,
    this.onItemAdded,
    this.onItemRemoved,
    this.selectionWidget,
    this.validationWidgetBuilder,
    this.textDirection = TextDirection.ltr,
  }) : super.menu();

  const PopupPropsMultiSelection.dialog({
    super.title,
    super.fit = FlexFit.tight,
    super.showSearchBox = false,
    super.searchFieldProps = const TextFieldProps(),
    super.scrollbarProps = const ScrollbarProps(),
    super.listViewProps = const ListViewProps(),
    super.favoriteItemProps = const FavoriteItemProps(),
    super.dialogProps = const DialogProps(),
    super.searchDelay,
    super.onDismissed,
    super.emptyBuilder,
    super.itemBuilder,
    super.errorBuilder,
    super.loadingBuilder,
    super.showSelectedItems = false,
    super.disabledItemFn,
    super.isFilterOnline = false,
    super.containerBuilder,
    super.constraints = const BoxConstraints(
      minWidth: 500,
      maxWidth: 500,
      maxHeight: 600,
    ),
    super.interceptCallBacks = false,
    this.onItemAdded,
    this.onItemRemoved,
    this.selectionWidget,
    this.validationWidgetBuilder,
    this.textDirection = TextDirection.ltr,
  }) : super.dialog();

  const PopupPropsMultiSelection.modalBottomSheet({
    super.title,
    super.isFilterOnline,
    super.fit = FlexFit.tight,
    super.itemBuilder,
    super.disabledItemFn,
    super.showSearchBox,
    super.searchFieldProps = const TextFieldProps(),
    super.favoriteItemProps = const FavoriteItemProps(),
    super.modalBottomSheetProps = const ModalBottomSheetProps(),
    super.scrollbarProps = const ScrollbarProps(),
    super.listViewProps = const ListViewProps(),
    super.searchDelay,
    super.onDismissed,
    super.emptyBuilder,
    super.errorBuilder,
    super.loadingBuilder,
    super.showSelectedItems,
    super.containerBuilder,
    super.constraints = const BoxConstraints(maxHeight: 500),
    super.interceptCallBacks = false,
    this.onItemAdded,
    this.onItemRemoved,
    this.selectionWidget,
    this.validationWidgetBuilder,
    this.textDirection = TextDirection.ltr,
  }) : super.modalBottomSheet();

  PopupPropsMultiSelection.from(PopupProps<T> popupProps)
      : this._(
          title: popupProps.title,
          fit: popupProps.fit,
          favoriteItemProps: popupProps.favoriteItemProps,
          disabledItemFn: popupProps.disabledItemFn,
          emptyBuilder: popupProps.emptyBuilder,
          errorBuilder: popupProps.errorBuilder,
          isFilterOnline: popupProps.isFilterOnline,
          itemBuilder: popupProps.itemBuilder,
          listViewProps: popupProps.listViewProps,
          loadingBuilder: popupProps.loadingBuilder,
          modalBottomSheetProps: popupProps.modalBottomSheetProps,
          onDismissed: popupProps.onDismissed,
          scrollbarProps: popupProps.scrollbarProps,
          searchDelay: popupProps.searchDelay,
          searchFieldProps: popupProps.searchFieldProps,
          showSearchBox: popupProps.showSearchBox,
          showSelectedItems: popupProps.showSelectedItems,
          mode: popupProps.mode,
          //bottomSheetProps: popupProps.bottomSheetProps,
          dialogProps: popupProps.dialogProps,
          menuProps: popupProps.menuProps,
          containerBuilder: popupProps.containerBuilder,
          constraints: popupProps.constraints,
          interceptCallBacks: popupProps.interceptCallBacks,
          onItemAdded: null,
          onItemRemoved: null,
          selectionWidget: null,
          validationWidgetBuilder: null,
          textDirection: TextDirection.ltr,
        );
}
