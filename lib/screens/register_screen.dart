import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {


  final nameTextEditingController  = TextEditingController();
  final emailTextEditingController  = TextEditingController();
  final phoneTextEditingController  = TextEditingController();
  final addressTextEditingController  = TextEditingController();
  final passwordTextEditingController  = TextEditingController();
  final confirmTextEditingController  = TextEditingController();


  bool _passwordVisible = false;

  //declare a global key
  final _formKey =  GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(0),
          children: [
            Column(
              children: [
                Image.asset(darkTheme ? 'images/city_dark.png' : 'images/city.png'),
                SizedBox(height: 20,),
                Text(
                  'Register',
                  style: TextStyle(
                    color: darkTheme ? Colors.amber.shade400 : Colors.blue,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15,20,15,50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Form(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50)
                              ],
                              decoration: InputDecoration(
                                hintText: "Name",
                                hintStyle:TextStyle(
                                  color: Colors.grey
                                ),
                                filled: true,
                                fillColor: darkTheme? Colors.black45 : Colors.grey.shade200,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                prefixIcon: Icon(Icons.person, color: darkTheme? Colors.amber.shade400 : Colors.grey,)
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (text){
                                if(text == null || text.isNotEmpty){
                                  return "Name can\'t be empty ";
                                }
                                if(text.length < 2){
                                  return "Please enter a valid name";
                                }
                                if(text.length > 50){
                                  return "Name can\'t be more 50";
                                }
                              },
                                onChanged: (text) => setState(() {
                                  nameTextEditingController.text = text;
                                }),
                            ),

                            SizedBox(height: 10,),


                            TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(100)
                              ],
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle:TextStyle(
                                      color: Colors.grey
                                  ),
                                  filled: true,
                                  fillColor: darkTheme? Colors.black45 : Colors.grey.shade200,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  prefixIcon: Icon(Icons.person, color: darkTheme? Colors.amber.shade400 : Colors.grey,)
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (text){
                                if(text == null || text.isNotEmpty){
                                  return "Email can\'t be empty ";
                                }
                                if(text.length < 2){
                                  return "Please enter a valid email";
                                }
                                if(text.length > 99){
                                  return "Email can\'t be more 50";
                                }
                              },
                                onChanged: (text) => setState(() {
                                  emailTextEditingController.text = text;
                                }),

                            ),

                            SizedBox(height: 10,),




                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ));
  }
}
