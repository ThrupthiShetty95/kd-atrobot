import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:Atrobot/main.dart';

void main() {
  testWidgets('App starts with ProviderScope and AtRobotApp', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: AtRobotApp()));
    await tester.pumpAndSettle();
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
