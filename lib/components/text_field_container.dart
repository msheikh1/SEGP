import 'package:flutter/material.dart';

import '../constants.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;

  const TextFieldContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: myLightBlue,
        borderRadius: BorderRadius.circular(29),
      ),
      // child: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.stretch,
      //   children: [
      //     TextField(
      //       controller: _emailController,
      //       decoration: InputDecoration(labelText: 'Email'),
      //     ),
      //     SizedBox(height: 8.0),
      //     TextField(
      //       controller: _passwordController,
      //       decoration: InputDecoration(labelText: 'Password'),
      //       obscureText: true,
      //     ),
      //     SizedBox(height: 16.0),
      //     ElevatedButton(
      //       onPressed: _signInWithEmailAndPassword,
      //       child: Text('Login'),
      //     ),
      //     ElevatedButton(
      //       onPressed: () {
      //         Navigator.pushNamed(context, '/register');
      //       },
      //       child: Text('Register'),
      //     )
      //   ],
      // ),
      child: child,
    );
  }
}