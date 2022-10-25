import 'package:e_commerce_app/core/utils/constants/constants.dart';
import 'package:e_commerce_app/features/user/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:e_commerce_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group(
    "login end-to-end test",
    () {
      testWidgets('LoginButton is disabled when inputs are invalid.',
          (tester) async {
        app.main();

        await tester.pumpAndSettle();

        await tester.enterText(
            find.byKey(const ValueKey("emailInput_loginPage")),
            "joaoemail.com");

        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text(invalidEmailFailureMessage), findsOneWidget);

        await tester.enterText(
            find.byKey(const ValueKey("passwordInput_loginPage")), "12341234");

        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text(passwordHasNotLetterFailureMessage), findsOneWidget);

        final Finder loginButton =
            find.byKey(const ValueKey("loginButton_loginPage"));

        await tester.pump(const Duration(milliseconds: 100));

        expect(tester.widget<CustomButton>(loginButton).onPressed, isNull);
      });

      testWidgets('LoginButton is enabled when inputs are valid.',
          (tester) async {
        app.main();

        await tester.pumpAndSettle();

        await tester.enterText(
            find.byKey(const ValueKey("emailInput_loginPage")),
            "joao@email.com");

        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text(emptyFailureMessage), findsNothing);
        expect(find.text(invalidEmailFailureMessage), findsNothing);

        await tester.enterText(
            find.byKey(const ValueKey("passwordInput_loginPage")), "joao1234");

        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text(emptyFailureMessage), findsNothing);
        expect(find.text(passwordHasNotLetterFailureMessage), findsNothing);
        expect(find.text(passwordHasNotNumberFailureMessage), findsNothing);
        expect(find.text(passwordLengthFailureMessage), findsNothing);

        final Finder loginButton =
            find.byKey(const ValueKey("loginButton_loginPage"));

        expect(tester.widget<CustomButton>(loginButton).onPressed, isNotNull);
      });
    },
  );
}
