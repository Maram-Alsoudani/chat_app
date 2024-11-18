import 'package:chat_app/data/data_sources/firebase_remote_data_source.dart';
import 'package:chat_app/data/models/message_model.dart';
import 'package:chat_app/data/models/room_model.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/room_entity.dart';

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

  CollectionReference<RoomModel> getRoomsCollection() {
    return FirebaseFirestore.instance
        .collection(RoomEntity.collectionName)
        .withConverter<RoomModel>(
            fromFirestore: (snapshot, options) =>
                RoomModel.fromJson(snapshot.data()!),
            toFirestore: (roomModel, options) => roomModel.toJson());
  }

  CollectionReference<MessageModel> getMessagesCollection(String roomId) {
    return getRoomsCollection()
        .doc(roomId)
        .collection('messages')
        .withConverter(
            fromFirestore: (snapshot, options) =>
                MessageModel.fromJson(snapshot.data()!),
            toFirestore: (messageModel, options) => messageModel.toJson());
  }

  @override
  Future<void> addUserToFireStore(UserModel userModel) async {
    CollectionReference<UserModel> userRef = getUsersCollection();
    DocumentReference<UserModel> doc = userRef.doc(userModel.id);
    return doc.set(userModel);
  }

  @override
  Future<UserModel?> getUserFromFireStore(String userId) async {
    var documentSnapshot = await getUsersCollection().doc(userId).get();
    return documentSnapshot.data();
  }

  @override
  Future<void> addRoomToFireStore(RoomModel roomModel) {
    CollectionReference<RoomModel> roomRef = getRoomsCollection();
    DocumentReference<RoomModel> doc = roomRef.doc();
    roomModel.roomId = doc.id;
    return doc.set(roomModel);
  }

  @override
  Stream<List<RoomModel?>> getAllRoomsFromFireStore() {
    return getRoomsCollection().snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return RoomModel(
            roomId: doc.id,
            title: data.title,
            description: data.description,
            categoryId: data.categoryId);
      }).toList();
    });
  }

  @override
  Future<void> insertMessage(MessageModel messageModel) {
    var messagesCollection = getMessagesCollection(messageModel.roomId);
    var docRef = messagesCollection.doc();
    messageModel.roomId = docRef.id;
    return docRef.set(messageModel);
  }

  @override
  Stream<List<MessageModel?>> getMessages(String roomId) {
    return getMessagesCollection(roomId)
        .orderBy("dateTime")
        .snapshots()
        .map((snapShot) {
      return snapShot.docs.map((doc) {
        final data = doc.data();
        return MessageModel(
            messageId: data.messageId,
            roomId: data.roomId,
            senderId: data.senderId,
            senderName: data.senderName,
            content: data.content,
            dateTime: data.dateTime);
      }).toList();
    });
  }
}
