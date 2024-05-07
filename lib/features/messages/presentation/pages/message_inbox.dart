import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/date_to_duration.dart';
import 'package:spreadit_crossplatform/features/messages/data/handle_message_data.dart';
import 'package:spreadit_crossplatform/features/messages/data/message_model.dart';
import 'package:spreadit_crossplatform/features/messages/presentation/pages/message_page.dart';

// TODO: https://pub.dev/packages/badges (unread messages)

MessageRepliesModel getLastMessage(MessageModel message) {
  if (message.replies!.isEmpty) {
    return message.primaryMessage;
  } else {
    return message.replies![message.replies!.length - 1];
  }
}

class MessageInbox extends StatefulWidget {
  final bool isAllRead;
  final MessageModel? newMessage;
  final void Function(MessageModel message) setNewMessage;

  const MessageInbox({
    Key? key,
    this.isAllRead = false,
    required this.newMessage,
    required this.setNewMessage,
  }) : super(key: key);

  @override
  State<MessageInbox> createState() => _MessageInboxState();
}

class _MessageInboxState extends State<MessageInbox> {
  List<MessageModel> messages = [];
  bool isLoading = true;
  bool isAllRead = false;

  @override
  void initState() {
    setState(() {});
    fetchMessages();
    super.initState();
  }

  void fetchMessages({bool shouldLoad = true}) async {
    if (shouldLoad) {
      setState(() {
        isLoading = true;
      });
    }

    List<MessageModel> fetchedMessages = await getMessages();
    setState(() {
      messages = fetchedMessages;
      isLoading = false;
    });
  }

  @override
  void didUpdateWidget(covariant MessageInbox oldWidget) {
    if (widget.newMessage != oldWidget.newMessage &&
        widget.newMessage != null) {
      setState(() {
        messages = [...messages, widget.newMessage!];
      });
      fetchMessages(shouldLoad: false);
    } else if (widget.isAllRead == true) {
      for (int i = 0; i < messages.length; i++) {
        handleReadConversation(messages[i], i, true);
      }
    }

    super.didUpdateWidget(oldWidget);
  }

  bool isReadHandling(MessageModel message) {
    MessageRepliesModel lastMessage = getLastMessage(message);
    return lastMessage.isRead || lastMessage.direction == "outgoing";
  }

  void handleReadConversation(
    MessageModel message,
    int index,
    bool shouldRead,
  ) {
    if (message.primaryMessage.direction == "incoming" &&
        message.primaryMessage.isRead != shouldRead) {
      handleReadMessages(
        shouldRead: !message.primaryMessage.isRead,
        messageId: message.primaryMessage.id,
      );
      setState(() {
        messages[index].primaryMessage.isRead = shouldRead;
      });
    }

    if (message.replies!.isEmpty) return;

    for (int i = 0; i < message.replies!.length; i++) {
      var messageReply = message.replies![i];
      if (messageReply.direction == "incoming" &&
          messageReply.isRead != shouldRead) {
        handleReadMessages(
          shouldRead: shouldRead,
          messageId: messageReply.id,
        );

        setState(() {
          messages[index].replies![i].isRead = shouldRead;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: isLoading
          ? _buildShimmerLoading()
          : ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: messages.mapIndexed<Widget>((index, message) {
                MessageRepliesModel lastMessage = getLastMessage(message);
                if (lastMessage.direction == "outgoing") {
                  return MessageTile(
                    message: message,
                    isRead: isReadHandling(message),
                    handleReadConversation: handleReadConversation,
                    index: index,
                    setNewMessage: widget.setNewMessage,
                  );
                }
                return Slidable(
                  key: ValueKey(index),
                  endActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        flex: 1,
                        onPressed: (context) {
                          handleReadConversation(
                            message,
                            index,
                            !lastMessage.isRead,
                          );
                        },
                        backgroundColor: Color.fromARGB(255, 179, 179, 179),
                        foregroundColor: Colors.white,
                        icon: message.primaryMessage.isRead
                            ? Icons.mark_chat_unread_outlined
                            : Icons.mark_chat_read_outlined,
                        label: isReadHandling(message) ? "Unread" : "Read",
                      ),
                    ],
                  ),
                  child: MessageTile(
                    message: message,
                    isRead: isReadHandling(message),
                    handleReadConversation: handleReadConversation,
                    index: index,
                    setNewMessage: widget.setNewMessage,
                  ),
                );
              }).toList(),
            ),
    );
  }
}

class MessageTile extends StatefulWidget {
  final MessageModel message;
  final bool isRead;
  final int index;
  final void Function(MessageModel message) setNewMessage;

  final void Function(
    MessageModel message,
    int index,
    bool shouldRead,
  ) handleReadConversation;

  const MessageTile({
    required this.message,
    required this.isRead,
    required this.handleReadConversation,
    required this.index,
    required this.setNewMessage,
  });

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MessageRepliesModel lastMessage = getLastMessage(widget.message);
    return Opacity(
      opacity: widget.isRead ? 0.7 : 1,
      child: ListTile(
        title: Text(
          lastMessage.relatedUserOrCommunity,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Align(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.message.primaryMessage.subject,
                maxLines: 3,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                widget.message.primaryMessage.content,
                maxLines: 3,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        trailing: Text(
          "${lastMessage.direction} • ${dateToDuration(
            lastMessage.time,
          )}",
        ),
        onTap: () {
          widget.handleReadConversation(
            widget.message,
            widget.index,
            true,
          );

          navigateToMessage(
            context: context,
            message: widget.message,
            setNewMessage: widget.setNewMessage,
          );
        },
      ),
    );
  }
}

navigateToMessage({
  required BuildContext context,
  required MessageModel message,
  required void Function(MessageModel message) setNewMessage,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      settings: RouteSettings(
        name: '/message/${message.primaryMessage.id}',
      ),
      builder: (context) => MessagePage(
        message: message,
        setNewMessage: setNewMessage,
      ),
    ),
  );
}

Widget _buildShimmerLoading() {
  return Column(
    children: [
      Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        period: Duration(milliseconds: 1000),
        child: Column(
          children: List.generate(
            10,
            (index) => Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Container(
                      width: double.infinity,
                      height: 25.0,
                      color: Colors.white,
                    ),
                    subtitle: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 15.0,
                          color: Colors.white,
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          height: 10.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
