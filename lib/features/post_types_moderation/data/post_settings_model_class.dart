/// Model class representing post settings for a community.
class PostSettings {
  /// Options for post types.
  String postTypeOptions;

  /// Whether spoilers are enabled.
  bool spoilerEnabled;

  /// Whether multiple images per post are allowed.
  bool multipleImagesPerPostAllowed;

  /// Whether polls are allowed.
  bool pollsAllowed;

  /// Whether media is allowed in comments.
  bool mediaInCommentsAllowed;

  /// Constructs a [PostSettings] instance.
  PostSettings({
    required this.postTypeOptions,
    required this.spoilerEnabled,
    required this.multipleImagesPerPostAllowed,
    required this.pollsAllowed,
    required this.mediaInCommentsAllowed,
  });

  /// Constructs a [PostSettings] instance from JSON data.
  factory PostSettings.fromJson(Map<String, dynamic> json) {
    return PostSettings(
      postTypeOptions: json['postTypeOptions'],
      spoilerEnabled: json['spoilerEnabled'],
      multipleImagesPerPostAllowed: json['multipleImagesPerPostAllowed'],
      pollsAllowed: json['pollsAllowed'],
      mediaInCommentsAllowed: json['commentSettings']['mediaInCommentsAllowed'],
    );
  }

  /// Converts this [PostSettings] instance to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'postTypeOptions': postTypeOptions,
      'spoilerEnabled': spoilerEnabled,
      'multipleImagesPerPostAllowed': multipleImagesPerPostAllowed,
      'pollsAllowed': pollsAllowed,
      'commentSettings': {
        'mediaInCommentsAllowed': mediaInCommentsAllowed,
      },
    };
  }
}
