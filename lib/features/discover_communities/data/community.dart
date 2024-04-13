import 'package:equatable/equatable.dart';

class Community extends Equatable {
  final String name;
  final String description;
  final String? image;
  final int membersCount;
  final String? backgroundImage;
  final List<String?> rules;

  Community({
    required this.name,
    this.description = '',
    this.image,
    required this.membersCount,
    this.backgroundImage,
    required this.rules,
  });

  Community.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'],
        rules = List<String?>.from(json['rules'] ?? []),
        image = json['image'] ??
            "https://i.pinimg.com/200x/16/ed/ff/16edfff4cfc69f8c58054793e2947aa0.jpg",
        membersCount = json['membersCount'],
        backgroundImage = json['communityBanner'] ??
            "https://i.pinimg.com/200x/16/ed/ff/16edfff4cfc69f8c58054793e2947aa0.jpg";

  @override
  List<Object?> get props => [
        name,
        description,
        image,
        membersCount,
      ];
}
