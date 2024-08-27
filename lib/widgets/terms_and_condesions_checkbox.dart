


import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/widgets/custom_checbox.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsWidget extends StatefulWidget {
  const TermsAndConditionsWidget({super.key});

  @override
  State<TermsAndConditionsWidget> createState() => _TermsAndConditionsWidgetState();
}

class _TermsAndConditionsWidgetState extends State<TermsAndConditionsWidget> {
  bool isTermsAccepted = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         CustomCheckBox(
          onChecked: (value) {
            isTermsAccepted = value;
            setState(() {});
          },
          isChecked: isTermsAccepted),
        const SizedBox(width: 16,),
        Expanded(
          child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'By registering, you agree to our ',
                    style:  TextStyle(
                      color: kGreyColor
                    ),
                  ),
                  TextSpan(
                    text: 'Terms and Conditions',
                    style: TextStyle(
                      color: kPrimaryColor
                    ),
                  ),
                  
                ],
              ),
            ),
        ),
      ],
    );
  }
}