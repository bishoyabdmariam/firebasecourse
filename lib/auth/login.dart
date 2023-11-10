import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasecourse/components/custombuttonauth.dart';
import 'package:firebasecourse/components/customlogoauth.dart';
import 'package:firebasecourse/components/textformfield.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 50),
              const CustomLogoAuth(),
              Container(height: 20),
              const Text("Login",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              Container(height: 10),
              const Text("Login To Continue Using The App",
                  style: TextStyle(color: Colors.grey)),
              Container(height: 20),
              const Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(height: 10),
              CustomTextForm(
                  hinttext: "ُEnter Your Email", mycontroller: email),
              Container(height: 10),
              const Text(
                "Password",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(height: 10),
              CustomTextForm(
                  hinttext: "ُEnter Your Password", mycontroller: password),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                alignment: Alignment.topRight,
                child: const Text(
                  "Forgot Password ?",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          CustomButtonAuth(
              title: "login",
              onPressed: () async {
                try {
                  final credential =
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email.text,
                    password: password.text,
                  );
                  Navigator.of(context).pushReplacementNamed("homepage");
                } on FirebaseAuthException catch (e) {
                  /*password.clear();
                  email.clear();*/

                  print(e.code);

                  if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
                    print('No user found for that email.');
                    print(
                        '""""""""""""""""""""""No user found for that email.""""""""""""""""""""""');

                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.info,
                      animType: AnimType.rightSlide,
                      title: 'Dialog Title',
                      desc: 'Dialog description here.............',
                    ).show();
                  } else if (e.code == 'wrong-password') {
                    print('Wrong password provided for that user.');
                    await AwesomeDialog(
                      context: context,
                      dialogType: DialogType.info,
                      animType: AnimType.rightSlide,
                      title: 'Password error',
                      desc: 'Wrong password provided for that user.',
                    ).show();
                  }
                }
              }),
          Container(height: 20),

          MaterialButton(
              height: 40,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.red[700],
              textColor: Colors.white,
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Login With Google  "),
                  Image.asset(
                    "images/4.png",
                    width: 20,
                  )
                ],
              )),
          Container(height: 20),
          // Text("Don't Have An Account ? Resister" , textAlign: TextAlign.center,)
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacementNamed("signup");
            },
            child: const Center(
              child: Text.rich(TextSpan(children: [
                TextSpan(
                  text: "Don't Have An Account ? ",
                ),
                TextSpan(
                    text: "Register",
                    style: TextStyle(
                        color: Colors.orange, fontWeight: FontWeight.bold)),
              ])),
            ),
          )
        ]),
      ),
    );
  }
}
