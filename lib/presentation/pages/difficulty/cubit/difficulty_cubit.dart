import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trivia_app/domain/models/difficulty_ui_model.dart';

part 'difficulty_state.dart';
part 'difficulty_cubit.freezed.dart';

class DifficultyCubit extends Cubit<DifficultyState> {
  DifficultyCubit() : super(const DifficultyState());
}
