class UserModel {
  static const String collectionName = "Users";
  String id;
  String name;
  String email;
  String location;
  String? photoUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.location,
    this.photoUrl,
  });

  UserModel.fromJson(Map<String, dynamic> json)
    : this(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        location: json['location'] ?? "Cairo, Egypt",
        photoUrl: json['photoUrl'],
      );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "location": location,
      "photoUrl": photoUrl,
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? location,
    String? photoUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      location: location ?? this.location,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
