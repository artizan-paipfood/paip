import 'package:core/src/entities/establishment_plan_entity.dart';
import 'package:test/test.dart';

void main() {
  group(
    'EstablishmentPlanEntity.buildAmount()',
    () {
      final basePlan = EstablishmentPlanEntity(price: 100, id: '1', establishmentId: '', billingDay: 10, planId: '');

      test('Se o valor fixo for != null, deve retornar o valor fixo', () {
        final plan = basePlan.copyWith(
          fixedPrice: 50,
          discount: 20,
          promotionalPrice: 40,
        );

        expect(plan.buildAmount(), equals(50));
      });

      test('Se o valor promocional for != null e a data de validade não tiver passado, deve retornar o valor promocional', () {
        final plan = basePlan.copyWith(
          promotionalPrice: 60,
          promotionalPriceValidUntil: DateTime.now().add(
            Duration(days: 1),
          ),
        );

        expect(plan.buildAmount(), equals(60));
      });

      test('Se o valor promocional for != null e a data de validade tiver passado, deve retornar o valor base', () {
        final plan = basePlan.copyWith(
          price: 100,
          promotionalPrice: 60,
          promotionalPriceValidUntil: DateTime.now().subtract(
            Duration(days: 1),
          ),
        );

        expect(plan.buildAmount(), equals(100));
      });

      test('Se o desconto for != null, deve retornar o valor base menos o desconto', () {
        final plan = basePlan.copyWith(
          price: 100,
          discount: 25,
        );

        expect(plan.buildAmount(), equals(75));
      });

      test('Se o valor base for 0, deve retornar 0', () {
        final plan = basePlan.copyWith(
          price: 0,
          discount: 0,
        );

        expect(plan.buildAmount(), equals(0));
      });
    },
  );
}
