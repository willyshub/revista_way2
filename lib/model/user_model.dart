import 'dart:convert';

class UserModel {
  String completeName;
  String college;
  String userName;
  UserModel({
    required this.completeName,
    required this.college,
    required this.userName,
  });

  UserModel copyWith({
    String? completeName,
    String? college,
    String? userName,
  }) {
    return UserModel(
      completeName: completeName ?? this.completeName,
      college: college ?? this.college,
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'completeName': completeName,
      'college': college,
      'userName': userName,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      completeName: map['completeName'],
      college: map['college'],
      userName: map['userName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserModel(completeName: $completeName, college: $college, userName: $userName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.completeName == completeName &&
        other.college == college &&
        other.userName == userName;
  }

  @override
  int get hashCode =>
      completeName.hashCode ^ college.hashCode ^ userName.hashCode;
}
