import 'package:ecommerce_app/app/core/extensions/circlular_slider.dart';
import 'package:ecommerce_app/app/core/values/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';


class AppFilterSlider extends StatefulWidget {
  const AppFilterSlider({
    super.key,
    required this.min,
    required this.max,
    this.onChanged,
  });
  final double? min, max;
  final Function(RangeValues?)? onChanged;
  @override
  State<AppFilterSlider> createState() => _AppFilterSliderState();
}

class _AppFilterSliderState extends State<AppFilterSlider> {
  @override
  void initState() {
    super.initState();
    values = RangeValues(
      widget.min!,
      widget.max!,
    );
  }

  RangeValues? values;
  String? currentStart = '', currentEnd = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SliderTheme(
          data: const SliderThemeData(
            trackHeight: 0.1,
            activeTrackColor: AppColors.textColor2,
            inactiveTrackColor: AppColors.textColor2,
            overlayShape: RoundSliderOverlayShape(overlayRadius: 10),
            rangeThumbShape: CircleSliderThumb(
              radius: 10,
            ),
          ),
          child: RangeSlider(
            min: widget.min ?? 0.0,
            max: widget.max ?? 1.0,
            values: values!,
            onChanged: (value1) {
              setState(() {
                values = value1;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(values);
              }
            },
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          '${values!.start.toPrecision(2)}-${values!.end.toPrecision(2)}',
          style: Get.theme.textTheme.bodySmall!.copyWith(
            color: AppColors.priceRangeText,
          ),
        )
      ],
    );
  }
}
