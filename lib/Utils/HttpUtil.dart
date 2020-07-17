import 'package:flutter/material.dart';
import 'package:pinkvilla_demo/Model/PVMetaData.dart';
import 'package:pinkvilla_demo/Model/User.dart';
import 'package:pinkvilla_demo/Widgets/LoadingScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final String VIDEO_URL =
    'https://www.pinkvilla.com/feed/video-test/video-feed.json';

final String VIDEO_URL2 =
    'https://www.pinkvilla.com/feed/video-test/video-feed-1.json';

Future<List<PVMetaData>> fetchVideoFeed(BuildContext context, String url) async {
  try {
    var response = await http.get(url);
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
    return data;
  } on Exception catch (_) {
    return null;
  }
}
