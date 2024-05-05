class MessageModel {
  MessageRepliesModel primaryMessage;
  List<MessageRepliesModel>? replies;

  MessageModel({
    required this.primaryMessage,
    required this.replies,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      primaryMessage: MessageRepliesModel.fromJson(json),
      replies: [],
    );
  }

  addReplies(Map<String, dynamic> replyJson) {
    replies!.add(
      MessageRepliesModel.fromJson(
        replyJson,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': primaryMessage.id,
      'conversationId': primaryMessage.conversationId,
      'senderType': primaryMessage.senderType,
      'relatedUserOrCommunity': primaryMessage.relatedUserOrCommunity,
      'type': primaryMessage.type,
      'content': primaryMessage.content,
      'time': primaryMessage.time.toIso8601String(),
      'direction': primaryMessage.direction,
      'isRead': primaryMessage.isRead,
      'isDeleted': primaryMessage.isDeleted,
      'subject': primaryMessage.subject,
    };
  }
}

class MessageRepliesModel {
  String id;
  String conversationId;
  String senderType;
  String relatedUserOrCommunity;
  String type;
  String content;
  DateTime time;
  String direction;
  bool isRead;
  bool isDeleted;
  String subject;

  MessageRepliesModel({
    required this.id,
    required this.conversationId,
    required this.senderType,
    required this.relatedUserOrCommunity,
    required this.type,
    required this.content,
    required this.time,
    required this.direction,
    required this.isRead,
    required this.isDeleted,
    required this.subject,
  });

  factory MessageRepliesModel.fromJson(Map<String, dynamic> json) {
    return MessageRepliesModel(
      id: json['_id'],
      conversationId: json['conversationId'],
      senderType: json['senderType'],
      relatedUserOrCommunity: json['relatedUserOrCommunity'],
      type: json['type'],
      content: json['content'],
      time: DateTime.parse(json['time']),
      direction: json['direction'],
      isRead: json['isRead'],
      isDeleted: json['isDeleted'],
      subject: json['subject'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'conversationId': conversationId,
      'senderType': senderType,
      'relatedUserOrCommunity': relatedUserOrCommunity,
      'type': type,
      'content': content,
      'time': time.toIso8601String(),
      'direction': direction,
      'isRead': isRead,
      'isDeleted': isDeleted,
      'subject': subject,
    };
  }
}
