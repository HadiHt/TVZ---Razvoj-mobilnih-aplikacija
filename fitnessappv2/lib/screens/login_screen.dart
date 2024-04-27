import 'package:fitnessappv2/Providers/auth_provider.dart';
import 'package:fitnessappv2/screens/signup_screen.dart';
import 'package:fitnessappv2/services/database_service.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import 'package:flutter/material.dart';
import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController tttt = TextEditingController();
  TextEditingController bbbb = TextEditingController();
  final DatabaseService dbService = DatabaseService();
  final AuthProvider authProvider = AuthProvider();
  getUser() {
    var email = tttt.text;
    var password = bbbb.text;
    User loginUser = User(username: "", email: email, password: password);
    Provider.of<AuthProvider>(context, listen: false).getAuth(loginUser).then((_) {
      User user = Provider.of<AuthProvider>(context, listen: false).user;
      print(user.username);
      if (user.email != "") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Login Failed :)"),
          backgroundColor: Colors.red,
        ));
      }
    });
  }


  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
      children: [
        Container(
          alignment: Alignment.center,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Text(
                  "Log In",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Theme.of(context).secondaryHeaderColor),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: tttt,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter something';
                      } else if (RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return null;
                      } else {
                        return 'Enter valid email';
                      }
                    },
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.email,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                        hintText: 'Enter Email',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                                color: Theme.of(context).secondaryHeaderColor)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                                color: Theme.of(context).secondaryHeaderColor)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.red)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.red))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: bbbb,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter something';
                      }
                      return null;
                    },
                    obscureText: true,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.vpn_key,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                        hintText: 'Enter Password',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                                color: Theme.of(context).secondaryHeaderColor)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                                color: Theme.of(context).secondaryHeaderColor)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.red)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.red))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(55, 16, 16, 0),
                  child: SizedBox(
                    height: 50,
                    width: 400,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            )),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            getUser();
                          } else {
                            print("not ok");
                          }
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(55, 16, 16, 0),
                  child: SizedBox(height: 50, width: 400),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(95, 20, 0, 0),
                    child: Row(
                      children: [
                        Text(
                          "No Account?",
                          style: TextStyle(
                              color: Theme.of(context).secondaryHeaderColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 40.0),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignupScreen()));
                          },
                          child: Text(
                            " Sign up",
                            style: TextStyle(
                                color: Theme.of(context).secondaryHeaderColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        )
      ],
    ));
  }
}
