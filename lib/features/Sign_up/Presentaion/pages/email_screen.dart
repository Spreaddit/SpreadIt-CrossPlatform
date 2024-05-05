import 'package:flutter/material.dart';
class EmailSentPage extends StatelessWidget {
  late String email='';

  @override
  Widget build(BuildContext context) {
      final Map<String, dynamic> args =
  ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    email = args['email'];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Verify Your Email',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'You will need to verify your email to complete registration.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 20),
              Icon(
                Icons.email,
                size: 100,
                color: Theme.of(context).colorScheme.tertiary,
              ),
              SizedBox(height: 20),
              Text(
                'An email has been sent to $email with a link to verify your account.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'If you have not received the email after a few minutes, please check your spam folder.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}