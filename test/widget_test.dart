//import 'package:flutter/material.dart';
import 'package:dummy/main.dart';
import 'package:flutter_test/flutter_test.dart';
 // Import the main.dart file

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build your app and trigger a frame.
    await tester.pumpWidget(const CalorieTrackerApp());

    // Verify that the "Welcome User!!!" text is displayed.
    expect(find.text('Welcome User!!!'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the 'Start Tracking' button and trigger a frame.
    await tester.tap(find.text('Start Tracking'));
    await tester.pump();

    // Verify that the SelectionScreen is displayed after tapping.
    expect(find.text('Start Tracking'), findsNothing);
    // Add more tests as needed
  });
}