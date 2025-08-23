import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:users/global/golbal.dart';
import 'package:users/screens/main_page.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameTextEditingController = TextEditingController();
  final emailTextEditingController = TextEditingController();
  final phoneTextEditingController = TextEditingController();
  final addressTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final confirmTextEditingController = TextEditingController();

  bool _passwordVisible = false;

  // Declare a global key for form
  final _formKey = GlobalKey<FormState>();

  /// ✅ Submit function
  void _submit() async {
    if (_formKey.currentState!.validate()) {
      try {
        final authResult = await firebaseAuth.createUserWithEmailAndPassword(
          email: emailTextEditingController.text.trim(),
          password: passwordTextEditingController.text.trim(),
        );

        currnetUser = authResult.user;

        if (currnetUser != null) {
          Map userMap = {
            "id": currnetUser!.uid,
            "name": nameTextEditingController.text.trim(),
            "email": emailTextEditingController.text.trim(),
            "address": addressTextEditingController.text.trim(),
            "phone": phoneTextEditingController.text.trim(),
          };

          DatabaseReference userRef =
          FirebaseDatabase.instance.ref().child("users");
          await userRef.child(currnetUser!.uid).set(userMap);

          await Fluttertoast.showToast(msg: "✅ Successfully Registered");
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (c) => MainScreen()));
        }
      } catch (error) {
        Fluttertoast.showToast(msg: "❌ Error occurred: \n $error");
      }
    } else {
      Fluttertoast.showToast(msg: "⚠️ Not all fields are valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    bool darkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            Column(
              children: [
                Image.asset(darkTheme
                    ? 'images/city_dark.png'
                    : 'images/city.png'),
                const SizedBox(height: 20),
                Text(
                  'Register',
                  style: TextStyle(
                    color: darkTheme ? Colors.amber.shade400 : Colors.blue,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 50),
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Name Field
                            TextFormField(
                              controller: nameTextEditingController,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50)
                              ],
                              decoration: InputDecoration(
                                hintText: "Name",
                                filled: true,
                                fillColor: darkTheme
                                    ? Colors.black45
                                    : Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(Icons.person,
                                    color: darkTheme
                                        ? Colors.amber.shade400
                                        : Colors.grey),
                              ),
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return "Name can't be empty";
                                }
                                if (text.length < 2) {
                                  return "Please enter a valid name";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),

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
                                prefixIcon: Icon(Icons.email,
                                    color: darkTheme
                                        ? Colors.amber.shade400
                                        : Colors.grey),
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
                            const SizedBox(height: 10),

                            // Phone Field
                            IntlPhoneField(
                              initialCountryCode: 'BD',
                              showCountryFlag: false,
                              decoration: InputDecoration(
                                hintText: "Phone",
                                filled: true,
                                fillColor: darkTheme
                                    ? Colors.black45
                                    : Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              onChanged: (phone) {
                                phoneTextEditingController.text =
                                    phone.completeNumber;
                              },
                              validator: (phone) {
                                if (phone == null || phone.number.isEmpty) {
                                  return "Phone can't be empty";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),

                            // Address Field
                            TextFormField(
                              controller: addressTextEditingController,
                              decoration: InputDecoration(
                                hintText: "Address",
                                filled: true,
                                fillColor: darkTheme
                                    ? Colors.black45
                                    : Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(Icons.home,
                                    color: darkTheme
                                        ? Colors.amber.shade400
                                        : Colors.grey),
                              ),
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return "Address can't be empty";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // Password Field
                            TextFormField(
                              controller: passwordTextEditingController,
                              obscureText: !_passwordVisible,
                              decoration: InputDecoration(
                                hintText: "Password",
                                filled: true,
                                fillColor: darkTheme
                                    ? Colors.black45
                                    : Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(Icons.lock,
                                    color: darkTheme
                                        ? Colors.amber.shade400
                                        : Colors.grey),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                              ),
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return "Password can't be empty";
                                }
                                if (text.length < 6) {
                                  return "Password must be at least 6 characters";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // Confirm Password Field
                            TextFormField(
                              controller: confirmTextEditingController,
                              obscureText: !_passwordVisible,
                              decoration: InputDecoration(
                                hintText: "Confirm Password",
                                filled: true,
                                fillColor: darkTheme
                                    ? Colors.black45
                                    : Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(Icons.lock,
                                    color: darkTheme
                                        ? Colors.amber.shade400
                                        : Colors.grey),
                              ),
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return "Confirm Password can't be empty";
                                }
                                if (text != passwordTextEditingController.text) {
                                  return "Passwords do not match";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // Register Button
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: darkTheme
                                    ? Colors.amber.shade400
                                    : Colors.blue,
                                foregroundColor: darkTheme
                                    ? Colors.black
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              onPressed: _submit, // ✅ Fixed
                              child: const Text('Register',
                                  style: TextStyle(fontSize: 20)),
                            ),




                            SizedBox(height: 20),

// Forgot Password
                            GestureDetector(
                              onTap: () {
                                // Forgot password action here
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: darkTheme ? Colors.amber.shade400 : Colors.blue,
                                ),
                              ),
                            ),

                            SizedBox(height: 20),

// Sign In option
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Have an account?",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(width: 5),
                                GestureDetector(
                                  onTap: () {
                                    // Navigate to Sign In screen here
                                  },
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: darkTheme ? Colors.amber.shade400 : Colors.blue,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ],
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
