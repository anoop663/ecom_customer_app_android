import 'package:ecommerce_app/app/core/values/colors.dart';
import 'package:ecommerce_app/app/core/values/strings.dart';
import 'package:ecommerce_app/app/routes/routes.dart';
import 'package:ecommerce_app/app/widgets/curve_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          SizedBox(
            height: 151,
            width: 138,
            child: Image.asset(
              ImageStrings.emptyCart,
            ),
          ),
          const Text(
            'Nothing in the bag',
            style: TextStyle(
              color: AppColors.textColor2,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          CurvedButton(
            textColor: AppColors.textColor1,
            buttonColor: AppColors.bottomSelectedColor,
            borderColor: AppColors.bottomSelectedColor,
            fontweight: FontWeight.w500,
            borderRadius: 4.0,
            onClick: () {
              Get.offAllNamed(Routes.bottombar);
            },
            width: MediaQuery.of(context).size.width * 0.8,
            height: 44,
            isSelected: true,
            text: 'CONTINUE SHOPPING',
          ),
          const Spacer(),
          const Spacer(),
        ],
      ),
    );
  }
}

class PointedDecorationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 0.5
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.square;
    var path = Path();
    var division = 0.045;
    path.moveTo(-10, 0);
    for (var i = division; i <= 1; i += division) {
      path.lineTo(size.width * i, size.width * division);
      i = (i + division);
      path.lineTo(size.width * i, 0);
    }

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}