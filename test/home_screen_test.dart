import 'package:flutter/material.dart';
import 'package:flutter_sudoku/screens/home_screen.dart';
import 'package:flutter_sudoku/widgets/main_button.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('HomeScreen has 3 buttons with titles Easy, Normal, and Hard', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreen(),
      ),
    );

    final easyButtonFinder = find.widgetWithText(MainButton, 'Easy');
    final normalButtonFinder = find.widgetWithText(MainButton, 'Normal');
    final hardButtonFinder = find.widgetWithText(MainButton, 'Hard');

    expect(easyButtonFinder, findsOneWidget);
    expect(normalButtonFinder, findsOneWidget);
    expect(hardButtonFinder, findsOneWidget);
  });
}
