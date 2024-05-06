import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/messages/data/message_model.dart';
import 'package:spreadit_crossplatform/features/messages/presentation/widgets/new_message.dart';

enum CurrentPage {
  home,
  discover,
  createPost,
  chat,
  inbox,
  popular,
  all,
  notifications,
  messages,
}

class TopBar extends AppBar {
  final CurrentPage currentPage;
  final BuildContext context;
  final void Function(int)? onChangeHomeCategory;
  final void Function(int)? onChangeChatFilter;
  final void Function()? onReadMessages;
  final Key? key;
  final int? chatFilterSelectedOption;
  final void Function(MessageModel message) setNewMessage;

  TopBar({
    this.currentPage = CurrentPage.home,
    required this.context,
    this.onChangeHomeCategory,
    this.onChangeChatFilter,
    this.key,
    this.onReadMessages,
    this.chatFilterSelectedOption = 3,
    required this.setNewMessage,
  }) : super(
          key: key,
          toolbarHeight: 60,
          backgroundColor: Colors.white,
          elevation: 0,
          title: chooseTitle(
            currentPage,
            onChangeHomeCategory,
          ),
          actions: [
            chooseActions(
              currentPage: currentPage,
              context: context,
              onChangeChatFilter: onChangeChatFilter,
              onReadMessages: onReadMessages!,
              chatFilterSelectedOption: chatFilterSelectedOption,
              setNewMessage: setNewMessage,
            ),
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              ),
            ),
          ],
          leading: Builder(
            builder: (context) => IconButton(
              onPressed: () {
                if (currentPage == CurrentPage.createPost) {
                  Navigator.of(context).pop();
                } else {
                  Scaffold.of(context).openDrawer();
                }
              },
              icon: Icon(
                currentPage == CurrentPage.createPost
                    ? Icons.arrow_back
                    : Icons.menu,
              ),
            ),
          ),
        );
}

Widget chooseTitle(
  CurrentPage currentPage,
  final void Function(int)? onChangeHomeCategory,
) {
  if (currentPage == CurrentPage.home || currentPage == CurrentPage.popular) {
    return Container(
      alignment: Alignment.topLeft,
      width: 160,
      height: 50,
      decoration: BoxDecoration(
        color: Color.fromARGB(18, 0, 0, 0),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: DropdownButton<CurrentPage>(
        value: currentPage,
        underline: Container(
          height: 0,
          color: Colors.transparent,
        ),
        onChanged: (newValue) {
          onChangeHomeCategory!(newValue!.index);
        },
        items: CurrentPage.values
            .where((category) => category.index == 0 || category.index == 5)
            .map<DropdownMenuItem<CurrentPage>>(
              (newPage) => DropdownMenuItem<CurrentPage>(
                value: newPage,
                child: Text(newPage.toString().split('.').last),
              ),
            )
            .toList(),
      ),
    );
  }
  List<Widget> titles = [
    Center(
      child: Text(
        'Home',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    Center(
      child: Text(
        'Discover',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    Center(
      child: Text(
        'create post',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    Center(
      child: Text(
        'Chat',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    Center(
      child: Text(
        'Inbox',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  ];
  return titles[currentPage.index % 5];
}

Widget chooseActions({
  required CurrentPage currentPage,
  required BuildContext context,
  required final void Function(MessageModel message) setNewMessage,
  required final void Function() onReadMessages,
  int? chatFilterSelectedOption,
  final void Function(int)? onChangeChatFilter,
}) {
  List<Widget> actions = [
    IconButton(
      icon: Icon(Icons.search),
      onPressed: () {},
    ),
    IconButton(
      icon: Icon(Icons.search),
      onPressed: () {},
    ),
    IconButton(
      icon: Icon(Icons.search),
      onPressed: () {},
    ),
    IconButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) => FilteringChatTypeModal(
            onChangeChatFilter: onChangeChatFilter,
            chatFilterSelectedOption: chatFilterSelectedOption,
          ),
        );
      },
      icon: Icon(Icons.filter_list_alt),
    ),
    IconButton(
      icon: Icon(Icons.more_horiz),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) => InboxPageModal(
            onReadMessages: onReadMessages,
            setNewMessage: setNewMessage,
          ),
        );
      },
    ),
    IconButton(
      icon: Icon(Icons.search),
      onPressed: () {},
    ),
  ];
  return actions[currentPage.index % 5];
}

class FilteringChatTypeModal extends StatefulWidget {
  final void Function(int)? onChangeChatFilter;
  final int? chatFilterSelectedOption;

  const FilteringChatTypeModal({
    Key? key,
    this.chatFilterSelectedOption = 3,
    required this.onChangeChatFilter,
  }) : super(key: key);

  @override
  State<FilteringChatTypeModal> createState() => _FilteringChatTypeModalState();
}

class _FilteringChatTypeModalState extends State<FilteringChatTypeModal> {
  List<String> options = ['Direct Chats', 'Group Chats'];
  Set<String> selectedOptions = {};
  late int chatFilterSelectedOption;

  int decideSelectedOption() {
    if (selectedOptions.contains(options[0]) &&
        selectedOptions.contains(options[1])) return 3;
    if (selectedOptions.contains(options[0])) return 1;
    return 2;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      chatFilterSelectedOption = widget.chatFilterSelectedOption!;
      if (chatFilterSelectedOption! >= 2) {
        selectedOptions.add(options[1]);
      }
      if (chatFilterSelectedOption != 2) {
        selectedOptions.add(options[0]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (BuildContext context, int index) {
              final option = options[index];
              return CheckboxListTile(
                title: Text(option),
                value: selectedOptions.contains(option),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      selectedOptions.add(option);
                    } else {
                      selectedOptions.remove(option);
                    }
                  });
                },
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: ElevatedButton(
              onPressed: selectedOptions.isEmpty
                  ? null
                  : () {
                      int selectedOption = decideSelectedOption();
                      if (selectedOption != chatFilterSelectedOption) {
                        setState(() {
                          chatFilterSelectedOption = selectedOption;
                          widget.onChangeChatFilter!(selectedOption);
                        });
                      }
                      print("Selected options: $selectedOption");
                    },
              child: Text('Apply'),
            ),
          ),
        ],
      ),
    );
  }
}

class InboxPageModal extends StatefulWidget {
  final void Function()? onReadMessages;
  final void Function(MessageModel message) setNewMessage;

  const InboxPageModal({
    Key? key,
    required this.onReadMessages,
    required this.setNewMessage,
  }) : super(key: key);

  @override
  State<InboxPageModal> createState() => _InboxPageModalState();
}

class _InboxPageModalState extends State<InboxPageModal> {
  List<String> options = [
    'New Message',
    'Mark All Inbox Tabs As Read',
    'Edit Notifications Settings',
  ];

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  List<IconData> icons = [
    Icons.post_add,
    Icons.mark_as_unread,
    Icons.settings,
  ];

  void onTap(int index) {
    if (index == 0) {
      Navigator.pop(context);
      showSendMessage(
        context: context,
        setNewMessage: widget.setNewMessage,
      );
    } else if (index == 1) {
      widget.onReadMessages!();
      Navigator.pop(context);
    } else {
      Navigator.of(context)
          .popAndPushNamed("/settings/account-settings/manage-notifications");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(icons[index]),
                title: Text(options[index]),
                onTap: () {
                  onTap(index);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
