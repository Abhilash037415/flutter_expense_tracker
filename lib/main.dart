import 'package:expense_tracker/widgets/expense_tracker.dart';
import 'package:flutter/material.dart';

var kcolorscheme = ColorScheme.fromSeed(seedColor: const Color(0xFF9C27B0));

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
        colorScheme: kcolorscheme,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kcolorscheme.primaryContainer,
          foregroundColor: kcolorscheme.onPrimaryContainer,
        ),
        cardTheme: CardThemeData().copyWith(
          color: kcolorscheme.secondaryContainer,
          margin: EdgeInsets.all(16),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: kcolorscheme.onSecondaryContainer,
            fontSize: 16,
          ),
        ),
      ),
      home: Expenses(),
    ),
  );
}
