import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension ValueListenableExtensions<T> on ValueListenable<T> {
  ValueListenableBuilder<T> observer({required Builder<T> builder}) {
    return ValueListenableBuilder(
      valueListenable: this,
      builder: (context, T value, widget) {
        return builder(context, value, widget);
      },
    );
  }
}

extension ValueNotifierExtensions<T> on ValueNotifier<T> {
  void setValue(T value) {
    this.value = value;
  }
}

typedef Builder<T> = Widget Function(BuildContext context, T value, Widget? widget);
