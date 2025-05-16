import 'package:midmate/utils/models/med_model.dart';

import '../../../generated/l10n.dart';

String getTypeMeasurement(MedType type) {
  switch (type) {
    case MedType.pill:
      return S.current.pill;
    case MedType.powder:
      return S.current.ml;
    case MedType.syrup:
      return S.current.ml;
    case MedType.drop:
      return S.current.drop;
    case MedType.cream:
      return S.current.ml;
    case MedType.injection:
      return S.current.injection;
    case MedType.inhaler:
      return S.current.inhaler;
  }
}
