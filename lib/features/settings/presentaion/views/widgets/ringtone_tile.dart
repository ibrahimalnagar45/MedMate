import 'package:flutter/material.dart';
import 'package:midmate/utils/app_colors.dart';
import '../../../data/models/ringtone_model.dart';

class RingtoneTile extends StatelessWidget {
  final RingtoneModel ringtone;
  final VoidCallback onTap;

  const RingtoneTile({super.key, required this.ringtone, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      color: theme.colorScheme.surface,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: theme.dividerColor),
      ),
      child: ListTile(
        leading: Icon(Icons.music_note_rounded, color: AppColors.blue),
        title: Text(ringtone.title, style: theme.textTheme.bodyLarge),
        trailing: Icon(Icons.play_arrow_rounded, color: AppColors.blue),
        onTap: onTap,
      ),
    );
  }
}
