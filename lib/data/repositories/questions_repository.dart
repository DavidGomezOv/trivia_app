import 'dart:async';

import 'package:trivia_app/core/exceptions.dart';
import 'package:trivia_app/core/result.dart';
import 'package:trivia_app/data/api/questions_api.dart';
import 'package:trivia_app/domain/irepositories/i_questions_repository.dart';
import 'package:trivia_app/domain/models/question.dart';

class QuestionsRepository implements IQuestionsRepository {
  final QuestionsApi questionsApi;

  QuestionsRepository({required this.questionsApi});

  @override
  Future<Result<List<Question>>> getQuestions() async {
    try {
      final result = await questionsApi.getQuestions();
      return Result.success(data: result);
    } on NetworkException catch (error) {
      return Result.failure(error: error);
    } on Exception catch (error) {
      return Result.failure(error: error);
    }
  }
}
