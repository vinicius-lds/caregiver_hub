import 'package:flutter/material.dart';

class ChatAppBarTitle extends StatelessWidget {
  final String imageURL;
  final String name;

  const ChatAppBarTitle({
    Key? key,
    required this.imageURL,
    required this.name,
  }) : super(key: key);

  double _appBarHeight({double multiplyFactor = 1, bool inverse = false}) {
    final appBarHeight = AppBar().preferredSize.height;
    if (inverse) {
      return (appBarHeight - (appBarHeight * multiplyFactor)) * -1;
    } else {
      return appBarHeight * multiplyFactor;
    }
  }

  Matrix4 _xTransform(double value) {
    return Matrix4.translationValues(value, 0, 0);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (bContext, constraints) => Row(
        children: [
          Container(
            transform: _xTransform(
              _appBarHeight(multiplyFactor: 0.8, inverse: true),
            ),
            height: _appBarHeight(multiplyFactor: 0.8),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(imageURL),
            ),
          ),
          Container(
            transform: _xTransform(
              _appBarHeight(multiplyFactor: 0.8, inverse: true),
            ),
            width: constraints.maxWidth * 0.7,
            child: Text(name, overflow: TextOverflow.fade),
          ),
        ],
      ),
    );
  }
}
