import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/date_to_duration.dart';
import 'package:spreadit_crossplatform/features/messages/data/handle_message_data.dart';
import 'package:spreadit_crossplatform/features/messages/data/message_model.dart';

// TODO: https://pub.dev/packages/badges (unread messages)


class MessageInbox extends StatefulWidget {
  const MessageInbox({
    Key? key,
  }) : super(key: key);

  @override
  State<MessageInbox> createState() => _MessageInboxState();
}

class _MessageInboxState extends State<MessageInbox> {
  List<Message> messages = [];
  bool isLoading = true;

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
    List<Message> fetchedMessages = await getMessages();
    setState(() {
      messages = fetchedMessages;
      isLoading = false;
    });
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
              children: messages
                  .mapIndexed<Widget>(
                    (index, message) => _messageTile(
                      message: message,
                      context: context,
                    ),
                  )
                  .toList(),
            ),
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
