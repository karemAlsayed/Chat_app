

import 'package:chat_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset('assets/svg/n_logo.svg',
    height: 150,
    colorFilter: ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
    );
  }
}