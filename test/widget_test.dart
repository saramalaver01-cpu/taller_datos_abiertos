import 'package:flutter_test/flutter_test.dart';
import 'package:taller_datos_abiertos/main.dart';

void main() {
  testWidgets('La aplicación inicia correctamente', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ColombiaApp());

    expect(find.byType(ColombiaApp), findsOneWidget);
  });
}
