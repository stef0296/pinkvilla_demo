import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Color(0xFFF2F2F2),
      alignment: Alignment.center,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(0.5),
        highlightColor: Color(0xFFEF2D56),
        child: Text(
          'Pinkvilla',
          style: TextStyle(
              color: Colors.white,
              fontSize: 50.0,
              fontFamily: 'BlackberryJam'),
        ),
      ),
    );
  }
}