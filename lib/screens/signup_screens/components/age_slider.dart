import 'package:flutter/material.dart';
import 'package:flutter_project_labour_app/util/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class AgeSlider extends StatelessWidget {
  const AgeSlider({
    super.key,
    required this.onChanged,
    required this.value,
  });

  final int value;
  final ValueChanged<dynamic>? onChanged;

  @override
  Widget build(BuildContext context) {
    return SfSliderTheme(
      data: SfSliderThemeData(
        thumbRadius: 20.r,
        thumbColor: primaryRed,
        activeTrackColor: primaryRed,
        inactiveTrackColor: inactiveTrackColor,
      ),
      child: SfSlider(
        min: 0,
        max: 100,
        value: value,
        minorTicksPerInterval: 1,
        onChanged: onChanged,
        thumbIcon: Center(
          child: Text(
            value.toInt().toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
