import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/pages/modtools_page.dart';

class ModtoolsPageBtn extends StatelessWidget {
  ModtoolsPageBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ModtoolsPage()),
        );
      },
      style: TextButton.styleFrom(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        'Mod Tools',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
