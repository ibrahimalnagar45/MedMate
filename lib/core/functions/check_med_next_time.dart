import 'dart:developer';
import 'package:midmate/utils/models/med_model.dart';

void checkMedNextTime(MedModel medModel) {
  while(medModel.getNextTime()!.isBefore(DateTime.now())) {
    log("next time is before now");
    log(medModel.nextTime.toString());
    log('now is ${DateTime.now()}');
    medModel.setNextTime();
    log('after setting the next time ');
    log(medModel.nextTime.toString());
    log('now is ${DateTime.now()}');
  }
}
