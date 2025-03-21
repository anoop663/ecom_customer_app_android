import 'package:flutter/material.dart';

import '../core/values/colors.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ignore: deprecated_member_use
          Container(color: AppColors.textColor2.withOpacity(0.2)),
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              color: AppColors.textColor1,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(
                  color: AppColors.textColor2,
                  backgroundColor: Colors.grey.shade200,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
