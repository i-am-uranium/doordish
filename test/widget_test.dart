import 'package:flutter_test/flutter_test.dart';

import 'package:doordish/main.dart';

void main() {
  testWidgets('shows the Doordish app shell', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Doordish'), findsWidgets);
  });
}
