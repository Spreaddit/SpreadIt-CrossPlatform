import 'package:equatable/equatable.dart';

class Community extends Equatable {
  final String name;
  final String description;
  final String? image;
  final int membersCount;
  final String? backgroundImage;
  final List<Rule?>? rules;

  Community({
    required this.name,
    required this.description,
    this.image,
    required this.membersCount,
    this.backgroundImage,
    this.rules,
  });

  Community.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'],
        image = json['image'] ??
            "https://i.pinimg.com/200x/16/ed/ff/16edfff4cfc69f8c58054793e2947aa0.jpg",
        membersCount = json['membersCount'],
        backgroundImage = json['communityBanner'] ??
            "https://i.pinimg.com/200x/16/ed/ff/16edfff4cfc69f8c58054793e2947aa0.jpg",
        rules = (json['rules'] as List<dynamic>)
            .map((ruleJson) => Rule.fromJson(ruleJson))
            .toList();

  @override
  List<Object?> get props => [
        name,
        description,
        image,
        membersCount,
        backgroundImage,
        rules,
      ];
}

class Rule {
  final String id;
  final String title;
  final String description;
  final String reportReason;
  final String communityName;

  Rule({
    required this.id,
    required this.title,
    required this.description,
    required this.reportReason,
    required this.communityName,
  });

  factory Rule.fromJson(Map<String, dynamic> json) {
    return Rule(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      reportReason: json['reportReason'],
      communityName: json['communityName'],
    );
  }
}
