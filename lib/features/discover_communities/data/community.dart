import 'package:equatable/equatable.dart';

/// `Community` is a class that represents a community.
///
/// Each community has a name, description, image, members count, background image, and a list of rules.
///
/// The `name`, `membersCount`, and `rules` are required parameters, while `description`, `image`, and `backgroundImage` are optional.
///
/// The `description` defaults to an empty string if not provided.
///
/// The `image` and `backgroundImage` are nullable, which means they can be null.
///
/// The `rules` is a list of strings, and each string represents a rule. The list can contain null values.
///
/// This class extends `Equatable`, which allows to compare instances of `Community` based on their properties.
class Community extends Equatable {
  final String name;
  final String description;
  final String? image;
  final int membersCount;
  final String? backgroundImage;
  final List<String?> rules;

  /// Creates a new instance of `Community`.
  ///
  /// The `name`, `membersCount`, and `rules` parameters must not be null.
  ///
  /// The `description` parameter defaults to an empty string if not provided.
  ///
  /// The `image` and `backgroundImage` parameters can be null.
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
