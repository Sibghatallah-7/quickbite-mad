import 'package:flutter_test/flutter_test.dart';
import 'package:admin_app/main.dart';

void main() {
  testWidgets('Admin App loads login screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const QuickBiteAdminApp());

    // Verify that admin login header and button exist.
    expect(find.text('QuickBite Admin'), findsOneWidget);
    expect(find.text('LOGIN'), findsOneWidget);
  });
}
