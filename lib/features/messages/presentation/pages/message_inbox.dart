import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/date_to_duration.dart';
import 'package:spreadit_crossplatform/features/messages/data/handle_message_data.dart';
import 'package:spreadit_crossplatform/features/messages/data/message_model.dart';
import 'package:spreadit_crossplatform/features/messages/presentation/pages/message_page.dart';

// TODO: https://pub.dev/packages/badges (unread messages)

class MessageInbox extends StatefulWidget {
  final bool isAllRead;

  const MessageInbox({
    Key? key,
    this.isAllRead = false,
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

  void fetchMessages() async {
    setState(() {
      isLoading = true;
    });
    List<MessageModel> fetchedMessages = await getMessages();
    setState(() {
      messages = fetchedMessages;
      isLoading = false;
    });
  }

  @override
  void didUpdateWidget(covariant MessageInbox oldWidget) {
    if (widget.isAllRead == true) {
      for (var message in messages) {
        setState(() {
          message.primaryMessage.isRead = true;
        });
      }
    }
    super.didUpdateWidget(oldWidget);
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
              children: messages.mapIndexed<Widget>(
                (index, message) {
                  return Slidable(
                    key: ValueKey(index),
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          flex: 1,
                          onPressed: (context) {
                            handleReadMessages(
                              shouldRead: !message.primaryMessage.isRead,
                              messageId: message.primaryMessage.id,
                            );
                            setState(() {
                              messages[index].primaryMessage.isRead =
                                  !messages[index].primaryMessage.isRead;
                            });
                          },
                          backgroundColor: Color.fromARGB(255, 179, 179, 179),
                          foregroundColor: Colors.white,
                          icon: message.primaryMessage.isRead
                              ? Icons.mark_chat_unread_outlined
                              : Icons.mark_chat_read_outlined,
                          label:
                              message.primaryMessage.isRead ? "Unread" : "Read",
                        ),
                      ],
                    ),
                    child: MessageTile(
                      message: message,
                    ),
                  );
                },
              ).toList(),
            ),
    );
  }
}

class MessageTile extends StatefulWidget {
  final MessageModel message;

  const MessageTile({
    required this.message,
  });

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  late MessageModel message;
  @override
  void initState() {
    message = widget.message;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateToMessage(
          context: context,
          message: widget.message,
        );
        if (!widget.message.primaryMessage.isRead) {
          handleReadMessages(
            shouldRead: true,
            messageId: widget.message.primaryMessage.id,
          );
        }
        setState(() {
          widget.message.primaryMessage.isRead = true;
        });
      },
      child: Opacity(
        opacity: widget.message.primaryMessage.isRead ? 0.7 : 1,
        child: ListTile(
          title: Text(
            widget.message.primaryMessage.relatedUserOrCommunity,
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
            dateToDuration(
              widget.message.primaryMessage.time,
            ),
          ),
          onTap: () => {
            navigateToMessage(
              context: context,
              message: widget.message,
            ),
          },
        ),
      ),
    );
  }
}

navigateToMessage({
  required BuildContext context,
  required MessageModel message,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      settings: RouteSettings(
        name: '/message/${message.primaryMessage.id}',
      ),
      builder: (context) => MessagePage(
        message: message,
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