import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/chat/data/chatroom_model.dart';
import 'package:spreadit_crossplatform/features/chat/presentation/widgets/navigate_to_chat.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/theme/theme.dart';
import 'package:spreadit_crossplatform/user_info.dart';
import 'package:textfield_tags/textfield_tags.dart';

// String userId = UserSingleton().user!.firebaseId;
String userId = 'KMmoAXLiVc9UBl0rNqTO';

class NewChatPage extends StatefulWidget {
  const NewChatPage({
    Key? key,
  }) : super(key: key);

  @override
  State<NewChatPage> createState() => _NewChatPageState();
}

class _NewChatPageState extends State<NewChatPage> {
  late double _distanceToField;
  late _UsernameTagController usernameController;
  String groupName = '';

  void startNewChat(List<UserData> tags) async {
    CollectionReference chatrooms =
        FirebaseFirestore.instance.collection('chatrooms');

    if (tags.length > 1 && groupName == '') {
      CustomSnackbar(content: "Please choose a group name to start chatting ")
          .show(context);
      return;
    }

    List<String> users = [userId];
    Map<String, dynamic> usersData = {};

    tags.map(
      (tag) {
        users.add(tag.id!);
        Map<String, dynamic> subMap = {
          'avatarUrl': tag.avatarUrl,
          'email': tag.email,
          'id': tag.id,
          'name': tag.name,
        };
        usersData[tag.id!] = subMap;
      },
    );

    Map<String, dynamic> chatroomMap = {
      "groupName": groupName,
      "lastMessage": null,
      "timestamp": DateTime.now() as Timestamp,
      "users": users,
      "usersData": usersData,
    };
    chatrooms.add(chatroomMap).then((value) {
      Navigator.pop(context);
      navigateToChat(context, value.id);
    }).catchError((error) {
      CustomSnackbar(content: "Failed to start a new chatroom").show(context);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void initState() {
    super.initState();
    usernameController = _UsernameTagController();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
  }

  String? validationMessage;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> usernameValidator(
    String? tag,
    void Function(UserData val) onTagSubmitted,
  ) async {
    if (tag == null) return;
    QuerySnapshot querySnapshot = await users
        .where('name', isEqualTo: tag)
        .where('name', isNotEqualTo: UserSingleton().user!.username)
        .get();

    if (querySnapshot.docs.isEmpty) {
      print("invalid tag");
      setState(() {
        validationMessage = "username not found";
      });
    } else {
      setState(() {
        validationMessage = null;
      });
      print("valid tag");
    }

    onTagSubmitted(
      validationMessage == null
          ? UserData(
              id: querySnapshot.docs[0].id,
              name: querySnapshot.docs[0]['name'],
              email: querySnapshot.docs[0]['email'],
              avatarUrl: querySnapshot.docs[0]['avatarUrl'],
            )
          : UserData(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "New Chat",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFieldTags<UserData>(
              textfieldTagsController: usernameController,
              initialTags: [],
              validator: (UserData tag) {
                return validationMessage;
              },
              inputFieldBuilder: (context, inputFieldValues) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    controller: inputFieldValues.textEditingController,
                    focusNode: inputFieldValues.focusNode,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: redditOrange,
                          width: 3.0,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: redditOrange,
                          width: 3.0,
                        ),
                      ),
                      helperText: 'Enter username...',
                      helperStyle: const TextStyle(
                        color: redditOrange,
                      ),
                      hintText: inputFieldValues.tags.isNotEmpty
                          ? ''
                          : "Enter username...",
                      errorText: inputFieldValues.error,
                      prefixIconConstraints:
                          BoxConstraints(maxWidth: _distanceToField * 0.74),
                      prefixIcon: inputFieldValues.tags.isNotEmpty
                          ? SingleChildScrollView(
                              controller: inputFieldValues.tagScrollController,
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                    children:
                                        inputFieldValues.tags.map((tagData) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                      color: redditOrange,
                                    ),
                                    margin: const EdgeInsets.only(right: 10.0),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 4.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          child: Text(
                                            'u/${tagData.name}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 4.0),
                                        InkWell(
                                          child: const Icon(
                                            Icons.cancel,
                                            size: 14.0,
                                            color: Color.fromARGB(
                                                255, 233, 233, 233),
                                          ),
                                          onTap: () {
                                            inputFieldValues
                                                .onTagRemoved(tagData);
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                }).toList()),
                              ),
                            )
                          : null,
                    ),
                    onSubmitted: (value) {
                      try {
                        usernameValidator(
                          value,
                          inputFieldValues.onTagSubmitted,
                        );
                      } on FormatException catch (_) {
                        usernameController.setError =
                            "Must enter correct username";
                      }
                    },
                  ),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            if (usernameController.getTags != null &&
                usernameController.getTags!.length > 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter group name';
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) => setState(() {
                    groupName = value;
                  }),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: redditOrange,
                        width: 3.0,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: redditOrange,
                        width: 3.0,
                      ),
                    ),
                    helperText: 'Enter username...',
                    helperStyle: const TextStyle(
                      color: redditOrange,
                    ),
                    hintText: 'Enter chatroom name',
                    errorText: 'Please choose a group name',
                    prefixIconConstraints:
                        BoxConstraints(maxWidth: _distanceToField * 0.74),
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: redditOrange,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  "Start Chat",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UsernameTagController<T extends UserData>
    extends TextfieldTagsController<T> {
  @override
  bool? onTagSubmitted(T tag) {
    String? validate = getValidator != null ? getValidator!(tag) : null;
    getTextEditingController?.clear();
    getFocusNode?.requestFocus();
    if (validate == null) {
      List<T>? tags = getTags;
      bool isDuplicate =
          tags?.any((tagElement) => tag.name == tagElement.name) ?? false;
      if (isDuplicate) {
        super.setError = 'Username was already entered';
      } else {
        bool? addTag = super.addTag(tag);
        if (addTag == true) {
          setError = null;
          scrollTags();
        }
      }
    } else {
      super.setError = 'Username does not exist';
    }
    notifyListeners();
    return null;
  }

  @override
  set setError(String? error) {
    super.setError = error;
    getTextEditingController?.clear();
    getFocusNode?.requestFocus();
    notifyListeners();
  }
}
