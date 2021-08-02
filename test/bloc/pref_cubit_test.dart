import 'package:bloc_test/bloc_test.dart';
import 'package:gastracker/bloc/pref_cubit.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockStorage extends Mock implements Storage {}

class MockPrefCubit extends MockCubit<PrefState> implements PrefCubit {}

void main() {
  late Storage storage;

  // https://github.com/felangel/bloc/blob/hydrated_bloc-v7.0.1/packages/hydrated_bloc/test/hydrated_cubit_test.dart
  setUp(() {
    storage = MockStorage();
    when(() => storage.write(any(), any<dynamic>())).thenAnswer((_) async {});
    when<dynamic>(() => storage.read(any())).thenReturn(<String, dynamic>{});
    when(() => storage.delete(any())).thenAnswer((_) async {});
    when(() => storage.clear()).thenAnswer((_) async {});
    HydratedBloc.storage = storage;
  });

  group('PrefCubit', () {
    group('Refresh Rate', () {
      blocTest<PrefCubit, PrefState>(
        'emits when reset',
        build: () => PrefCubit(),
        act: (cubit) => cubit.setRefreshRate(100),
        expect: () => [
          isA<PrefState>()
              .having((p) => p.refreshRate, 'refresh rate', equals(100))
        ],
      );
    });
  });
}
