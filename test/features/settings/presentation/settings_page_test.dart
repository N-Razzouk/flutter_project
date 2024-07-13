import 'package:ed/features/settings/presentation/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test settings page displays widgets correctly.', () {
    testWidgets('Test if the settings page has Scaffold.',
        (WidgetTester tester) async {
      /// Arrange
      await tester.pumpWidget(_TestWidget());

      /// Assert
      expect(find.byType(Scaffold), findsOneWidget);
    });

    /// Finds one AppBar
    testWidgets('Test if the settings page has AppBar.',
        (WidgetTester tester) async {
      /// Arrange
      await tester.pumpWidget(_TestWidget());

      /// Assert
      expect(find.byType(AppBar), findsOneWidget);
    });

    /// Test Authorized row
    testWidgets('Test if the settings page has Authorized row.',
        (WidgetTester tester) async {
      /// Arrange
      await tester.pumpWidget(_TestWidget());

      /// Assert
      expect(find.text('Authorized'), findsOneWidget);
      expect(find.byType(Switch), findsOneWidget);
    });

    /// Test Enter the amount you want to deposit
    testWidgets(
        'Test if the settings page has Enter the amount you want to deposit.',
        (WidgetTester tester) async {
      /// Arrange
      await tester.pumpWidget(_TestWidget());

      /// Assert
      expect(
          find.text('Enter the amount you want to deposit:'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });

    /// Test Deposit button
    testWidgets('Test if the settings page has Deposit button.',
        (WidgetTester tester) async {
      /// Arrange
      await tester.pumpWidget(_TestWidget());

      /// Assert
      expect(find.text('Deposit'), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
    });
  });
}

class _TestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SettingsPage(),
    );
  }
}
