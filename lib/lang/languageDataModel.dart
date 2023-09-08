// class LanguageData {
//   final int id;
//   final Map<String, dynamic> language;

//   LanguageData({
//     required this.id,
//     required this.language,
//   });

//   factory LanguageData.fromJson(Map<String, dynamic> json) {
//     return LanguageData(
//       id: json['id'],
//       language: json['language'],
//     );
//   }
// }

// class LanguageData {
//   final int id;
//   final Map<String, Map<String, String>> languages;

//   LanguageData({
//     required this.id,
//     required this.languages,
//   });

//   factory LanguageData.fromJson(Map<String, dynamic> json) {
//     Map<String, Map<String, String>> languages;

//     if (json['languages'] != null) {
//       languages = Map<String, Map<String, String>>.from(json['languages']);
//     } else {
//       languages = {};
//     }

//     return LanguageData(
//       id: json['id'],
//       languages: languages,
//     );
//   }
// }

class LanguageData {
  final Map<String, Map<String, String>> language;

  LanguageData({required this.language});

  factory LanguageData.fromJson(Map<String, dynamic> json) {
    final languageMap = json['language'] as Map<String, dynamic>;
    final languageData = Map<String, Map<String, String>>.from(
      languageMap.map((key, value) {
        return MapEntry(
          key,
          Map<String, String>.from(value as Map<String, dynamic>),
        );
      }),
    );
    return LanguageData(language: languageData);
  }
}
