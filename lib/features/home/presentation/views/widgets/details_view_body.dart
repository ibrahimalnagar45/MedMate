// import 'package:flutter/material.dart';
// import 'package:midmate/utils/models/med_model.dart';

// class DetailsViewBody extends StatelessWidget {
//   const DetailsViewBody({super.key, required this.med});
//   final MedModel med;
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Text(med.name!),
//           Text(med.getType().toString()),
//           Text(med.dose!.toInt().toString()),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:midmate/utils/models/med_model.dart';

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
            _infoTile('اسم الدواء', med.name ?? 'غير محدد', Icons.medication),
            _infoTile(
              'الوصف',
              med.description ?? 'لا يوجد وصف',
              Icons.description,
            ),
            _infoTile(
              'النوع',
              med.getArabicMedType() ?? 'غير محدد',
              Icons.category,
            ),
            _infoTile('الجرعة', '${med.dose ?? 0}', Icons.local_pharmacy),
            _infoTile('عدد المرات/يوم', '${med.frequency ?? 0}', Icons.repeat),
            _infoTile(
              'تاريخ البدء',
              _formatDate(med.startDate),
              Icons.date_range,
            ),
            _infoTile(' الجرعة القادمة الساعة', med.getFormattedNextTime(), Icons.alarm),
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
