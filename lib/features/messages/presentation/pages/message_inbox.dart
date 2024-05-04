import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/date_to_duration.dart';
import 'package:spreadit_crossplatform/features/messages/data/handle_message_data.dart';
import 'package:spreadit_crossplatform/features/messages/data/message_model.dart';

class MessageInbox extends StatefulWidget {
  const MessageInbox({
    Key? key,
  }) : super(key: key);

  @override
  State<MessageInbox> createState() => _MessageInboxState();
}

class _MessageInboxState extends State<MessageInbox> {
  List<Message> messages = [];

  @override
  void initState() {
    setState(() {});
    fetchMessages();
    super.initState();
  }

  void fetchMessages() async {
    List<Message> fetchedMessages = await getMessages();
    setState(() {
      messages = fetchedMessages;
    });
  }

  @override
  void didUpdateWidget(covariant MessageInbox oldWidget) {
    setState(() {});
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: messages
          .mapIndexed<Widget>(
            (index, message) => _messageTile(
              message: message,
              context: context,
            ),
          )
          .toList(),
    );
  }
}

Widget _messageTile({
  required Message message,
  required BuildContext context,
}) {
  return Opacity(
    opacity: message.isRead ? 1 : 0.7,
    child: ListTile(
      title: Text(
        message.relatedUserOrCommunity,
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
              message.subject,
              maxLines: 3,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              message.content,
              maxLines: 3,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      trailing: Text(dateToDuration(message.time)),
      onTap: () => {
        navigateToMessage(
          context: context,
          messageId: message.id,
        ),
      },
    ),
  );
}

navigateToMessage({
  required BuildContext context,
  required messageId,
}) {}
