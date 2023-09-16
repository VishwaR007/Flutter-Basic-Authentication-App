import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:third_app_two/authentication/database.dart';
import 'package:third_app_two/authentication/login_screen.dart';
import 'package:third_app_two/homepage.dart';
// import 'package:third_app_two/home_page.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String name = "";
  String email = "";
  String pass = "";

  void handleSignUp() async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      print("User Registered: ${userCredential.user!.email}");
      uploadData();
      // nameController.clear();
      // emailController.clear();
      // passwordController.clear();

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DemoPage()));
    } catch (e) {
      print('Error during Registration $e');
    }
  }

  uploadData() async {
    Map<String, dynamic> uploaddata = {
      "Name": nameController.text,
      "Email": emailController.text,
      "Password": passwordController.text,
    };

    await DatabaseMethods().addUserDetails(uploaddata);

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("All Fields are added to data-base ... !")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Full Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Your Full Name";
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email", border: OutlineInputBorder(),
                  // hintText: "Email",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Your Email";
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Your Password";
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    pass = value;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      handleSignUp();
                    }
                  },
                  child: Text("Sign Up")),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account."),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: Text("LogIn"),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
