import 'package:flutter/material.dart';
import 'package:midmate/features/home/presentation/views/widgets/custom_med_list_tile.dart';

import '../../../../../core/functions/get_localized_med_type.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../utils/models/med_model.dart';
import '../../../../../utils/text_styles.dart';

class MedInfo extends StatelessWidget {
  const MedInfo({super.key, required this.medModel});

  final MedModel medModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).medName(medModel.name!),
          // S.of(context).ttt,
          style: TextStyles.regWhtieTextStyle,
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: medModel.dose!.toInt().toString(),
                style: TextStyles.regGreyTextStyle,
              ),
              TextSpan(text: ' '),
              TextSpan(
                text:
                    getLocalizedMedType(medModel.type!, context) ==
                                S.of(context).powder ||
                            getLocalizedMedType(medModel.type!, context) ==
                                S.of(context).syrup ||
                            getLocalizedMedType(medModel.type!, context) ==
                                S.of(context).inhaler ||
                            getLocalizedMedType(medModel.type!, context) ==
                                S.of(context).cream
                        ? S.of(context).ml
                        : S
                            .of(context)
                            .medType(
                              isArabic()
                                  ? getLocalizedMedType(medModel.type!, context)
                                  : S
                                      .of(context)
                                      .medType(medModel.type!)
                                      .toString()
                                      .substring(8),
                            ),

                style: TextStyles.regGreyTextStyle,
              ),
            ],
          ),
        ),
        // MedInfo(medModel: widget.medModel),
      ],
    );

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: medModel.dose!.toInt().toString(),
            style: TextStyles.regGreyTextStyle,
          ),
          TextSpan(text: ' '),
          TextSpan(
            text:
                getLocalizedMedType(medModel.type!, context) ==
                            S.of(context).powder ||
                        getLocalizedMedType(medModel.type!, context) ==
                            S.of(context).syrup ||
                        getLocalizedMedType(medModel.type!, context) ==
                            S.of(context).inhaler ||
                        getLocalizedMedType(medModel.type!, context) ==
                            S.of(context).cream
                    ? S.of(context).ml
                    : S
                        .of(context)
                        .medType(
                          isArabic()
                              ? getLocalizedMedType(medModel.type!, context)
                              : S
                                  .of(context)
                                  .medType(medModel.type!)
                                  .toString()
                                  .substring(8),
                        ),

            style: TextStyles.regGreyTextStyle,
          ),
        ],
      ),
    );
  }
}
