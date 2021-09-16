class UserModel {
  UserModel({
    required this.id,
    required this.completeName,
    required this.college,
    required this.userName,
  });
  String id;
  String completeName;
  String college;
  String userName;

// model, view_model, viewm, services utils
  UserModel copyWith({
    String? completeName,
    String? college,
    String? userName,
  }) {
    return UserModel(
      id: id,
      completeName: completeName ?? this.completeName,
      college: college ?? this.college,
      userName: userName ?? this.userName,
    );
  }
}
