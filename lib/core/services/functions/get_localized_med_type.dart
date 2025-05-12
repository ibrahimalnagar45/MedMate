import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../utils/models/med_model.dart';

String getLocalizedMedType(MedType type, BuildContext context) {
  switch (type) {
    case MedType.powder:
      return S.of(context).powder;
    case MedType.pill:
      return S.of(context).pill;
    case MedType.syrup:
      return S.of(context).syrup;
    case MedType.drop:
      return S.of(context).drop;
    case MedType.cream:
      return S.of(context).cream;
    case MedType.injection:
      return S.of(context).injection;
    case MedType.inhaler:
      return S.of(context).inhaler;
  }
}
