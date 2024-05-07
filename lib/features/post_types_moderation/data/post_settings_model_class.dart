class PostSettings {
  String postTypeOptions;
  bool spoilerEnabled;
  bool multipleImagesPerPostAllowed;
  bool pollsAllowed;
  bool mediaInCommentsAllowed;

  PostSettings({
    required this.postTypeOptions,
    required this.spoilerEnabled,
    required this.multipleImagesPerPostAllowed,
    required this.pollsAllowed,
    required this.mediaInCommentsAllowed,
  });

  factory PostSettings.fromJson(Map<String, dynamic> json) {
    return PostSettings(
      postTypeOptions: json['postTypeOptions'],
      spoilerEnabled: json['spoilerEnabled'],
      multipleImagesPerPostAllowed: json['multipleImagesPerPostAllowed'],
      pollsAllowed: json['pollsAllowed'],
      mediaInCommentsAllowed: json['commentSettings']['mediaInCommentsAllowed'],
    );
  }

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
