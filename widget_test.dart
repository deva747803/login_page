import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_login_page/main.dart'; // Pastikan path ini sesuai dengan struktur proyek Anda

void main() {
  testWidgets('Login page functionality test', (WidgetTester tester) async {
    // Build the login page and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify the presence of username and password fields, and login button.
    expect(find.byType(TextFormField), findsNWidgets(2)); // Username & Password fields
    expect(find.text('Login'), findsOneWidget); // Login button
    expect(find.text('Arya News'), findsOneWidget); // Application title

    // Enter correct username and password.
    await tester.enterText(find.byType(TextFormField).at(0), 'admin');
    await tester.enterText(find.byType(TextFormField).at(1), '1234');

    // Tap the login button.
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    // Verify successful navigation to HomePage.
    expect(find.text('Breaking News: Teknologi Masa Depan!'), findsOneWidget);
  });

  testWidgets('Invalid login test', (WidgetTester tester) async {
    // Build the login page and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Enter incorrect username and password.
    await tester.enterText(find.byType(TextFormField).at(0), 'wrongUser');
    await tester.enterText(find.byType(TextFormField).at(1), 'wrongPass');

    // Tap the login button.
    await tester.tap(find.text('Login'));
    await tester.pump();

    // Verify error message is displayed.
    expect(find.text('Username atau Password salah'), findsOneWidget);
  });

  testWidgets('Logout functionality test', (WidgetTester tester) async {
    // Build the app and log in.
    await tester.pumpWidget(MyApp());

    // Enter correct username and password.
    await tester.enterText(find.byType(TextFormField).at(0), 'admin');
    await tester.enterText(find.byType(TextFormField).at(1), '1234');

    // Tap the login button.
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    // Verify successful navigation to HomePage.
    expect(find.text('Breaking News: Teknologi Masa Depan!'), findsOneWidget);

    // Tap the logout button.
    await tester.tap(find.byIcon(Icons.logout));
    await tester.pumpAndSettle();

    // Verify navigation back to login page.
    expect(find.text('Arya News'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });
}
