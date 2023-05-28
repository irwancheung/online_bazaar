import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FormBuilderLocalizationsId extends FormBuilderLocalizationsImplId {
  FormBuilderLocalizationsId();

  static const LocalizationsDelegate<FormBuilderLocalizationsImpl> delegate =
      _LocalizationsDelegate();

  static const List<Locale> supportedLocales = [Locale('id')];

  @override
  String get requiredErrorText => 'Wajib diisi.';

  @override
  String minLengthErrorText(Object minLength) {
    return 'Jumlah karakter minimal $minLength.';
  }

  @override
  String maxLengthErrorText(Object maxLength) {
    return 'Jumlah karakter maksimal $maxLength.';
  }
}

class _LocalizationsDelegate
    extends LocalizationsDelegate<FormBuilderLocalizationsImpl> {
  const _LocalizationsDelegate();

  @override
  Future<FormBuilderLocalizationsImpl> load(Locale locale) {
    final instance = FormBuilderLocalizationsId();

    FormBuilderLocalizations.setCurrentInstance(instance);
    return SynchronousFuture<FormBuilderLocalizationsImpl>(instance);
  }

  @override
  bool isSupported(Locale locale) =>
      FormBuilderLocalizationsId.supportedLocales.contains(locale);

  @override
  bool shouldReload(_LocalizationsDelegate old) => false;
}
