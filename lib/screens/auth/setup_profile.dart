import 'package:chat_app/firebase/fire_auth.dart';

import 'package:chat_app/utils/colors.dart';

import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:chat_app/widgets/terms_and_condesions_checkbox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:iconsax/iconsax.dart';

class SetupProfile extends StatefulWidget {
  const SetupProfile({super.key});

  @override
  State<SetupProfile> createState() => _SetupProfileState();
}

class _SetupProfileState extends State<SetupProfile> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(
              Iconsax.logout_1,
            ),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            }),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Welcome To our App',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Please Enter Your Name ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.grey),
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        label: 'Name',
                        prefixIcon: Iconsax.user,
                        controller: emailController,
                        obscureText: false,
                        isPassword: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const TermsAndConditionsWidget(),
                      const SizedBox(
                        height: 25,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                           await  FirebaseAuth.instance.currentUser!
                                .updateDisplayName(emailController.text)
                                .then(
                              (value) {
                                FireAuth.createUser();
                              },
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          minimumSize: const Size(double.infinity, 50),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
