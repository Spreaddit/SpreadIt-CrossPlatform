import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/switch_type_1.dart';
import 'package:spreadit_crossplatform/features/post_types_moderation/data/get_allowed_post_settings.dart';
import 'package:spreadit_crossplatform/features/post_types_moderation/data/post_settings_model_class.dart';
import 'package:spreadit_crossplatform/features/post_types_moderation/data/update_allowed_post_settings.dart';
import 'package:spreadit_crossplatform/features/post_types_moderation/presentation/widgets/post_options_widget.dart';

/// A page for managing post types and settings for a community.
class PostTypes extends StatefulWidget {
  /// The name of the community.
  final String communityName;

  /// Constructs a [PostTypes] widget.
  ///
  /// [communityName]: The name of the community.
  const PostTypes({required this.communityName});

  @override
  State<PostTypes> createState() => _PostTypesState();
}

class _PostTypesState extends State<PostTypes> {
  bool isPollsAllowed = false;
  bool isSpoilerEnabled = false;
  bool isMultipleImagesPerPostAllowed = false;
  bool isMediaInCommentsAllowed = false;
  String postOption = 'any';

  /// Fetches the post settings for the community.
  Future<void> getPostSettings() async {
    try {
      var data = await fetchPostSettingsData(widget.communityName);
      print(
          "isPollsAllowed =${data!.pollsAllowed!} isSpoilerEnabled = ${data.spoilerEnabled} isMultipleImagesPerPostAllowed = ${data.multipleImagesPerPostAllowed} isMediaInCommentsAllowed =${data.mediaInCommentsAllowed} postOption = ${data.postTypeOptions}");
      setState(() {
        isPollsAllowed = data.pollsAllowed;
        isSpoilerEnabled = data.spoilerEnabled;
        isMultipleImagesPerPostAllowed = data.multipleImagesPerPostAllowed;
        isMediaInCommentsAllowed = data.mediaInCommentsAllowed;
        postOption = data.postTypeOptions;
      });
    } catch (e) {
      print('Error fetching moderators: $e');
    }
  }

  @override
  void initState() {
    getPostSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Types'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
              onPressed: (() {
                PostSettings updatedSettings = PostSettings(
                    postTypeOptions: postOption,
                    spoilerEnabled: isSpoilerEnabled,
                    multipleImagesPerPostAllowed:
                        isMultipleImagesPerPostAllowed,
                    pollsAllowed: isPollsAllowed,
                    mediaInCommentsAllowed: isMediaInCommentsAllowed);
                updatePostSettings(updatedSettings, widget.communityName);
                 Navigator.pop(context);
              }),
              child: Text('Save')),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PostOptionsBox(
              onOptionSelected: (option) {
                setState(() {
                  postOption = option;
                });
              },
              initialOption: postOption,
            ),
          ),
          Container(
            color: Colors.grey.shade200,
            height: 1,
            margin: EdgeInsets.symmetric(horizontal: 8.0),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SwitchBtn1(
              mainText: 'Polls',
              onPressed: () {
                setState(() {
                  isPollsAllowed = !isPollsAllowed;
                });
              },
              currentLightVal: isPollsAllowed,
              tertiaryText: "Allow polls in your community",
            ),
          ),
        ],
      ),
    );
  }
}
