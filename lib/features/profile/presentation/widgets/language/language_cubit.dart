import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class LanguageCubit extends HydratedCubit<Locale> {
  LanguageCubit() : super(const Locale('en'));

  void changeLanguage(String languageCode) {
    emit(Locale(languageCode));
  }

  @override
  Locale? fromJson(Map<String, dynamic> json) {
    return Locale(json['languageCode']);
  }

  @override
  Map<String, dynamic>? toJson(Locale state) {
    return {'languageCode': state.languageCode};
  }
}
