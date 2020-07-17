import 'package:flutter/material.dart';
import 'package:pinkvilla_demo/Model/PVMetaData.dart';
import 'package:pinkvilla_demo/Utils/httpUtil.dart';
import 'package:pinkvilla_demo/Widgets/LoadingScreen.dart';
import 'package:pinkvilla_demo/Widgets/VideoFeed.dart';
import 'package:pinkvilla_demo/Widgets/VideoTile.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey _key = GlobalKey<ScaffoldState>();
  List<PVMetaData> data = [];
  PageController _pageController = PageController(viewportFraction: 1.0);

  fetchData() async {
    List<PVMetaData> temp =
        await fetchVideoFeed(_key.currentContext, VIDEO_URL2);
    temp.forEach((element) {
      data.add(element);
    });
    setState(() {
    });
  }

  Future fetchFeed() async {
    data = await fetchVideoFeed(_key.currentContext, VIDEO_URL);
    return data;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height - 80;
    return Scaffold(
      key: _key,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Pinkvilla',
          style: TextStyle(
              color: Color(0xFFEF2D56),
              fontSize: 28.0,
              fontFamily: 'BlackberryJam'),
        ),
        backgroundColor: Color(0xFFF2F2F2),
      ),
      body: FutureBuilder(
        future: fetchFeed(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              width: width,
              height: height,
              child: LoadingScreen(),
            );
          }

          return Container(
            width: width,
            height: height,
            child: CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext ctx, int itemIndex) {
                      if(itemIndex == (data.length - 2)) fetchData();
                      return Container(
                        width: width,
                        height: height,
                        child: VideoFeed(item: data[itemIndex]),
                      );
                    },
                    childCount: data.length,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }


}
