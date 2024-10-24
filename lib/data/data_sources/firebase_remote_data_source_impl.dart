import 'package:chat_app/data/data_sources/firebase_remote_data_source.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: FirebaseRemoteDataSource)
class FirebaseRemoteDataSourceImpl extends FirebaseRemoteDataSource {
  CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(UserEntity.collectionName)
        .withConverter<UserModel>(
            fromFirestore: (snapshot, options) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (userModel, options) => userModel.toJson());
  }

  @override
  Future<void> addUserToFireStore(UserModel userModel) async {
    CollectionReference<UserModel> userRef = getUsersCollection();
    DocumentReference<UserModel> doc = userRef.doc(userModel.id);
    return doc.set(userModel);
  }
}
