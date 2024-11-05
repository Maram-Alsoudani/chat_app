class RoomEntity {
  static const collectionName = 'rooms';

  String roomId;
  String title;
  String description;
  String categoryId;

  RoomEntity({
    required this.roomId,
    required this.title,
    required this.description,
    required this.categoryId,
  });
}
