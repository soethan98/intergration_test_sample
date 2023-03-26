import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_test_sample/home_screen.dart';
import 'package:integration_test_sample/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end to end test', () {
    testWidgets('verify login screen with correct username and password',
        (tester) async {
      app.main();
      await tester.pumpAndSettle();
      final userNameField = find.byType(TextFormField).at(0);
      expect(userNameField, findsOneWidget);
      await tester.enterText(userNameField, 'username');
      final passwordField = find.byType(TextFormField).at(1);
      expect(passwordField, findsOneWidget);
      await tester.enterText(passwordField, 'password');
      final loginBtn = find.byType(ElevatedButton);

      await tester.tap(loginBtn);
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('verify login screen with incorrect username and password',
        (tester) async {
      app.main();
      await tester.pumpAndSettle();
      final userNameField = find.byType(TextFormField).at(0);
      expect(userNameField, findsOneWidget);
      await tester.enterText(userNameField, 'root');
      final passwordField = find.byType(TextFormField).at(1);
      expect(passwordField, findsOneWidget);
      await tester.enterText(passwordField, 'password');
      final loginBtn = find.byType(ElevatedButton);

      await tester.tap(loginBtn);
      await tester.pumpAndSettle();
      expect(find.text('Invalid username or password'), findsOneWidget);
    });
  });
}
