import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:users/global/golbal.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    firebaseAuth
        .sendPasswordResetEmail(
      email: emailTextEditingController.text.trim(),
    )
        .then((value) {
      Fluttertoast.showToast(
        msg:
        "We have sent you an email to reset your password. Please check your inbox.",
      );
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(
        msg: "Error Occurred:\n${error.toString()}",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    bool darkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // keyboard dismiss
      },
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            Column(
              children: [
                // Top image
                Image.asset(
                  darkTheme ? 'images/city_dark.png' : 'images/city.png',
                ),
                const SizedBox(height: 20),

                // Screen title
                Text(
                  'Forgot Password',
                  style: TextStyle(
                    color: darkTheme ? Colors.amber.shade400 : Colors.blue,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Form section
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 50),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Email Field
                        TextFormField(
                          controller: emailTextEditingController,
                          decoration: InputDecoration(
                            hintText: "Email",
                            filled: true,
                            fillColor: darkTheme
                                ? Colors.black45
                                : Colors.grey.shade200,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: Icon(
                              Icons.email,
                              color: darkTheme
                                  ? Colors.amber.shade400
                                  : Colors.grey,
                            ),
                          ),
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Email can't be empty";
                            }
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(text)) {
                              return "Please enter a valid email";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        // Reset Password Button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: darkTheme
                                ? Colors.amber.shade400
                                : Colors.blue,
                            foregroundColor:
                            darkTheme ? Colors.black : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _submit();
                            }
                          },
                          child: const Text(
                            'Reset Password',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Sign Up option
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                // Navigate to Sign Up screen
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: darkTheme
                                      ? Colors.amber.shade400
                                      : Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
