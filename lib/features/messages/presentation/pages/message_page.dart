import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/date_to_duration.dart';
import 'package:spreadit_crossplatform/features/messages/data/message_model.dart';

class MessagePage extends StatefulWidget {
  final MessageModel message;

  MessagePage({
    Key? key,
    required this.message,
  }) : super(
          key: key,
        );

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
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
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
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
      ),
    );
  }
}

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
    return Opacity(
      opacity: widget.message.isRead ? 1 : 0.7,
      child: ListTile(
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
          "${widget.message.relatedUserOrCommunity} • ${dateToDuration(widget.message.time)}",
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
      ),
    );
  }
}
