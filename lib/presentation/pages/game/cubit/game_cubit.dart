import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_state.dart';

part 'game_cubit.freezed.dart';

enum PageState { initial, loading, loaded, failedToLoad }

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(const GameState());
}
