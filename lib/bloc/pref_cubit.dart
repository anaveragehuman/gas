import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'pref_cubit.freezed.dart';
part 'pref_cubit.g.dart';

@freezed
@immutable
class PrefState with _$PrefState {
  /// How often to poll for new data, in seconds.
  const factory PrefState({
    @Default(5) final int refreshRate,
  }) = _PrefState;

  factory PrefState.fromJson(Map<String, dynamic> json) =>
      _$PrefStateFromJson(json);
}

class PrefCubit extends HydratedCubit<PrefState> {
  PrefCubit() : super(const PrefState());

  @override
  PrefState? fromJson(Map<String, dynamic> json) => PrefState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(PrefState state) => state.toJson();

  void setRefreshRate(int rate) => emit(state.copyWith(refreshRate: rate));
}
