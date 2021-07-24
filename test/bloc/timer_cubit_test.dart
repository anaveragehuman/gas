import 'package:bloc_test/bloc_test.dart';
import 'package:gastracker/bloc/timer_cubit.dart';
import 'package:test/test.dart';

void main() {
  group('ticker', () {
    test('produces exactly requested number of values',
        () async => expect(await ticker(ticks: 3).length, equals(3)));
  });

  group('TimerCubit', () {
    test('has initial value of seconds passed in',
        () => expect(TimerCubit(5).state, equals(5)));

    blocTest<TimerCubit, int>(
      'reset returns to initial value',
      build: () => TimerCubit(5),
      act: (cubit) {
        cubit.start();
        Future.delayed(const Duration(milliseconds: 2100), cubit.reset);
      },
      expect: () => [4, 3, 5, 4],
      wait: const Duration(seconds: 3),
    );

    blocTest<TimerCubit, int>(
      'produces values when started',
      build: () => TimerCubit(5),
      act: (cubit) => cubit.start(),
      expect: () => [4, 3],
      wait: const Duration(seconds: 2),
    );

    blocTest<TimerCubit, int>(
      "doesn't produce values when stopped",
      build: () => TimerCubit(5),
      act: (cubit) {
        cubit.start();
        Future.delayed(const Duration(milliseconds: 1100), cubit.stop);
      },
      expect: () => [4],
      wait: const Duration(seconds: 4),
    );

    blocTest<TimerCubit, int>(
      'continues when starting after stopped',
      build: () => TimerCubit(5),
      act: (cubit) {
        cubit.start();
        Future.delayed(const Duration(milliseconds: 1100), cubit.stop);
        Future.delayed(const Duration(milliseconds: 1100), cubit.start);
      },
      expect: () => [4, 3, 2],
      wait: const Duration(seconds: 4),
    );
  });
}
