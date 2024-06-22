class UserModel {
  final String name;
  final String? profileImg;
  UserModel({
    required this.name,
    this.profileImg,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['display_name'] ?? '',
      profileImg: map['display_picture'],
    );
  }

  @override
  String toString() => 'UserModel(name: $name, profileImg: $profileImg)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.name == name &&
        other.profileImg == profileImg;
  }

  @override
  int get hashCode => name.hashCode ^ profileImg.hashCode;
}

