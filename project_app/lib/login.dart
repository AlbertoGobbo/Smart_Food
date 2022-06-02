import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_app/authentication_service.dart';
import 'package:project_app/login_painter.dart';
import 'package:project_app/signin.dart';
import 'package:provider/provider.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key}) : super(key: key);

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: Center(
        child: CustomPaint(
          painter: MyShapePainter(),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ClipRect(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        width: 200,
                        height: 150,
                        child: Image.asset('assets/icon_app.png')),
                    const MyLoginForm(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('Does not have account?'),
                        TextButton(
                          child: const Text(
                            'Sign in',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MySigninPage()),
                            );
                          },
                        )
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

class MyLoginForm extends StatefulWidget {
  const MyLoginForm({Key? key}) : super(key: key);

  @override
  State<MyLoginForm> createState() => _MyLoginFormState();
}

class _MyLoginFormState extends State<MyLoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: TextFormField(
            obscureText: true,
            controller: passwordController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'Forgot Password',
            style: TextStyle(color: Colors.blue, fontSize: 15),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            minimumSize: const Size(200, 50),
            maximumSize: const Size(200, 50),
          ),
          child: const Text(
            'Login',
            style: TextStyle(fontSize: 24),
          ),
          onPressed: () {
            var email = emailController.text;
            var psw = passwordController.text;

            context.read<AuthenticationService>().signIn(email, psw);
          },
        )
      ],
    );
  }

  checkIfUserExists(String user, String psw) async {
    try {
      bool result = await db
          .collection("users")
          .where('username', isEqualTo: user)
          .where('password', isEqualTo: psw)
          .get()
          .then((value) => value.size > 0 ? true : false);

      return result;
    } catch (e) {
      rethrow;
    }
  }
}
