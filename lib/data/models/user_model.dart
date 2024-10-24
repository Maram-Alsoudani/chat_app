import 'package:chat_app/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  static const String collectionName = "users";

  UserModel({
    required String id,
    required String fullName,
    required String email,
  }) : super(
          id: id,
          fullName: fullName,
          email: email,
        );

  UserModel.fromJson(Map<String, dynamic> jsonData)
      : this(
            id: jsonData["id"],
            fullName: jsonData["fullName"],
            email: jsonData["email"]);

  Map<String, dynamic> toJson() {
    return {"id": id, "fullName": fullName, "email": email};
  }
}
