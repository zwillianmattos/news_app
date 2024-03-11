import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:news_app/features/news/data/models/news/source_model.dart';
import 'package:news_app/features/news/usecases/sources/choose_source.dart';
import 'package:uno/uno.dart';

class ChooseSourcesController extends ValueNotifier<SourcesState> {
  final ChooseSourceUseCase _chooseSourceUseCase;

  ChooseSourcesController(this._chooseSourceUseCase)
      : super(LoadingSourcesState());

  getAll() async {
    try {
      value = LoadingSourcesState();
      List<SourceModel> sources = await _chooseSourceUseCase.getAll();
      value = SuccessSourcesState(sources);
    } on Exception catch (e) {
      String message = e.toString();
      if (e is UnoError) {
        if (e.message != '') {
          message = e.message;
        } else if (e.response?.data['message'] != '') {
          message = e.response?.data['message'];
        } else {
          message = 'Internal Server Error';
        }
      }
      value = ErrorSourcesState(message);
    }
  }

  bool isNextButtonVisible() {
    if (value is SuccessSourcesState) {
      final selectedSourcesCount = (value as SuccessSourcesState)
          .sources
          .where((source) => source.isChecked)
          .length;
      return selectedSourcesCount >= 3;
    }
    return false;
  }
}

abstract class SourcesState extends Disposable {
  @override
  void dispose() {}
}

class LoadingSourcesState extends SourcesState {}

class SuccessSourcesState extends SourcesState {
  final List<SourceModel> sources;
  SuccessSourcesState(this.sources);
}

class ErrorSourcesState extends SourcesState {
  final String errorMessage;
  ErrorSourcesState(this.errorMessage);
}
