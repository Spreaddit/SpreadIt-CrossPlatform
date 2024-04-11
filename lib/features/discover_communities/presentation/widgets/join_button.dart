import 'package:flutter/material.dart';

class JoinButton extends StatefulWidget {
  final String communityName;

  JoinButton({required this.communityName});

  @override
  _JoinButtonState createState() => _JoinButtonState();
}

class _JoinButtonState extends State<JoinButton> {
  bool isJoined = false;
  bool isLoading = false;

  void toggleJoin() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      isJoined = !isJoined;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: toggleJoin,
      style: OutlinedButton.styleFrom(
        backgroundColor:
            isJoined ? Colors.white : const Color.fromRGBO(0, 69, 172, 1.0),
        foregroundColor:
            isJoined ? const Color.fromRGBO(0, 69, 172, 1.0) : Colors.white,
        side:
            BorderSide(color: const Color.fromRGBO(0, 69, 172, 1.0), width: 2),
      ),
      child: isLoading
          ? CircularProgressIndicator(
              color: Colors.blue,
            )
          : Text(isJoined ? 'Joined' : 'Join'),
    );
  }
}
