import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:news_app/features/news/data/models/country/country_model.dart';
import 'package:news_app/features/news/usecases/sources/choose_country.dart';
import 'package:uno/uno.dart';

class ChooseCountryController extends ValueNotifier<ChooseCountryState> {
  final ChooseCountryUseCase _chooseCountryUseCase;

  ChooseCountryController(this._chooseCountryUseCase)
      : super(LoadingChooseCountryState());

  getAll() async {
    try {
      value = LoadingChooseCountryState();
      List<CountryModel> sources = await _chooseCountryUseCase.getAll();
      value = SuccessChooseCountryState(sources);
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
      value = ErrorChooseCountryState(message);
    }
  }
  bool isNextButtonVisible() {
    if (value is SuccessChooseCountryState) {
      final selectedSourcesCount = (value as SuccessChooseCountryState)
          .country
          .where((source) => source.isChecked)
          .length;
      return selectedSourcesCount == 1;
    }
    return false;
  }
  
}

abstract class ChooseCountryState extends Disposable {
  @override
  void dispose() {}
}

class LoadingChooseCountryState extends ChooseCountryState {}

class SuccessChooseCountryState extends ChooseCountryState {
  final List<CountryModel> country;
  SuccessChooseCountryState(this.country);
}

class ErrorChooseCountryState extends ChooseCountryState {
  final String errorMessage;
  ErrorChooseCountryState(this.errorMessage);
}
