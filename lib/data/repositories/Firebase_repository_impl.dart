import 'package:chat_app/data/data_sources/firebase_remote_data_source.dart';
import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:chat_app/domain/repositories/firebase_repository.dart';
import 'package:injectable/injectable.dart';

import '../models/user_model.dart';

@Injectable(as: FirebaseRepository)
class FirebaseRepositoryImpl implements FirebaseRepository {
  FirebaseRemoteDataSource firebaseRemoteDataSource;

  FirebaseRepositoryImpl({required this.firebaseRemoteDataSource});

  @override
  Future<void> addUserToFireStore(UserEntity userEntity) async {
    final userModel = UserModel(
      id: userEntity.id,
      fullName: userEntity.fullName,
      email: userEntity.email,
    );
    return firebaseRemoteDataSource.addUserToFireStore(userModel);
  }
}
