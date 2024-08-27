import 'package:chat_app/utils/colors.dart';

import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:iconsax/iconsax.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();

    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(),
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
                  'Reset Your Password',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Enter your email and we will send \nyou a link to reset your password',
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
                        label: 'Email',
                        prefixIcon: Iconsax.user,
                        controller: emailController,
                        obscureText: false,
                        isPassword: false,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ElevatedButton(
                        onPressed: () async{
                          if (formKey.currentState!.validate()) {
                            await FirebaseAuth.instance
                                .sendPasswordResetEmail(email: emailController.text).then((value) => Navigator.pop(context))
                                .onError((error, stackTrace) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
                            });
                            
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
                            'Send Reset Link',
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
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
