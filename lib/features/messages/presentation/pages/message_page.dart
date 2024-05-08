import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/date_to_duration.dart';
import 'package:spreadit_crossplatform/features/messages/data/message_model.dart';
import 'package:spreadit_crossplatform/features/messages/presentation/pages/message_inbox.dart';
import 'package:spreadit_crossplatform/features/messages/presentation/widgets/new_message.dart';
import 'package:spreadit_crossplatform/user_info.dart';

/// Constructor for MessagePage.
///
/// Example:
/// ```dart
/// MessagePage(
///   message: message,
///   setNewMessage: (message) {
///     // Handle setting the new message here
///   },
/// );
/// ```
class MessagePage extends StatefulWidget {
  final MessageModel message;
  final void Function(MessageModel message) setNewMessage;

  MessagePage({
    Key? key,
    required this.message,
    required this.setNewMessage,
  }) : super(
          key: key,
        );

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late MessageModel message;
  @override
  void initState() {
    setState(() {
      message = widget.message;
    });
    super.initState();
  }

  void setNewMessageInner(MessageModel newMessage) {
    MessageRepliesModel newMessageReply = newMessage.primaryMessage;
    setState(() {
      message.replies = [
        ...message.replies!,
        newMessageReply,
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          color: const Color.fromARGB(255, 218, 218, 218),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  MessageReplyTile(
                    message: widget.message.primaryMessage,
                  ),
                  ListView(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: widget.message.replies != null &&
                            widget.message.replies!.isNotEmpty
                        ? widget.message.replies!
                            .map<Widget>(
                              (message) => MessageReplyTile(
                                message: message,
                              ),
                            )
                            .toList()
                        : [],
                  ),
                ],
              ),
            ),
          )),
      bottomSheet: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  showSendMessage(
                    context: context,
                    messageId: getLastMessage(widget.message).id,
                    setNewMessage: widget.setNewMessage,
                    setNewMessageInner: setNewMessageInner,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.grey,
                  padding: EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  "Reply To Message",
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

/// MessageReplyTile.
///
/// Example:
/// ```dart
/// MessageReplyTile(
///   message: message,
/// );
/// ```

class MessageReplyTile extends StatefulWidget {
  final MessageRepliesModel message;

  const MessageReplyTile({
    required this.message,
  });

  @override
  State<MessageReplyTile> createState() => _MessageReplyTileState();
}

class _MessageReplyTileState extends State<MessageReplyTile> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        alignment: Alignment.topLeft,
        color: Colors.grey,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        iconSize: 20,
        icon: Icon(
          isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
        ),
        onPressed: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
      ),
      contentPadding: EdgeInsets.all(0),
      titleAlignment: ListTileTitleAlignment.top,
      title: Text(
        "${widget.message.direction == "outgoing" ? UserSingleton().user!.username : widget.message.relatedUserOrCommunity} • ${dateToDuration(widget.message.time)}",
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
      subtitle: isExpanded
          ? Container(
              color: Colors.white,
              child: Text(
                widget.message.content,
                textAlign: TextAlign.left,
              ),
            )
          : null,
    );
  }
}
