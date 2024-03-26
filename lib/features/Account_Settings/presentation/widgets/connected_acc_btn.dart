import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/pages/confirm_connected_acc_page.dart';
import '../../data/data_source/api_basic_settings_data.dart';
import '../../../Sign_up/data/oauth_service.dart';

/// A button widget used for connecting or disconnecting from the connected accounts experience.
class ConnectAccBtn extends StatefulWidget {
  /// Creates a button widget for connecting or disconnecting an account.
  ///
  /// Parameters:
  /// - [iconData] : [IconData] The icon data for the account [required].
  /// - [accountName] : [String] The name of the account [required].
  const ConnectAccBtn({
    Key? key,
    required this.iconData,
    required this.accountName,
  }) : super(key: key);

  final IconData iconData;
  final String accountName;

  @override
  State<ConnectAccBtn> createState() => ConnectAccBtnState();
}

/// [ConnectAccBtn] state.
class ConnectAccBtnState extends State<ConnectAccBtn> {
  /// Represents the current action for connection.
  var _connectionAction = "Connect";

  /// Holds fetched user info data.
  late Map<String, dynamic> data;

  /// Represents the email address of the connected account.
  String connectedEmail = "";

  /// Calls the [fetchData] method to fetch user information.
  @override
  void initState() {
    super.initState();
    setState(() {
      fetchData();
    });
  }

  /// Fetches data about the connected account.
  Future<void> fetchData() async {
    data = await getBasicData(); // Await the result of getData()
    setState(() {
      connectedEmail = data["connectedAccounts"][0];
      _connectionAction = (connectedEmail == "") ? "Connect" : "Disconnect";
    });
  }

  @override
  Widget build(BuildContext context) {
    IconData newIconData =
        (connectedEmail == "") ? widget.iconData : Icons.account_circle;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(
                  newIconData,
                  color: Color.fromARGB(255, 136, 136, 136),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.accountName,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (_connectionAction == "Disconnect")
                    Text(
                      connectedEmail,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey,
                      ),
                    ),
                ],
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
              onPressed: () async {
                var accessToken = "";
                var result = false;
                if (_connectionAction == "Connect") {
                  accessToken = await signInWithGoogle(context);
                } else {
                  result = await signOutWithGoogle(context);
                }
                if (accessToken.isNotEmpty || result != false) {
                  await Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 200),
                      reverseTransitionDuration: Duration(milliseconds: 100),
                      pageBuilder: (_, __, ___) => ConfirmConnectedPassword(
                        connectionAction: _connectionAction,
                      ),
                      transitionsBuilder: (_, animation, __, child) {
                        return ScaleTransition(
                          scale: Tween<double>(begin: 0.95, end: 1.0).animate(
                            CurvedAnimation(
                              parent: animation,
                              curve: Curves.fastOutSlowIn,
                            ),
                          ),
                          child: child,
                        );
                      },
                    ),
                  );
                }
                fetchData();
              },
            ),
          ),
        ],
      ),
    );
  }
}
