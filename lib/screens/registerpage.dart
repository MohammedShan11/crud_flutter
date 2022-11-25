import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'loginpage.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var nameController = new TextEditingController();
  var emailController = new TextEditingController();
  var passwordController = new TextEditingController();

  // var confirmController = new TextEditingController();
  var numberController = new TextEditingController();
  var registerKey = new GlobalKey<FormState>();


  Future<void> signUp() async {
    var data = {
      "username": nameController.text,
      "email": emailController.text,
      "phone": numberController.text,
      "password": passwordController.text,
    };
    var response = await post(
        Uri.parse('http://192.168.0.113/crud_flutter/register.php'),
        body: data);
    print(response.body);
    print(response.statusCode);
  }
    @override
    Widget build(BuildContext context) {
      return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 100,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Form(
                    key: registerKey,
                    child: Column(
                      children: [
                        Text(
                          "REGISTER",
                          style: TextStyle(
                              fontSize: 52, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 80,),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Name is Invalid";
                            }
                          },

                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              hintText: "Username"
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "email is Invalid";
                            }
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              hintText: "Email"
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: numberController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "number is Invalid";
                            } else if (value.length < 10) {
                              return "number is invalid";
                            }
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              hintText: "PhoneNumber"
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "password is Invalid";
                            }
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              hintText: "Password"
                          ),
                          obscureText: true,
                        ),

                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                ElevatedButton(onPressed: () {
                  if (registerKey.currentState!.validate()){
                    signUp();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                    snackbar("registration successful", Colors.green);
                  }else{
                    snackbar("registration failed", Colors.red);
                  }

                }, child: Text("Register")),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an Account?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (
                            context) => LoginPage()));
                      },
                      child: Text(" Sign In",
                          style: TextStyle(color: Colors.blueAccent)),
                    )
                  ],
                ),

              ],
            ),
          ),
        ),
      );
    }
    snackbar(var msg, var color) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(msg),
        backgroundColor: color,
      ));
    }
  }
