import 'package:flutter/material.dart';
import '../../../Account_Settings/presentation/widgets/switch_type_1.dart';
import '../../../generic_widgets/custom_input.dart';
import '../widgets/social_link_bottom_sheet_model.dart';
import '../widgets/social_media_selection_bottom_sheet.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> _usernameForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _aboutForm = GlobalKey<FormState>();
  var _about = '';
  var _username = '';
  var _change = false;
  bool _switchValue1 = false;
  bool _switchValue2 = false;

  void updateUsername(String username, bool validation) {
    _username = username;
    _usernameForm.currentState!.save();
    setState(() {
      _change = true;
    });
  }

  void updateAbout(String about, bool validation) {
    _about = about;
    _aboutForm.currentState!.save();
    setState(() {
      _change = true;
    });
  }


void _showSocialMediaSelectionBottomSheet(BuildContext context) async {
  final selectedPlatform = await showModalBottomSheet<Map<String, dynamic>>(
    context: context,
    builder: (context) => SocialMediaSelectionBottomSheet(),
  );

  if (selectedPlatform != null) {
    showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      builder: ((context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
         child: SocialMediaBottomSheet(
          platformName: selectedPlatform['platformName'],
          icon: selectedPlatform['icon'],
          color: selectedPlatform['color'],
        ),
        );
      }),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false, 
      appBar: AppBar(
        title: Text('Edit Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              // Implement save logic
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            child: Text('Save'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: MediaQuery.of(context).size.width * 0.05,
              ),
              height: MediaQuery.of(context).size.height,
              child: FractionallySizedBox(
                alignment: Alignment.topCenter,
                heightFactor: 0.25,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://www.shutterstock.com/blog/wp-content/uploads/sites/5/2020/02/Usign-Gradients-Featured-Image.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.2),
              child: Center(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.14,
                          backgroundImage: NetworkImage(
                            'https://yt3.googleusercontent.com/-CFTJHU7fEWb7BYEb6Jh9gm1EpetvVGQqtof0Rbh-VQRIznYYKJxCaqv_9HeBcmJmIsp2vOO9JU=s900-c-k-c0x00ffffff-no-rj',
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.height * 0.05,
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(Icons.add),
                              color: Colors.white,
                              onPressed: () {
                                // Implement image selection logic
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        CustomInput(
                          formKey: _usernameForm,
                          onChanged: updateUsername,
                          label: 'Display name - optional',
                          placeholder: 'Display name - optional',
                          wordLimit: 30,
                          tertiaryText:
                              "This will be displayed to viewers of your profile page and does not change your username",
                        ),
                        SizedBox(height: 20),
                        CustomInput(
                          formKey: _aboutForm,
                          onChanged: updateAbout,
                          label: 'About you - optional',
                          placeholder: 'About you - optional',
                          height: screenHeight * 0.25,
                          wordLimit: 200,
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              _showSocialMediaSelectionBottomSheet(context);
                            },
                            icon: Icon(Icons.add),
                            label: Text('Add Social Media'),
                          ),
                        ),
                        SizedBox(height: 20),
                        SwitchBtn1(
                          currentLightVal: _switchValue1,
                          mainText: "Content Visibility",
                          onPressed: () {
                            setState(() {
                              _switchValue1 = !_switchValue1;
                            });
                          },
                          tertiaryText:
                              "All posts to this profile will appear in r/all and your profile can be discovered in /users",
                        ),
                        SwitchBtn1(
                          currentLightVal: _switchValue2,
                          mainText: "Show active communities",
                          onPressed: () {
                            setState(() {
                              _switchValue2 = !_switchValue2;
                            });
                          },
                          tertiaryText:
                              "Decide whether to show the communities you are active in on your profile",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
