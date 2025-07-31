import 'package:core/core.dart';
import 'package:test/test.dart';

void main() {
  late EstablishmentInvoiceEntity baseEntity;
  const String testEstablishmentInvoiceId = 'est_invoice_id';
  const String testEstablishmentId = 'est_id';
  const String testEstablishmentPlanId = 'est_plan_id';
  setUp(
    () {
      baseEntity = EstablishmentInvoiceEntity(
        id: testEstablishmentInvoiceId,
        establishmentId: testEstablishmentId,
        establishmentPlanId: testEstablishmentPlanId,
        createdAt: DateTime.now(),
        dueDate: DateTime.now(),
        amount: 100,
        paymentType: PaymentType.pix,
      );
    },
  );

  group(
    'establishment invoice entity ...',
    () {
      test('Verifica se o mes da cobranca é igual ao mes atual', () {
        final entityPlusOneMounth = baseEntity.copyWith(
            dueDate: DateTime.now().add(
          const Duration(
            days: 30,
          ),
        ));
        expect(baseEntity.isCurrentMounth, true);
        expect(entityPlusOneMounth.isCurrentMounth, false);
      });

      test(
        'Se o paymentDate for != de null está pago',
        () {
          final entityPaid = baseEntity.copyWith(paymentDate: DateTime.now());
          expect(entityPaid.isPaid, true);
          expect(entityPaid.isNotPaid, false);

          final entityIsNotPaid = baseEntity;
          expect(entityIsNotPaid.isPaid, false);
          expect(entityIsNotPaid.isNotPaid, true);
        },
      );

      test(
        'Se passar 5 dias apos o vencimento isBlocked tem que retornar como true',
        () {
          final now = DateTime.now();
          final entityDay10 = baseEntity.copyWith(
              dueDate: now.copyWith(
            day: 10,
          ));
          final day1 = now.copyWith(day: 1);
          final day10 = now.copyWith(day: 10);
          final day11 = now.copyWith(day: 11);
          final day12 = now.copyWith(day: 12);
          final day15 = now.copyWith(day: 15);
          final day16 = now.copyWith(day: 16);
          final day20 = now.copyWith(day: 20);

          expect(entityDay10.isBlocked(day1), false);
          expect(entityDay10.isNotBlocked(day1), true);

          expect(entityDay10.isBlocked(day10), false);
          expect(entityDay10.isBlocked(day11), false);
          expect(entityDay10.isBlocked(day12), false);

          expect(entityDay10.isBlocked(day15), true);
          expect(entityDay10.isNotBlocked(day15), false);

          expect(entityDay10.isBlocked(day16), true);
          expect(entityDay10.isBlocked(day20), true);
        },
      );

      test('Deve trazer a quantidade de dias vencidos, se não estiver vencido retornar 0', () {
        final now = DateTime.now();
        final entityDay10 = baseEntity.copyWith(
            dueDate: now.copyWith(
          day: 10,
        ));
        final day9 = now.copyWith(day: 9);
        final day10 = now.copyWith(day: 10);
        final day11 = now.copyWith(day: 11);
        final day15 = now.copyWith(day: 15);

        expect(entityDay10.daysOverdue(day9), 0);
        expect(entityDay10.daysOverdue(day10), 0);
        expect(entityDay10.daysOverdue(day11), 1);
        expect(entityDay10.daysOverdue(day15), 5);
      });

      test(
        'Deve trazer a quantidade de dias que faltam para vencer se estiver vencido retornar 0',
        () {
          final now = DateTime.now();
          final entityDay10 = baseEntity.copyWith(
              dueDate: now.copyWith(
            day: 10,
          ));
          final day9 = now.copyWith(day: 9);
          final day10 = now.copyWith(day: 10);
          final day8 = now.copyWith(day: 8);
          final day3 = now.copyWith(day: 3);

          expect(entityDay10.daysUntilDue(day9), 1);
          expect(entityDay10.daysUntilDue(day10), 0);
          expect(entityDay10.daysUntilDue(day8), 2);
          expect(entityDay10.daysUntilDue(day3), 7);
        },
      );
      test(
        'Deve trazer a quantidade de dias para efetuar o bloqueio',
        () {
          final now = DateTime.now();
          final entityDay10 = baseEntity.copyWith(
              dueDate: now.copyWith(
            day: 10,
          ));
          final day9 = now.copyWith(day: 9);
          final day10 = now.copyWith(day: 10);
          final day11 = now.copyWith(day: 11);
          final day12 = now.copyWith(day: 12);
          final day13 = now.copyWith(day: 13);
          final day14 = now.copyWith(day: 14);
          final day15 = now.copyWith(day: 15);
          final day16 = now.copyWith(day: 16);

          expect(entityDay10.daysUntilBlock(day9), null);
          expect(entityDay10.daysUntilBlock(day10), 5);
          expect(entityDay10.daysUntilBlock(day11), 4);
          expect(entityDay10.daysUntilBlock(day12), 3);
          expect(entityDay10.daysUntilBlock(day13), 2);
          expect(entityDay10.daysUntilBlock(day14), 1);
          expect(entityDay10.daysUntilBlock(day15), 0);
          expect(entityDay10.daysUntilBlock(day16), 0);
        },
      );
    },
  );
}
