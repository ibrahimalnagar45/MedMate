import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:midmate/core/functions/get_type_measured.dart';
import 'package:midmate/generated/l10n.dart';
import 'package:midmate/utils/models/med_model.dart';

import '../../../../../core/functions/get_localized_med_type.dart';

class DetailsViewBody extends StatelessWidget {
  final MedModel med;

  const DetailsViewBody({super.key, required this.med});

  String _formatDate(DateTime? date) {
    if (date == null) return 'غير محدد';
    return DateFormat('dd/MM – hh:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _infoTile(
              S.of(context).title,
              S.of(context).medName(med.name ?? S.of(context).unSpecified),
              Icons.medication,
            ),
            _infoTile(
              S.of(context).description,
              S
                  .of(context)
                  .medDescription(
                    med.description == null
                        ? S.of(context).NoDescription
                        : med.description!,
                  ),

              Icons.description,
            ),
            _infoTile(
              S.of(context).type,
              getLocalizedMedType(med.type!, context),

              Icons.category,
            ),
            // dose
            _infoTile(
              S.of(context).dose,
              "${S.of(context).medDose(med.dose!.toInt())} ${getTypeMeasurement(med.type!)} ",
              Icons.local_pharmacy,
            ),

            // frequency
            _infoTile(
              S.of(context).frequency,
              med.frequency == 24
                  ? S.of(context).everyDay
                  : med.frequency != 12
                  ? S.of(context).everyNumHour(med.frequency ?? 0)
                  // ? '${med.frequency ?? 0} ساعات'
                  : S.of(context).everyNumHours(med.frequency ?? 0),
              Icons.repeat,
            ),
            // start date
            _infoTile(
              S.of(context).startDate,
              _formatDate(med.startDate),
              Icons.date_range,
            ),
            // next time
            _infoTile(
              S.of(context).nextDoseAt,
              med.getFormattedNextTime(),
              Icons.alarm,
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(String title, String value, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF306D75)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value),
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
    );
  }
}
