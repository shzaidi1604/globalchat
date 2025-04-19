import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:globalchat/controllers/login_controller.dart';
import 'package:globalchat/screens/signup_screen.dart';
// import 'package:globalchat/controllers/signup_controller.dart';
// import 'package:globalchat/screens/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var userForm = GlobalKey<FormState>();
  bool isLoading = false;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Login Screen")),
      body: Form(
        key: userForm,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: Image.asset("assets/images/logo.png"),
              ),

              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is Required..";
                  }
                },
                decoration: InputDecoration(label: Text("Email:")),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: password,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password is Required..";
                  }
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(label: Text("Password:")),
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(0, 50),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.deepPurple,
                      ),
                      onPressed: () async {
                        if (userForm.currentState!.validate()) {
                          //create account
                          isLoading = true;
                          setState(() {});
                          await LoginController.login(
                            context: context,
                            email: email.text,
                            password: password.text,
                          );
                          isLoading = false;
                          setState(() {});
                        }
                      },
                      child:
                          isLoading
                              ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                              : Text("Login"),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: Row(
                  children: [
                    Text("Don't have an account?"),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SignupScreen();
                            },
                          ),
                        );
                      },
                      child: Text(
                        "SignUp",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
