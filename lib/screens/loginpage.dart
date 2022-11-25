import 'package:crud_flutter/screens/homepage.dart';
import 'package:crud_flutter/screens/registerpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var loginkey=new GlobalKey<FormState>();
  var emailController=new TextEditingController();
  var passwordController=new TextEditingController();


 Future<void> signIn() async{
    var data={
      "email":emailController.text,
      "password":passwordController.text,
    };
    var response=await post(Uri.parse('http://192.168.0.113/crud_flutter/login.php'),body: data);
    print(response.body);
    print(response.statusCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: loginkey,
                  child: Column(
                    children: [
                      Text("LOGIN",
                        style: TextStyle(
                            fontSize: 52,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (value){
                            if(value!.isEmpty) {
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
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: passwordController,
                          validator: (value){
                            if(value!.isEmpty) {
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
                        ),
                      ),
                      SizedBox(height: 20,),
                      ElevatedButton(onPressed: (){
                        if(loginkey.currentState!.validate()){
                          signIn();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                          snackbar("login Successful", Colors.green);
                        }else{
                          snackbar("login failed", Colors.red);
                        }

                      },
                          child: Text("Login")),

                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an Account?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
                      },
                      child: Text(" Sign Up",style: TextStyle(color: Colors.blueAccent)),
                    )
                  ],
                ),
              ],
            ),
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
