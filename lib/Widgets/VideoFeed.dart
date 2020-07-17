import 'package:flutter/material.dart';
import 'package:pinkvilla_demo/Model/PVMetaData.dart';
import 'package:pinkvilla_demo/Widgets/VideoTile.dart';

class VideoFeed extends StatefulWidget {
  final PVMetaData item;

  VideoFeed({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  _VideoFeedState createState() => _VideoFeedState();
}

class _VideoFeedState extends State<VideoFeed> {
  @override
  Widget build(BuildContext context) {
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
              url: widget.item.url,
            ),
          ),
          textOverlay(width)
        ],
      ),
    );
  }

  Widget textOverlay(width) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: width,
        color: Colors.black.withOpacity(.2),
        padding: const EdgeInsets.only(left: 8.0, bottom: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            videoDetails(),
            actions(),
          ],
        ),
      ),
    );
  }

  Expanded videoDetails() {
    return Expanded(
      flex: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            widget.item.user.name,
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
            widget.item.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }

  Expanded actions() {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          likes(),
          SizedBox(height: 20.0),
          comments(),
          SizedBox(height: 20.0),
          shares(),
          SizedBox(height: 20.0),
          displayPicture(),
        ],
      ),
    );
  }

  Column likes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              widget.item.liked = !widget.item.liked;
              widget.item.liked
                  ? widget.item.likeCount++
                  : widget.item.likeCount--;
            });
          },
          child: Icon(
            Icons.favorite,
            color: widget.item.liked ? Colors.red : Colors.white,
            size: 34.0,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          widget.item.likeCount.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ],
    );
  }

  Column comments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.comment,
          color: Colors.white,
          size: 34.0,
        ),
        SizedBox(width: 8.0),
        Text(
          widget.item.commentCount.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ],
    );
  }

  Column shares() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.repeat,
          color: Colors.white,
          size: 34.0,
        ),
        SizedBox(width: 8.0),
        Text(
          widget.item.shareCount.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ],
    );
  }

  Container displayPicture() {
    return Container(
      height: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Image.network(
          widget.item.user.headshot,
        ),
      ),
    );
  }
}
