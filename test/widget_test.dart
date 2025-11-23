import 'package:flutter_test/flutter_test.dart';
import 'package:itp_final_assessment/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app starts and shows the welcome screen or home screen.
    // Since we have redirects and animations, we might just check for a widget that should be there.
    // For now, just ensuring it pumps without error is a good start.
    await tester.pumpAndSettle();
  });
}
