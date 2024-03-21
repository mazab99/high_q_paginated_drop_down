
import 'package:flutter/material.dart';

class ValidatorProps<T>{
  final FormFieldValidator<List<T>>? validator;
  final AutovalidateMode? autoValidateMode;

  const ValidatorProps({
    this.validator,
    this.autoValidateMode= AutovalidateMode.disabled,
  });
}