
// ignore_for_file: avoid_print

import 'package:chat_app/screens/auth/password_reset_screen.dart';

import 'package:chat_app/utils/colors.dart';
import 'package:chat_app/widgets/app_logo.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 80,
                ),
                const AppLogo(),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Welcome',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Login Or Register ',
                  style: Theme.of(context).textTheme.bodyLarge,
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
                      CustomTextField(
                        label: 'Password',
                        prefixIcon: Iconsax.key,
                        controller: passController,
                        obscureText: true,
                        isPassword: true,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Spacer(),
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.grey,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PasswordResetScreen()));
                            },
                            child: const Text('Forgot Password?'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ElevatedButton(
                        onPressed: () async{
                          if (formKey.currentState!.validate()) {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passController.text)
                                .then((value) {
                              print('Login Successful');
                            }).onError((error, stackTrace) {
                              ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                content: Text(error.toString()),
                              ));
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
                            'Login',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          // if (formKey.currentState!.validate()) {
                          //   Navigator.pushAndRemoveUntil(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => const SetupProfile()),
                          //       (route) => false);
                          // }
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passController.text)
                              .then((value) {
                            print('Registration Successful');
                          }).onError((error, stackTrace) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(error.toString())));
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                        child: Center(
                            child: Text(
                          'Register',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 18),
                        )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
