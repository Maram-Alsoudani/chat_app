import 'package:chat_app/core/utils/images.dart';

class RoomCategoryModel {
  String id;
  late String title;
  late String imagePath;

  static const String sportsId = 'sports';
  static const String moviesId = 'movies';
  static const String musicId = 'music';

  RoomCategoryModel({
    required this.id,
    required this.title,
    required this.imagePath,
  });

  RoomCategoryModel.fromId(this.id) {
    if (id == sportsId) {
      title = 'Sports';
      imagePath = AppImages.sports;
    } else if (id == moviesId) {
      title = 'Movies';
      imagePath = AppImages.movies;
    } else if (id == musicId) {
      title = 'Music';
      imagePath = AppImages.music;
    }
  }

  static List<RoomCategoryModel> getCategory() {
    return [
      RoomCategoryModel.fromId(sportsId),
      RoomCategoryModel.fromId(moviesId),
      RoomCategoryModel.fromId(musicId),
    ];
  }
}
