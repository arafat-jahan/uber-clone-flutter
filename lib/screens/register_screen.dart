import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

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

  @override
  Widget build(BuildContext context) {
    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

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
                Image.asset(darkTheme ? 'images/city_dark.png' : 'images/city.png'),
                SizedBox(height: 20),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Form(
                        key: _formKey, // ✅ Add form key
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Name Field
                            TextFormField(
                              controller: nameTextEditingController,
                              inputFormatters: [LengthLimitingTextInputFormatter(50)],
                              decoration: InputDecoration(
                                hintText: "Name",
                                hintStyle: TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(Icons.person, color: darkTheme ? Colors.amber.shade400 : Colors.grey),
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return "Name can't be empty";
                                }
                                if (text.length < 2) {
                                  return "Please enter a valid name";
                                }
                                if (text.length > 50) {
                                  return "Name can't be more than 50 characters";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10),

                            // Email Field
                            TextFormField(
                              controller: emailTextEditingController,
                              inputFormatters: [LengthLimitingTextInputFormatter(100)],
                              decoration: InputDecoration(
                                hintText: "Email",
                                hintStyle: TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(Icons.email, color: darkTheme ? Colors.amber.shade400 : Colors.grey),
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return "Email can't be empty";
                                }
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(text)) {
                                  return "Please enter a valid email";
                                }
                                if (text.length > 99) {
                                  return "Email can't be more than 100 characters";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10),

                            // Phone Field
                            IntlPhoneField(
                              controller: phoneTextEditingController,
                              showCountryFlag: false,
                              initialCountryCode: 'BD',
                              dropdownIcon: Icon(
                                Icons.arrow_drop_down,
                                color: darkTheme ? Colors.amber.shade400 : Colors.grey,
                              ),
                              decoration: InputDecoration(
                                hintText: "Phone",
                                hintStyle: TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              onChanged: (phone) {
                                phoneTextEditingController.text = phone.completeNumber;
                              },
                            ),
                            SizedBox(height: 10),

                            // Address Field
                            TextFormField(
                              controller: addressTextEditingController,
                              inputFormatters: [LengthLimitingTextInputFormatter(100)],
                              decoration: InputDecoration(
                                hintText: "Address",
                                hintStyle: TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(Icons.home, color: darkTheme ? Colors.amber.shade400 : Colors.grey),
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return "Address can't be empty";
                                }
                                if (text.length < 2) {
                                  return "Please enter a valid address";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),

                            // Password Field
                            TextFormField(
                              controller: passwordTextEditingController,
                              obscureText: !_passwordVisible,
                              inputFormatters: [LengthLimitingTextInputFormatter(50)],
                              decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(Icons.lock, color: darkTheme ? Colors.amber.shade400 : Colors.grey),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                    color: darkTheme ? Colors.amber.shade400 : Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return "Password can't be empty";
                                }
                                if (text.length < 6) {
                                  return "Password must be at least 6 characters";
                                }
                                if (text.length > 50) {
                                  return "Password can't be more than 50 characters";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),

                            // Confirm Password Field
                            TextFormField(
                              controller: confirmTextEditingController,
                              obscureText: !_passwordVisible,
                              inputFormatters: [LengthLimitingTextInputFormatter(50)],
                              decoration: InputDecoration(
                                hintText: "Confirm Password",
                                hintStyle: TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(Icons.lock, color: darkTheme ? Colors.amber.shade400 : Colors.grey),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                    color: darkTheme ? Colors.amber.shade400 : Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            SizedBox(height: 20),

                            // Register Button
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: darkTheme ? Colors.amber.shade400 : Colors.blue,
                                foregroundColor: darkTheme ? Colors.black : Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                minimumSize: Size(double.infinity, 50),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // Proceed with registration
                                }
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),

                            SizedBox(height: 20),

                            // Forgot Password
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: darkTheme ? Colors.amber.shade400 : Colors.blue,
                                ),
                              ),
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
