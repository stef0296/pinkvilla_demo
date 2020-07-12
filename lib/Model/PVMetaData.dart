import 'package:pinkvilla_demo/Model/User.dart';

class PVMetaData {
  String url;
  int commentCount;
  int likeCount;
  int shareCount;
  String title;
  User user;
  bool liked;

  PVMetaData({
    this.url,
    this.commentCount,
    this.likeCount,
    this.shareCount,
    this.title,
    this.user,
    this.liked = false
  });
}
