import 'package:flutter/material.dart';
import 'social_media_button.dart';
import '../../../generic_widgets/custom_input.dart';

class SocialMediaBottomSheetContent extends StatelessWidget {
  final String platformName;
  final IconData icon;
  final Color color;

  SocialMediaBottomSheetContent({
    required this.platformName,
    required this.icon,
    required this.color,
  });

  final GlobalKey<FormState> _displayNameForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _linkForm = GlobalKey<FormState>();
  var _displayName = '';
  var _link = '';

  void updateDisplay(String display, bool validation) {
    _displayName = display;
    _displayNameForm.currentState!.save();
  }

  void updateLink(String link, bool validation) {
    _link = link;
    _linkForm.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'Add Social Media',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, {
                      'headerName': _displayName,
                      'platformName': platformName,
                      'url': _link,
                    });
                  },
                  child: Text('Save'),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.all(8.0), 
                  child: SocialMediaButton(
                    icon: icon,
                    text: platformName,
                    backgroundColor: color,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            CustomInput(
              formKey: _displayNameForm,
              onChanged: updateDisplay,
              label: 'Display Text',
              placeholder: 'Display Text',
              backgroundColor: Color.fromRGBO(230, 230, 230, 1),
            ),
            SizedBox(height: 10.0),
            CustomInput(
              formKey: _linkForm,
              onChanged: updateLink,
              label: 'https://website.com',
              placeholder: 'https://website.com',
              backgroundColor: Color.fromRGBO(230, 230, 230, 1),
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}

class SocialMediaBottomSheet extends StatefulWidget {
  final String platformName;
  final IconData icon;
  final Color color;

  SocialMediaBottomSheet({
    required this.platformName,
    required this.icon,
    required this.color,
  });

  @override
  _SocialMediaBottomSheetState createState() => _SocialMediaBottomSheetState();
}

class _SocialMediaBottomSheetState extends State<SocialMediaBottomSheet> {
  late Widget _bottomSheetContent;

  @override
  void initState() {
    super.initState();
    _bottomSheetContent = SocialMediaBottomSheetContent(
      platformName: widget.platformName,
      icon: widget.icon,
      color: widget.color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _bottomSheetContent;
  }
}
