import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;
  const CustomButton({super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height * 0.089,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: AppColors.secondaryColor),
        child: child,
      ),
    );
  }
}
