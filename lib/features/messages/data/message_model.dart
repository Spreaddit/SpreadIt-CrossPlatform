class Message {
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

  Message({
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

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
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
