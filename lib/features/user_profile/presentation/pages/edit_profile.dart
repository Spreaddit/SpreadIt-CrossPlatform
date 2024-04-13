
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/image_picker.dart';
import '../../../Account_Settings/presentation/widgets/switch_type_1.dart';
import '../../../generic_widgets/custom_input.dart';
import '../../../generic_widgets/snackbar.dart';
import '../../data/update_user_info.dart';
import '../widgets/icon_picker.dart';
import '../widgets/social_link_bottom_sheet_model.dart';
import '../widgets/social_media_button.dart';
import '../widgets/social_media_selection_bottom_sheet.dart';

/// This file defines the EditProfilePage, which allows users to edit their profile details.
/// It includes functionality for updating display name, about section, profile image,
/// background image, social media links, and other settings.

/// EditProfilePage is a StatefulWidget representing the page for editing user profile.
class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

/// State class for EditProfilePage widget.
class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> _displaynameForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _aboutForm = GlobalKey<FormState>();
  var _about = '';
  var _displayname = '';
  bool _switchValue1 = false;
  bool _switchValue2 = false;
  String? backgroundImageURl = '';
  String? profileImageURl = '';
  File? backgroundImageFile;
  File? profileImageFile;
  List<Map<String, dynamic>>? socialMediaLinks;
  bool _socialMediaLinksLoaded = false;
  var validUserName = true;
  var invalidText = "";
  Uint8List? imageProfileWeb;
  Uint8List? imageBackgroundWeb;

  /// passing the arguments from the user profile page
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_socialMediaLinksLoaded) {
      final Map<String, dynamic> args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      socialMediaLinks =
          List<Map<String, dynamic>>.from(args['socialMediaLinks']);
      _socialMediaLinksLoaded = true;
      backgroundImageURl = args['backgroundImageUrl'];
      backgroundImageFile = args['backgroundImageFile'];
      profileImageURl = args['profileImageUrl'];
      profileImageFile = args['profileImageFile'];
      imageProfileWeb = args['profileImageWeb'];
      imageBackgroundWeb = args['backgroundImageWeb'];
      _about = args['about'];
      _displayname = args['displayname'];
    }
  }

  /// Updates the display name with the provided [username].
  ///
  /// The [validation] parameter indicates whether the update should trigger validation checks.
  void updateDisplayname(String username, bool validation) {
    _displayname = username;
    _displaynameForm.currentState?.save();
  }

  /// Updates the about section with the provided [about] text.
  ///
  /// The [validation] parameter indicates whether the update should trigger validation checks.
  void updateAbout(String about, bool validation) {
    _about = about;
    _aboutForm.currentState?.save();
  }

  /// Shows a bottom sheet for selecting social media platforms.
  ///
  /// This function opens a modal bottom sheet where users can select a social media platform
  /// and then choose specific details for the selected platform.
  ///
  /// Once a platform is selected, the function adds the selected social media link to the list
  /// of social media links displayed on the page.
  ///
  /// [context]: The build context.
  void _showSocialMediaSelectionBottomSheet(BuildContext context) async {
    // Show modal bottom sheet for selecting a social media platform
    final selectedPlatform = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      builder: (context) => SocialMediaSelectionBottomSheet(),
    );

    if (selectedPlatform != null) {
      /// Show modal bottom sheet for selecting platform details
      final selectedPlatforminfo =
          await showModalBottomSheet<Map<String, dynamic>>(
        context: context,
        isScrollControlled: true,
        builder: ((context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SocialMediaBottomSheet(
              platformName: selectedPlatform['platformName'],
              icon: selectedPlatform['icon'],
              color: selectedPlatform['color'],
            ),
          );
        }),
      );
      if (selectedPlatforminfo != null) {
        /// Add the selected social media link to the list
        var links = [
          {
            'platform': selectedPlatforminfo['platform'],
            'displayName': selectedPlatforminfo['displayName'],
            'url': selectedPlatforminfo['url'],
          }
        ];
        if (socialMediaLinks!.length < 5) {
          setState(() {
            socialMediaLinks = [...socialMediaLinks!, ...links];
          });
        } else {
          CustomSnackbar(
                  content: 'Maximum limit of 5 social media links reached.')
              .show(context);
        }
      }
    }
  }

  /// Allows the user to pick a background image.
  ///
  /// This function opens a file picker for selecting a background image.
  /// The selected image is then updated in the UI.
  Future<void> pickBackgroundImage() async {
    var image;
    if (!kIsWeb) {
      image = await pickImageFromFilePicker();
      setState(() {
        if (image != null) {
          backgroundImageURl = null;
          backgroundImageFile = image;
        }
      });
    }
    if (kIsWeb) {
      image = await pickImageFromFilePickerWeb();
      setState(() {
        if (image != null) {
          backgroundImageURl = null;
          imageBackgroundWeb = image;
        }
      });
    }
  }

  /// Allows the user to pick a profile image.
  ///
  /// This function opens a file picker for selecting a profile image.
  /// The selected image is then updated in the UI.
  Future<void> pickProfileImage() async {
    var image;
    if (!kIsWeb) {
      image = await pickImageFromFilePicker();
      setState(() {
        if (image != null) {
          profileImageURl = null;
          profileImageFile = image;
        }
      });
    }
    if (kIsWeb) {
      image = await pickImageFromFilePickerWeb();
      setState(() {
        if (image != null) {
          profileImageURl = null;
          imageProfileWeb = image;
        }
      });
    }
  }

  /// Saves the updated profile details.
  ///
  /// This function sends the updated profile details to the backend API for saving.
  /// It handles scenarios like updating display name, about section, background image,
  /// profile image, social media links, content visibility, and active community display.
  ///
  /// It also handles error scenarios and displays appropriate messages using [CustomSnackbar].
  void saveProfile() async {
    try {
      int statusCode = await updateUserApi(
        displayName: _displayname,
        aboutUs: _about,
        backgroundImage: backgroundImageFile,
        profilePicImage: profileImageFile,
        profileImageWeb: imageProfileWeb,
        backgroundImageUrl: backgroundImageURl,
        backgroundImageWeb: imageBackgroundWeb,
        profilePicImageUrl: profileImageURl,
        socialMedia: socialMediaLinks!,
        contentVisibility: _switchValue1,
        showActiveComments: _switchValue2,
      );

      var data = {
        'backgroundImage': backgroundImageURl,
        'backgroundImageFile': backgroundImageFile,
        'backgroundImageWeb': imageBackgroundWeb,
        'profileImageWeb': imageProfileWeb,
        'profilePicImage': profileImageURl,
        'profileImageFile': profileImageFile,
        'socialMedia': socialMediaLinks,
        'about': _about,
        'displayname': _displayname,
      };
      if (statusCode == 200) {
        Navigator.of(context).pop(data);
      } else if (statusCode == 500) {
        CustomSnackbar(content: 'Server Error').show(context);
      }
    } catch (e) {
      CustomSnackbar(content: 'Error updating: $e').show(context);
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
            onPressed: saveProfile,
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
                horizontal: 10,
                vertical: 10,
              ),
              height: MediaQuery.of(context).size.height,
              child: FractionallySizedBox(
                alignment: Alignment.topCenter,
                heightFactor: kIsWeb ? 0.35 : 0.25,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: selectImage(
                        backgroundImageFile, backgroundImageURl, imageBackgroundWeb),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: kIsWeb ? screenHeight * 0.15 : screenHeight * 0.1,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: pickBackgroundImage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Text(
                      'Change Background',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: kIsWeb
                      ? screenHeight * 0.35 - 40
                      : screenHeight * 0.25 - 40),
              child: Center(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: selectImage(
                              profileImageFile, profileImageURl, imageProfileWeb),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: IconButton(
                              icon: Icon(Icons.add),
                              color: Colors.white,
                              onPressed: () {
                                pickProfileImage();
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
                          formKey: _displaynameForm,
                          onChanged: updateDisplayname,
                          label: 'Display name - optional',
                          placeholder: 'Display name - optional',
                          wordLimit: 30,
                          initialBody: _displayname,
                          tertiaryText:
                              "This will be displayed to viewers of your profile page and does not change your username",
                        ),
                        SizedBox(height: 20),
                        CustomInput(
                          formKey: _aboutForm,
                          onChanged: updateAbout,
                          label: 'About you - optional',
                          placeholder: 'About you - optional',
                          initialBody: _about,
                          height: screenHeight * 0.25,
                          wordLimit: 200,
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Social Links (5 max)',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "People who visit your Spreddit profile will be able to see this",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 8),
                              ElevatedButton.icon(
                                onPressed: () {
                                  _showSocialMediaSelectionBottomSheet(context);
                                },
                                icon: Icon(Icons.add),
                                label: Text('Add Social Media'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 203, 201, 201),
                                  foregroundColor: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            spacing: 10,
                            children: socialMediaLinks!.asMap().entries.map(
                              (entry) {
                                final platformData = entry.value;
                                final platformName = platformData['platform'];
                                final iconName = PlatformIconMapper.getIconData(
                                    platformName);
                                final color =
                                    PlatformIconMapper.getColor(platformName);

                                return SocialMediaButton(
                                  icon: iconName,
                                  text: platformData['displayName'],
                                  iconColor: color,
                                  enableClear: true,
                                  handleSelection: () {
                                    setState(() {
                                      socialMediaLinks!.removeAt(entry.key);
                                    });
                                  },
                                );
                              },
                            ).toList(),
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
