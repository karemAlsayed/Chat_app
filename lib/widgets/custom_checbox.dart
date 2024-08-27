

import 'package:chat_app/utils/colors.dart';
import 'package:flutter/material.dart';


import 'package:flutter_svg/flutter_svg.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({super.key, required this.isChecked, required this.onChecked});
  final  bool isChecked;
  final ValueChanged<bool> onChecked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChecked(!isChecked);
      },
      
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: 24,
        height: 24,
        decoration: ShapeDecoration(
          color: isChecked? kPrimaryColor: Colors.white,
          shape: RoundedRectangleBorder(
            side:  BorderSide(width: 1.50, color:isChecked ?Colors.transparent: const Color(0xFFDCDEDE)),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child:isChecked? Padding(
          padding: const EdgeInsets.all(2),
          child: SvgPicture.asset('assets/svg/Check.svg',colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onPrimary, BlendMode.srcIn),),
        ):const SizedBox(),

      ),
    );
  }
}
