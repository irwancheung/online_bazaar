// ignore_for_file: avoid_classes_with_only_static_members

import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:online_bazaar/exports.dart';

class FormValidators {
  static FormFieldValidator<T> currency<T>({
    int? min,
    int? max,
    String? errorText,
  }) {
    return (T? valueCandidate) {
      if (valueCandidate != null) {
        final valInt = valueCandidate.toString().toInteger();

        if (valInt < min!) {
          return errorText ??
              FormBuilderLocalizations.current.minErrorText(min);
        }

        if (valInt > max!) {
          return errorText ??
              FormBuilderLocalizations.current.maxErrorText(max);
        }
      }

      return null;
    };
  }
}
