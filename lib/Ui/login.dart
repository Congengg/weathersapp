import 'package:flutter/material.dart';
import 'package:weathersapp/Ui/get_started.dart';
import 'package:weathersapp/model/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController useridController = TextEditingController();
  Constants myConstants = Constants();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myConstants.secondaryColor,
        title: const Text('Login Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: useridController,
                decoration: const InputDecoration(
                  labelText: 'User ID',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                String username = usernameController.text;
                String password = passwordController.text;
                String userid = useridController.text;
                if (username == 'test' && password == '123456789' && userid == 'B100') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GetStarted(),
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Login Failed'),
                        content: const Text('Invalid username, password, or user ID'),
                        actions: [
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: myConstants.secondaryColor,
              ),
              child: const Text('Login'),

            ),
          ],
        ),
      ),
    );
  }
}