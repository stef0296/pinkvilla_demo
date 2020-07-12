import 'package:flutter/material.dart';
import 'package:pinkvilla_demo/Model/PVMetaData.dart';
import 'package:pinkvilla_demo/Utils/httpUtil.dart';
import 'package:pinkvilla_demo/Widgets/VideoTile.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey _key = GlobalKey<ScaffoldState>();
  List<PVMetaData> data = [];
  PageController _pageController = PageController(viewportFraction: 1.0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      data = await fetchVideoFeed(context: _key.currentContext);
      setState(() {});
      print(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _key,
      body: SafeArea(
        top: true,
        right: true,
        bottom: true,
        left: true,
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: width,
                height: 50,
                color: Color(0xFFEF2D56),
                alignment: Alignment.center,
                child: Text(
                  'Pinkvilla',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,

                    fontFamily: 'BlackberryJam'
                  ),
                ),
              ),
            ),
            _buildCarousel(context)
          ],
        ),
      ),
    );
  }

  Widget _buildCarousel(BuildContext context) {
    double height = MediaQuery.of(context).size.height - 74;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          // you may want to use an aspect ratio here for tablet support
          height: height,
          child: PageView.builder(
            scrollDirection: Axis.vertical,
            // store this controller in a State to save the carousel scroll position
            controller: _pageController,
            itemBuilder: (BuildContext ctx, int itemIndex) {
              return _buildCarouselItem(ctx, itemIndex);
            },
            itemCount: data.length,
          ),
        )
      ],
    );
  }

  Widget _buildCarouselItem(BuildContext context, int itemIndex) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.0),
      height: height,
      decoration: BoxDecoration(
          border: Border.symmetric(
              horizontal: BorderSide(color: Color(0xFF0c0c0c), width: 5)),
          color: Color(0xFF0c0c0c)),
      alignment: Alignment.center,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: VideoTile(
              url: data[itemIndex].url,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: width,
              color: Colors.black.withOpacity(.2),
              padding:
                  const EdgeInsets.only(left: 8.0, bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          data[itemIndex].user.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 19.0,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          data[itemIndex].title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                setState(() {
                                  data[itemIndex].liked = !data[itemIndex].liked;
                                  data[itemIndex].liked ? data[itemIndex].likeCount++ : data[itemIndex].likeCount--;
                                });
                              },
                              child: Icon(
                                Icons.favorite,
                                color: data[itemIndex].liked ? Colors.red : Colors.white,
                                size: 34.0,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              data[itemIndex].likeCount.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.comment,
                              color: Colors.white,
                              size: 34.0,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              data[itemIndex].commentCount.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.repeat,
                              color: Colors.white,
                              size: 34.0,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              data[itemIndex].shareCount.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          height: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: Image.network(
                              data[itemIndex].user.headshot,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
