import 'package:expenses_app/widgets/expenses.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 190, 0, 0));

var kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 168, 1, 1));

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
  //   (fn) =>
  runApp(MaterialApp(
    //Dark Theme
    darkTheme: ThemeData.dark().copyWith(
      colorScheme: kDarkColorScheme,
      useMaterial3: true,
      cardTheme: const CardTheme().copyWith(
        color: kDarkColorScheme.secondaryContainer,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
            backgroundColor: kDarkColorScheme.primaryContainer),
      ),
    ),
    //LightTheme
    theme: ThemeData().copyWith(
        cardTheme: const CardTheme().copyWith(
            color: kColorScheme.primaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kColorScheme.primaryContainer)),
        textTheme: ThemeData().textTheme.copyWith(
            titleLarge: const TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.bold))),
    home: Expenses(),
  ));
  // );
}
