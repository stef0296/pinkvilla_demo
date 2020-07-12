import 'package:flutter/material.dart';
import 'package:pinkvilla_demo/Model/PVMetaData.dart';
import 'package:pinkvilla_demo/Model/User.dart';
import 'package:pinkvilla_demo/Widgets/LoadingScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final String VIDEO_URL =
    'https://www.pinkvilla.com/feed/video-test/video-feed.json';

Future<List<PVMetaData>> fetchVideoFeed({BuildContext context}) async {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => LoadingScreen());
  try {
    var response = await http.get(VIDEO_URL);
    var result = json.decode(response.body);

    List<PVMetaData> data = [];
    if (result != null) {
      result.forEach((item) {
        data.add(PVMetaData(
          url: item['url'],
          commentCount: item['comment-count'],
          likeCount: item['like-count'],
          shareCount: item['share-count'],
          title: item['title'],
          user: User(
            name: item['user']['name'],
            headshot: item['user']['headshot'],
          ),
        ));
      });
    }
    Navigator.pop(context); //pop dialog
    return data;
  } on Exception catch (_) {
    Navigator.pop(context); //pop dialog
    return null;
  }
}
