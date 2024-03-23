import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../properties/popup_props.dart';
import '../utils/typedefs.dart';
import 'checkbox_widget.dart';

class SelectionWidget<T> extends StatefulWidget {
  final List<T> items;
  final ValueChanged<List<T>>? onChanged;
  final EdgeInsetsGeometry? confirmButtonPadding;
  final MultiSelectDropDownOnFind<T>? asyncItems;
  final MultiSelectDropDownItemAsString<T>? itemAsString;
  final MultiSelectDropDownFilterFn<T>? filterFn;
  final MultiSelectDropDownCompareFn<T>? compareFn;
  final List<T> defaultSelectedItems;
  final PopupPropsMultiSelection<T> popupProps;
  final String? confirmText;
  final void Function()? afterPopTheDialog;
  final ButtonStyle? confirmButtonStyle;
  final TextStyle? confirmTextTextStyle;

  const SelectionWidget({
    Key? key,
    required this.popupProps,
    this.defaultSelectedItems = const [],
    this.items = const [],
    this.onChanged,
    this.afterPopTheDialog,
    this.confirmButtonPadding = const EdgeInsets.symmetric(horizontal: 8),
    this.confirmTextTextStyle,
    this.asyncItems,
    this.confirmText,
    this.confirmButtonStyle,
    this.itemAsString,
    this.filterFn,
    this.compareFn,
  }) : super(key: key);

  @override
  SelectionWidgetState<T> createState() => SelectionWidgetState<T>();
}

class SelectionWidgetState<T> extends State<SelectionWidget<T>> {
  final StreamController<List<T>> _itemsStream = StreamController.broadcast();
  final ValueNotifier<bool> _loadingNotifier = ValueNotifier(false);
  final List<T> _cachedItems = [];
  final ValueNotifier<List<T>> _selectedItemsNotifier = ValueNotifier([]);
  final ScrollController scrollController = ScrollController();
  final List<T> _currentShowedItems = [];
  late TextEditingController searchBoxController;

  List<T> get _selectedItems => _selectedItemsNotifier.value;
  Timer? _debounce;

  void searchBoxControllerListener() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(widget.popupProps.searchDelay, () {
      if (widget.popupProps.textFieldOnChanged != null) {
        widget.popupProps.textFieldOnChanged!(searchBoxController.text);
      }
      _manageItemsByFilter(searchBoxController.text);
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedItemsNotifier.value = widget.defaultSelectedItems;
    searchBoxController = widget.popupProps.searchFieldProps.controller ??
        TextEditingController();
    searchBoxController.addListener(searchBoxControllerListener);
    Future.delayed(
      Duration.zero,
      () {
        return _manageItemsByFilter(
          searchBoxController.text,
          isFirstLoad: true,
        );
      },
    );
  }

  @override
  void didUpdateWidget(covariant SelectionWidget<T> oldWidget) {
    if (!listEquals(
        oldWidget.defaultSelectedItems, widget.defaultSelectedItems)) {
      _selectedItemsNotifier.value = widget.defaultSelectedItems;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _itemsStream.close();
    _debounce?.cancel();

    if (widget.popupProps.searchFieldProps.controller == null) {
      searchBoxController.dispose();
    } else {
      searchBoxController.removeListener(searchBoxControllerListener);
    }

    if (widget.popupProps.listViewProps.controller == null) {
      scrollController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: widget.popupProps.constraints,
      child: widget.popupProps.containerBuilder == null
          ? _defaultWidget()
          : widget.popupProps.containerBuilder!(context, _defaultWidget()),
    );
  }

  Widget _defaultWidget() {
    return ValueListenableBuilder(
      valueListenable: _selectedItemsNotifier,
      builder: (ctx, value, wdgt) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _searchField(),
            _favoriteItemsWidget(),
            Flexible(
              fit: widget.popupProps.fit,
              child: Stack(
                children: <Widget>[
                  StreamBuilder<List<T>>(
                    stream: _itemsStream.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return _errorWidget(snapshot.error);
                      } else if (!snapshot.hasData) {
                        return _loadingWidget();
                      } else if (snapshot.data!.isEmpty) {
                        return _noDataWidget();
                      }

                      return RawScrollbar(
                        controller:
                            widget.popupProps.listViewProps.controller ??
                                scrollController,
                        thumbVisibility:
                            widget.popupProps.scrollbarProps.thumbVisibility,
                        trackVisibility:
                            widget.popupProps.scrollbarProps.trackVisibility,
                        thickness: widget.popupProps.scrollbarProps.thickness,
                        radius: widget.popupProps.scrollbarProps.radius,
                        notificationPredicate: widget
                            .popupProps.scrollbarProps.notificationPredicate,
                        interactive:
                            widget.popupProps.scrollbarProps.interactive,
                        scrollbarOrientation: widget
                            .popupProps.scrollbarProps.scrollbarOrientation,
                        thumbColor: widget.popupProps.scrollbarProps.thumbColor,
                        fadeDuration:
                            widget.popupProps.scrollbarProps.fadeDuration,
                        crossAxisMargin:
                            widget.popupProps.scrollbarProps.crossAxisMargin,
                        mainAxisMargin:
                            widget.popupProps.scrollbarProps.mainAxisMargin,
                        minOverscrollLength: widget
                            .popupProps.scrollbarProps.minOverscrollLength,
                        minThumbLength:
                            widget.popupProps.scrollbarProps.minThumbLength,
                        pressDuration:
                            widget.popupProps.scrollbarProps.pressDuration,
                        shape: widget.popupProps.scrollbarProps.shape,
                        timeToFade: widget.popupProps.scrollbarProps.timeToFade,
                        trackBorderColor:
                            widget.popupProps.scrollbarProps.trackBorderColor,
                        trackColor: widget.popupProps.scrollbarProps.trackColor,
                        trackRadius:
                            widget.popupProps.scrollbarProps.trackRadius,
                        child: ListView.builder(
                          controller:
                              widget.popupProps.listViewProps.controller ??
                                  scrollController,
                          shrinkWrap:
                              widget.popupProps.listViewProps.shrinkWrap,
                          padding: widget.popupProps.listViewProps.padding,
                          scrollDirection:
                              widget.popupProps.listViewProps.scrollDirection,
                          reverse: widget.popupProps.listViewProps.reverse,
                          primary: widget.popupProps.listViewProps.primary,
                          physics: widget.popupProps.listViewProps.physics,
                          itemExtent:
                              widget.popupProps.listViewProps.itemExtent,
                          addAutomaticKeepAlives: widget
                              .popupProps.listViewProps.addAutomaticKeepAlives,
                          addRepaintBoundaries: widget
                              .popupProps.listViewProps.addRepaintBoundaries,
                          addSemanticIndexes: widget
                              .popupProps.listViewProps.addSemanticIndexes,
                          cacheExtent:
                              widget.popupProps.listViewProps.cacheExtent,
                          semanticChildCount: widget
                              .popupProps.listViewProps.semanticChildCount,
                          dragStartBehavior:
                              widget.popupProps.listViewProps.dragStartBehavior,
                          keyboardDismissBehavior: widget
                              .popupProps.listViewProps.keyboardDismissBehavior,
                          restorationId:
                              widget.popupProps.listViewProps.restorationId,
                          clipBehavior:
                              widget.popupProps.listViewProps.clipBehavior,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var item = snapshot.data![index];
                            return _itemWidgetMultiSelection(item);
                          },
                        ),
                      );
                    },
                  ),
                  _loadingWidget()
                ],
              ),
            ),
            _confirmButton(),
          ],
        );
      },
    );
  }

  void onValidate() {
    closePopup();
    if (widget.onChanged != null) widget.onChanged!(_selectedItems);
  }

  void closePopup() => Navigator.pop(context);

  Widget _confirmButton() {
    Widget defaultConfirmButton = Padding(
      padding: widget.confirmButtonPadding ??
          const EdgeInsets.symmetric(horizontal: 8),
      child: Align(
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: () {
            onValidate();
            if (widget.afterPopTheDialog != null) {
              widget.afterPopTheDialog!();
            }
          },
          style: widget.confirmButtonStyle,
          child: Text(
            widget.confirmText != null ? widget.confirmText! : "OK",
            style: widget.confirmTextTextStyle,
          ),
        ),
      ),
    );

    if (widget.popupProps.validationWidgetBuilder != null) {
      return widget.popupProps.validationWidgetBuilder!(
        context,
        _selectedItems,
      );
    }

    return defaultConfirmButton;
  }

  void _showErrorDialog(dynamic error) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error while getting online items"),
          content: _errorWidget(error),
          actions: <Widget>[
            TextButton(
              child: Text(
                widget.confirmText != null ? widget.confirmText! : "OK",
                style: widget.confirmTextTextStyle,
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            )
          ],
        );
      },
    );
  }

  Widget _noDataWidget() {
    if (widget.popupProps.emptyBuilder != null) {
      return widget.popupProps.emptyBuilder!(
        context,
        searchBoxController.text,
      );
    } else {
      return Container(
        height: 70,
        alignment: Alignment.center,
        child: Text("No data found"),
      );
    }
  }

  Widget _errorWidget(dynamic error) {
    if (widget.popupProps.errorBuilder != null) {
      return widget.popupProps.errorBuilder!(
        context,
        searchBoxController.text,
        error,
      );
    } else {
      return Container(
        alignment: Alignment.center,
        child: Text(
          error?.toString() ?? 'Unknown Error',
        ),
      );
    }
  }

  Widget _loadingWidget() {
    return ValueListenableBuilder(
        valueListenable: _loadingNotifier,
        builder: (context, bool isLoading, wid) {
          if (isLoading) {
            if (widget.popupProps.loadingBuilder != null) {
              return widget.popupProps.loadingBuilder!(
                context,
                searchBoxController.text,
              );
            } else {
              return Container(
                height: 70,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              );
            }
          }
          return const SizedBox.shrink();
        });
  }

  Future<void> _manageItemsByFilter(
    String filter, {
    bool isFirstLoad = false,
  }) async {
    _loadingNotifier.value = true;

    List<T> applyFilter(String filter) {
      return _cachedItems.where((i) {
        if (widget.filterFn != null) {
          return (widget.filterFn!(i, filter));
        } else if (i.toString().toLowerCase().contains(filter.toLowerCase())) {
          return true;
        } else if (widget.itemAsString != null) {
          return (widget.itemAsString!(i)).toLowerCase().contains(
                filter.toLowerCase(),
              );
        }
        return false;
      }).toList();
    }

    if (isFirstLoad) _cachedItems.addAll(widget.items);
    if (widget.asyncItems != null &&
        (widget.popupProps.isFilterOnline || isFirstLoad)) {
      try {
        final List<T> onlineItems = [];
        onlineItems.addAll(await widget.asyncItems!(filter));
        _cachedItems.clear();
        _cachedItems.addAll(widget.items);
        if (widget.popupProps.isFilterOnline == true) {
          var filteredLocalList = applyFilter(filter);
          _cachedItems.clear();
          _cachedItems.addAll(filteredLocalList);
        }
        _cachedItems.addAll(onlineItems);
        if (widget.popupProps.isFilterOnline == true) {
          _addDataToStream(_cachedItems);
        } else {
          _addDataToStream(applyFilter(filter));
        }
      } catch (e) {
        _addErrorToStream(e);
        if (widget.items.isNotEmpty) {
          _showErrorDialog(e);
          _addDataToStream(applyFilter(filter));
        }
      }
    } else {
      _addDataToStream(applyFilter(filter));
    }

    _loadingNotifier.value = false;
  }

  void _addDataToStream(List<T> data) {
    if (_itemsStream.isClosed) return;
    _itemsStream.add(data);
    _currentShowedItems.clear();
    _currentShowedItems.addAll(data);
  }

  void _addErrorToStream(Object error, [StackTrace? stackTrace]) {
    if (_itemsStream.isClosed) return;
    _itemsStream.addError(error, stackTrace);
  }

  Widget _itemWidgetSingleSelection(T item) {
    if (widget.popupProps.itemBuilder != null) {
      var w = widget.popupProps.itemBuilder!(
        context,
        item,
        !widget.popupProps.showSelectedItems ? false : _isSelectedItem(item),
      );

      if (widget.popupProps.interceptCallBacks) {
        return w;
      } else {
        return InkWell(
          // ignore pointers in itemBuilder
          child: IgnorePointer(child: w),
          onTap: _isDisabled(item) ? null : () => _handleSelectedItem(item),
        );
      }
    } else {
      return ListTile(
        enabled: !_isDisabled(item),
        title: Text(_selectedItemAsString(item)),
        selected: !widget.popupProps.showSelectedItems
            ? false
            : _isSelectedItem(item),
        onTap: _isDisabled(item) ? null : () => _handleSelectedItem(item),
      );
    }
  }

  Widget _itemWidgetMultiSelection(T item) {
    if (widget.popupProps.selectionWidget != null) {
      return CheckBoxWidget(
        checkBox: (cnt, checked) {
          return widget.popupProps.selectionWidget!(context, item, checked);
        },
        interceptCallBacks: widget.popupProps.interceptCallBacks,
        textDirection: widget.popupProps.textDirection,
        layout: (context, isChecked) => _itemWidgetSingleSelection(item),
        isChecked: _isSelectedItem(item),
        isDisabled: _isDisabled(item),
        onChanged: (c) => _handleSelectedItem(item),
      );
    } else {
      return CheckBoxWidget(
        textDirection: widget.popupProps.textDirection,
        interceptCallBacks: widget.popupProps.interceptCallBacks,
        layout: (context, isChecked) => _itemWidgetSingleSelection(item),
        isChecked: _isSelectedItem(item),
        isDisabled: _isDisabled(item),
        onChanged: (c) => _handleSelectedItem(item),
      );
    }
  }

  bool _isDisabled(T item) =>
      widget.popupProps.disabledItemFn != null &&
      (widget.popupProps.disabledItemFn!(item)) == true;

  /// selected item will be highlighted only when [widget.showSelectedItems] is true,
  /// if our object is String [widget.compareFn] is not required , other wises it's required
  bool _isSelectedItem(T item) {
    return _itemIndexInList(_selectedItems, item) > -1;
  }

  ///test if list has an item T
  ///if contains return index of item in the list, -1 otherwise
  int _itemIndexInList(List<T> list, T item) {
    return list.indexWhere((i) => _isEqual(i, item));
  }

  ///compared two items base on user params
  bool _isEqual(T i1, T i2) {
    if (widget.compareFn != null) {
      return widget.compareFn!(i1, i2);
    } else {
      return i1 == i2;
    }
  }

  Widget _searchField() {
    var searchFieldProps = widget.popupProps.searchFieldProps;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        widget.popupProps.title ?? const SizedBox.shrink(),
        if (widget.popupProps.showSearchBox)
          Padding(
            padding: widget.popupProps.searchFieldProps.padding,
            child: DefaultTextEditingShortcuts(
              child: Shortcuts(
                shortcuts: const <ShortcutActivator, Intent>{
                  SingleActivator(LogicalKeyboardKey.space):
                      DoNothingAndStopPropagationTextIntent(),
                },
                child: TextFormField(
                  onChanged: widget.popupProps.textFieldOnChanged,
                  enableIMEPersonalizedLearning:
                      searchFieldProps.enableIMEPersonalizedLearning,
                  clipBehavior: searchFieldProps.clipBehavior,
                  style: searchFieldProps.style,
                  controller: searchBoxController,
                  focusNode: searchFieldProps.focusNode,
                  autofocus: searchFieldProps.autofocus,
                  decoration: searchFieldProps.decoration,
                  keyboardType: searchFieldProps.keyboardType,
                  textInputAction: searchFieldProps.textInputAction,
                  textCapitalization: searchFieldProps.textCapitalization,
                  strutStyle: searchFieldProps.strutStyle,
                  textAlign: searchFieldProps.textAlign,
                  textAlignVertical: searchFieldProps.textAlignVertical,
                  textDirection: searchFieldProps.textDirection,
                  readOnly: searchFieldProps.readOnly,
                  contextMenuBuilder: searchFieldProps.contextMenuBuilder,
                  showCursor: searchFieldProps.showCursor,
                  obscuringCharacter: searchFieldProps.obscuringCharacter,
                  obscureText: searchFieldProps.obscureText,
                  autocorrect: searchFieldProps.autocorrect,
                  smartDashesType: searchFieldProps.smartDashesType,
                  smartQuotesType: searchFieldProps.smartQuotesType,
                  enableSuggestions: searchFieldProps.enableSuggestions,
                  maxLines: searchFieldProps.maxLines,
                  minLines: searchFieldProps.minLines,
                  expands: searchFieldProps.expands,
                  maxLengthEnforcement: searchFieldProps.maxLengthEnforcement,
                  maxLength: searchFieldProps.maxLength,
                  onAppPrivateCommand: searchFieldProps.onAppPrivateCommand,
                  inputFormatters: searchFieldProps.inputFormatters,
                  enabled: searchFieldProps.enabled,
                  cursorWidth: searchFieldProps.cursorWidth,
                  cursorHeight: searchFieldProps.cursorHeight,
                  cursorRadius: searchFieldProps.cursorRadius,
                  cursorColor: searchFieldProps.cursorColor,
                  selectionHeightStyle: searchFieldProps.selectionHeightStyle,
                  selectionWidthStyle: searchFieldProps.selectionWidthStyle,
                  keyboardAppearance: searchFieldProps.keyboardAppearance,
                  scrollPadding: searchFieldProps.scrollPadding,
                  dragStartBehavior: searchFieldProps.dragStartBehavior,
                  enableInteractiveSelection: widget
                      .popupProps.searchFieldProps.enableInteractiveSelection,
                  selectionControls: searchFieldProps.selectionControls,
                  onTap: searchFieldProps.onTap,
                  mouseCursor: searchFieldProps.mouseCursor,
                  buildCounter: searchFieldProps.buildCounter,
                  scrollController: searchFieldProps.scrollController,
                  scrollPhysics: searchFieldProps.scrollPhysics,
                  autofillHints: searchFieldProps.autofillHints,
                  restorationId: searchFieldProps.restorationId,
                ),
              ),
            ),
          )
      ],
    );
  }

  Widget _favoriteItemsWidget() {
    if (widget.popupProps.favoriteItemProps.showFavoriteItems &&
        widget.popupProps.favoriteItemProps.favoriteItems != null) {
      return StreamBuilder<List<T>>(
          stream: _itemsStream.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _buildFavoriteItems(widget
                  .popupProps.favoriteItemProps.favoriteItems!(snapshot.data!));
            } else {
              return Container();
            }
          });
    }

    return Container();
  }

  Widget _buildFavoriteItems(List<T> favoriteItems) {
    if (favoriteItems.isEmpty) return Container();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          var favoriteItemProps = widget.popupProps.favoriteItemProps;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: constraints.maxWidth),
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: favoriteItemProps.favoriteItemsAlignment,
                  children: favoriteItems.map(
                    (f) {
                      return InkWell(
                        onTap: () {
                          _handleSelectedItem(f);
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 4),
                          child: favoriteItemProps.favoriteItemBuilder != null
                              ? favoriteItemProps.favoriteItemBuilder!(
                                  context,
                                  f,
                                  _isSelectedItem(f),
                                )
                              : _favoriteItemDefaultWidget(f),
                        ),
                      );
                    },
                  ).toList()),
            ),
          );
        },
      ),
    );
  }

  void _handleSelectedItem(T newSelectedItem) {
    var popupProps = widget.popupProps;
    if (_isSelectedItem(newSelectedItem)) {
      _selectedItemsNotifier.value = List.from(_selectedItems)
        ..removeWhere(
          (i) {
            return _isEqual(newSelectedItem, i);
          },
        );
      if (popupProps.onItemRemoved != null) {
        popupProps.onItemRemoved!(_selectedItems, newSelectedItem);
      }
    } else {
      _selectedItemsNotifier.value = List.from(_selectedItems)
        ..add(newSelectedItem);
      if (popupProps.onItemAdded != null) {
        popupProps.onItemAdded!(_selectedItems, newSelectedItem);
      }
    }
  }

  Widget _favoriteItemDefaultWidget(T item) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColorLight),
      child: Row(
        children: [
          Text(
            _selectedItemAsString(item),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Padding(padding: EdgeInsets.only(left: 8)),
          Visibility(
            child: Icon(Icons.check_box_outlined),
            visible: _isSelectedItem(item),
          )
        ],
      ),
    );
  }

  String _selectedItemAsString(T data) {
    if (data == null) {
      return "";
    } else if (widget.itemAsString != null) {
      return widget.itemAsString!(data);
    } else {
      return data.toString();
    }
  }

  void selectItems(List<T> itemsToSelect) {
    var popupProps = widget.popupProps;
    List<T> newSelectedItems = _selectedItems;
    for (var i in itemsToSelect) {
      if (!_isSelectedItem(i) /*check if the item is already selected*/ &&
          !_isDisabled(i) /*escape disabled items*/) {
        newSelectedItems.add(i);
        if (popupProps.onItemAdded != null) {
          popupProps.onItemAdded!(_selectedItems, i);
        }
      }
    }
    _selectedItemsNotifier.value = List.from(newSelectedItems);
  }

  void selectAllItems() {
    selectItems(_currentShowedItems);
  }

  void deselectItems(List<T> itemsToDeselect) {
    var popupProps = widget.popupProps;
    List<T> newSelectedItems = _selectedItems;
    for (var i in itemsToDeselect) {
      var index = _itemIndexInList(newSelectedItems, i);
      if (index > -1) /*check if the item is already selected*/ {
        newSelectedItems.removeAt(index);
        if (popupProps.onItemRemoved != null) {
          popupProps.onItemRemoved!(_selectedItems, i);
        }
      }
    }
    _selectedItemsNotifier.value = List.from(newSelectedItems);
  }

  void deselectAllItems() {
    deselectItems(_cachedItems);
  }

  bool get isAllItemSelected {
    return _selectedItems.length >= _currentShowedItems.length;
  }

  List<T> get getSelectedItem => List.from(_selectedItems);
}
