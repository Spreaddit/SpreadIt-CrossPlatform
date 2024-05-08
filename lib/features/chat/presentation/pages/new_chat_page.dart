import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/chat/data/chatroom_model.dart';
import 'package:spreadit_crossplatform/features/chat/presentation/widgets/navigate_to_chat.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/theme/theme.dart';
import 'package:spreadit_crossplatform/user_info.dart';
import 'package:textfield_tags/textfield_tags.dart';

/// A page for starting a new chat.
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
  TextEditingController _controller = TextEditingController();
  String groupname = '';
  List<UserData> tags = [];

  void startNewChat() async {
    CollectionReference chatrooms =
        FirebaseFirestore.instance.collection('chatrooms');

    if (tags.isEmpty) {
      CustomSnackbar(content: "Please enter a username to start chatting ")
          .show(context);
      return;
    }

    if (tags.length == 1) {
      QuerySnapshot querySnapshot = await chatrooms
          .where('users', arrayContains: tags[0].id)
          .where('groupname', isEqualTo: "")
          .get();

      bool containsUser = querySnapshot.docs.any(
          (element) => element['users'].contains(UserSingleton().firebaseId!));

      if (querySnapshot.docs.isNotEmpty && containsUser) {
        Navigator.pop(context);
        navigateToChat(
          context: context,
          docId: querySnapshot.docs[0].id,
          chatroomName: tags[0].name!,
        );
        return;
      }
    }

    if (tags.length > 1 && groupname == '') {
      CustomSnackbar(content: "Please choose a group name to start chatting ")
          .show(context);
      return;
    }

    List<String> users = [UserSingleton().firebaseId!];

    Map<String, dynamic> usersData = {};
    Map<String, dynamic> subMap = {
      'avatarUrl': UserSingleton().user!.avatarUrl,
      'email': UserSingleton().user!.email,
      'id': UserSingleton().firebaseId!,
      'name': UserSingleton().user!.username,
    };
    usersData[UserSingleton().firebaseId!] = subMap;

    print("tags${tags.toString()}");
    for (int i = 0; i < tags.length; i++) {
      UserData tag = tags[i];
      print("tag:${tag.toString()}");
      users.add(tag.id!);
      Map<String, dynamic> subMap = {
        'avatarUrl': tag.avatarUrl,
        'email': tag.email,
        'id': tag.id,
        'name': tag.name,
      };
      usersData[tag.id!] = subMap;
    }

    Map<String, dynamic> chatroomMap = {
      "groupname": groupname,
      "lastMessage": null,
      "timestamp": Timestamp.fromDate(
        DateTime.now(),
      ),
      "users": users,
      "usersData": usersData,
    };
    print(chatroomMap);
    chatrooms.add(chatroomMap).then((value) {
      Navigator.pop(context);
      navigateToChat(
        context: context,
        docId: value.id,
        chatroomName: groupname,
      );
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

  /// Validates the entered username.
  ///
  /// This function checks if the entered username exists in the database.
  /// If the username exists, it adds it to the list of tags.
  ///
  /// Parameters:
  ///
  /// - `tag`: The username entered by the user.
  /// - `onTagSubmitted`: Callback function to handle the submitted tag.
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
    setState(() {
      tags = usernameController.getTags ?? [];
    });
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
                                            setState(() {
                                              tags =
                                                  usernameController.getTags ??
                                                      [];
                                            });
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
            if (tags.length > 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextFormField(
                  controller: _controller,
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter group name';
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) => setState(() {
                    groupname = value;
                  }),
                  onTapOutside: (event) => setState(() {
                    groupname = _controller.text;
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
                    helperText: 'Enter group name...',
                    helperStyle: const TextStyle(
                      color: redditOrange,
                    ),
                    hintText: 'Enter group name',
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
                onPressed: () {
                  startNewChat();
                },
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
  bool? onTagRemoved(T tag) {
    super.onTagRemoved(tag);
    getTextEditingController?.clear();
    getFocusNode?.requestFocus();
    print(getTags);
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
