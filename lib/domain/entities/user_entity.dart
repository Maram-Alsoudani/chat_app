class UserEntity {
  static const String collectionName = "users";
  String id;
  String fullName;
  String email;

  UserEntity({required this.id, required this.email, required this.fullName});

  UserEntity.fromJson(Map<String, dynamic> jsonData)
      : this(
            id: jsonData["id"],
            fullName: jsonData["fullName"],
            email: jsonData["email"]);

  Map<String, dynamic> toJson() {
    return {"id": id, "fullName": fullName, "email": email};
  }
}
