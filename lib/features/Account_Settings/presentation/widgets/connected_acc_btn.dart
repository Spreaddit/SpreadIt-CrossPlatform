import 'package:flutter/material.dart';

class ConnectAccBtn extends StatefulWidget {
  const ConnectAccBtn({
    Key? key,
    required this.iconData,
    required this.accountName,
    required this.onPressed,
  }) : super(key: key);

  final IconData iconData;
  final String accountName;
  final Function onPressed;

  @override
  State<ConnectAccBtn> createState() => _ConnectAccBtnState();
}

class _ConnectAccBtnState extends State<ConnectAccBtn> {
  var _connected = false;
  var _connectionAction = "Connect";
  @override
  Widget build(BuildContext context) {
    _connectionAction = _connected ? "Disconnect" : "Connect";
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                widget.iconData,
                color: Color.fromARGB(255, 136, 136, 136),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              widget.accountName,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            style: ButtonStyle(
              overlayColor:
                  MaterialStateProperty.all(Colors.grey.withOpacity(0.5)),
            ),
            child: Text(
              _connectionAction,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 4, 75, 133),
              ),
            ),
            onPressed: () {
              widget.onPressed;
            },
          ),
        ),
      ],
    );
  }
}
