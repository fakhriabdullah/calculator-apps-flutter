import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calculator_apps/main.dart';

void main() {
  testWidgets('Calculator test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify widget exist
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.byType(GridView), findsOneWidget);
  });
}
