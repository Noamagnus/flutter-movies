import 'package:flutter/material.dart';

import 'package:flex_color_scheme/flex_color_scheme.dart';

final ThemeData lightTheme = FlexThemeData.light(
  scheme: FlexScheme.deepBlue,
  surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
  blendLevel: 9,
  appBarStyle: FlexAppBarStyle.material,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 10,
    blendOnColors: true,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  //textTheme: customTextTheme, // Use the custom TextTheme
);

final ThemeData darkTheme = FlexThemeData.dark(
  scheme: FlexScheme.deepBlue,
  surfaceMode: FlexSurfaceMode.highScaffoldLowSurfaces,
  blendLevel: 15,
  appBarStyle: FlexAppBarStyle.material,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 20,
    blendOnColors: true,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  //textTheme: customTextTheme, // Use the custom TextTheme
);

// final TextTheme customTextTheme = TextTheme(
//   headline1: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
//   headline2: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: Colors.black),
//   bodyText1: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black87),
//   bodyText2: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black54),
//   caption: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey),
// );
