class Message {
  final String messageId;
  final String related;
  final String subject;
  final String content;
  final DateTime sentTime;

  Message({
    required this.messageId,
    required this.related,
    required this.subject,
    required this.content,
    required this.sentTime,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      messageId: json['messageId'],
      related: json['related'],
      subject: json['subject'],
      content: json['content'],
      sentTime: DateTime.parse(json['sent-time']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'messageId': messageId,
      'related': related,
      'subject': subject,
      'content': content,
      'sent-time': sentTime.toIso8601String(),
    };
  }
}
