import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/fail_to_fetch.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/loader/loader_widget.dart';
import 'package:spreadit_crossplatform/features/modtools/data/api_community_info.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/widgets/saving_appbar.dart';

/// Widget to manage community description settings.
class DescriptionPage extends StatefulWidget {
  /// The name of the community.
  final String communityName;

  /// Constructor for [DescriptionPage].
  const DescriptionPage({Key? key, required this.communityName})
      : super(key: key);

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  TextEditingController _textController = TextEditingController();
  Future<Map<String, dynamic>?>? communityInfo;
  bool isTextChanged = false;
  bool initDone = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  /// Fetches community info data.
  void fetchData() async {
    communityInfo = getModCommunityInfo(widget.communityName);
  }

  /// Updates the community description.
  void updateDescription(String description) async {
    int response = await updateModCommunityInfo(widget.communityName,
        description: description);
    if (response == 200) {
      Navigator.pop(context);
      CustomSnackbar(content: "Description updated").show(context);
    } else {
      CustomSnackbar(content: "Error updating description").show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SavingAppBar(
        title: 'Description',
        onSavePressed: isTextChanged
            ? () => updateDescription(_textController.text)
            : null,
      ),
      body: FutureBuilder(
          future: communityInfo,
          builder: (context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: LoaderWidget(
                  dotSize: 10,
                  logoSize: 100,
                ),
              );
            } else if (snapshot.hasError) {
              return FailToFetchPage(
                  displayWidget: Center(
                child: Text("Error fetching data 😔"),
              ));
            } else if (snapshot.hasData) {
              if (!initDone) {
                _textController.text = snapshot.data!['description'] ?? '';
                initDone = true;
              }
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        isTextChanged = true;
                      });
                    },
                    controller: _textController,
                    maxLines: null,
                    maxLength: 500,
                    decoration: InputDecoration(
                      labelText: 'Describe your community',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ),
              );
            } else {
              return FailToFetchPage(
                  displayWidget: Center(
                child: Text("Unknown error fetching data 🤔"),
              ));
            }
          }),
    );
  }
}
