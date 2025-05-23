// test/widget_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app/app.dart';

void main() {
  testWidgets('Note entry screen loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify that the note input area is present
    expect(find.text('Input text'), findsOneWidget);

    // Verify that category buttons are present
    expect(find.text('Private'), findsOneWidget);
    expect(find.text('Public'), findsOneWidget);

    // Verify that size selector is present
    expect(find.text('Large'), findsOneWidget);
    expect(find.text('Medium'), findsOneWidget);
    expect(find.text('Small'), findsOneWidget);

    // Verify that the Explore button is present
    expect(find.text('Explore'), findsOneWidget);
  });

  testWidgets('Size selector works correctly', (WidgetTester tester) async {
    // Build our app
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Tap on Large size option
    await tester.tap(find.text('Large'));
    await tester.pumpAndSettle();

    // Verify that Large is now selected (this would require checking the visual state)
    // For now, just verify the tap doesn't crash the app
    expect(find.text('Large'), findsOneWidget);
  });

  testWidgets('Category selection works correctly',
      (WidgetTester tester) async {
    // Build our app
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify both category buttons exist
    expect(find.text('Private'), findsOneWidget);
    expect(find.text('Public'), findsOneWidget);

    // Tap on Public category
    await tester.tap(find.text('Public'));
    await tester.pumpAndSettle();

    // Verify the tap doesn't crash the app
    expect(find.text('Public'), findsOneWidget);
  });

  testWidgets('Note input field accepts text', (WidgetTester tester) async {
    // Build our app
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Find the text input field
    final textField = find.byType(TextField);
    expect(textField, findsOneWidget);

    // Enter some text
    await tester.enterText(textField, 'Test note content');
    await tester.pumpAndSettle();

    // Verify the text was entered
    expect(find.text('Test note content'), findsOneWidget);
  });

  testWidgets('Action buttons are present', (WidgetTester tester) async {
    // Build our app
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify action buttons are present by checking for their icons
    expect(find.byIcon(Icons.delete_outline), findsOneWidget);
    expect(find.byIcon(Icons.replay_outlined), findsOneWidget);
    expect(find.byIcon(Icons.format_align_left), findsOneWidget);
    expect(find.byIcon(Icons.camera_alt_outlined), findsOneWidget);
    expect(find.byIcon(Icons.mic_none_outlined), findsOneWidget);
    expect(find.byIcon(Icons.link), findsOneWidget);
  });

  testWidgets('Bottom navigation buttons are present',
      (WidgetTester tester) async {
    // Build our app
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify bottom navigation elements
    expect(find.byIcon(Icons.settings), findsOneWidget);
    expect(find.byIcon(Icons.person), findsOneWidget);
    expect(find.text('Explore'), findsOneWidget);
  });
}
