import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'layout_provider.g.dart';

enum LayoutType { mobile, tablet, web }

@riverpod
LayoutType layout(LayoutRef ref, BuildContext context) {
  var screenWidth = MediaQuery.of(context).size.width;
  return switch (screenWidth) {
    > 600 => LayoutType.tablet,
    > 1119 => LayoutType.web,
    _ => LayoutType.mobile,
  };
}
