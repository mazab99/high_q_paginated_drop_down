import 'package:flutter/material.dart';
import '../utils/typedefs.dart';

class MethodLogicProps<T>{
  final ValueChanged<List<T>>? onChanged;
  final FormFieldSetter<List<T>>? onSaved;

  ///a callBack will be called before opening le popup
  ///if the callBack return FALSE, the opening of the popup will be cancelled
  final BeforeChangeMultiSelection<T>? onBeforeChange;
  ///a callBack will be called before opening le popup
  ///if the callBack return FALSE, the opening of the popup will be cancelled
  final BeforePopupOpeningMultiSelection<T>? onBeforePopupOpening;

  const MethodLogicProps({
    this.onChanged,
    this.onSaved,

    this.onBeforeChange,
    this.onBeforePopupOpening,
  });
}