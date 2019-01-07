///create by elileo on 2018/12/19
///import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_friend/model/topic.dart';
import 'package:travel_friend/common/GlobalConfig.dart';
import 'package:travel_friend/common/TextResources.dart';
import 'package:travel_friend/utils/timeUtil.dart';
import 'package:travel_friend/widget/PhotoViewPager.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
///首页Item
Widget buildMateItem(context, index, Topic topic) {
  return new InkWell(
    onTap: () {

    },
    child: new Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: new Card(
        color: GlobalConfig.colorPrimary,
        elevation: 1.0,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              margin: const EdgeInsets.only(top: 12),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                      child: new Row(
                        children: <Widget>[
                          buildCircleAvatar("images/default_avatar.png", topic.headImg, 30, 30),
                          new Container(
                            constraints: BoxConstraints(
                              maxWidth: 120,
                            ),
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              topic.nickname,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          new Container(
                            margin: const EdgeInsets.only(left: 2.0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 1.0, horizontal: 4.0),
                            child: new Row(
                              children: <Widget>[
                                Image.asset(
                                    topic.sex == 2
                                        ? "images/icon_female.png"
                                        : "images/icon_man.png",
                                    width: 8.0,
                                    height: 8.0),
                                Text(
                                  topic.age.toString(),
                                  style: TextStyle(
                                    color: topic.sex == 2
                                        ? GlobalConfig.colorFE1CAF
                                        : GlobalConfig.color189CFF,
                                    fontSize: 10.0,
                                  ),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: topic.sex == 2
                                  ? GlobalConfig.colorFEDEEE
                                  : GlobalConfig.colorDEF0FE,
                              borderRadius:
                              new BorderRadius.all(new Radius.circular(200)),
                            ),
                          )
                        ],
                      )),
                  GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 6.0),
                        child: Text(TextResources.linkTaTips),
                        decoration: BoxDecoration(
                          border: new Border.all(
                              width: 1.0, color: GlobalConfig.color979797),
                          color: Colors.white,
                          borderRadius:
                          new BorderRadius.all(new Radius.circular(20.0)),
                        ),
                      )),
                ],
              ),
            ),
            buildDestination(topic.addressStr, topic.beginTime, topic.endTime),
            buildContentText(topic.content, 3),
            buildImageGrid(context,
                (topic.imagesList != null && topic.imagesList.length > 0)
                    ? topic.imagesList
                    : new List<String>()),
            buildLocationText(topic.location, topic.createdTime),
            buildHeartShare(topic),
          ],
        ),
      ),
    ),
  );
}

Widget buildCircleAvatar(String avatarPlaceHolder, String netImageUrl, double width, double height){
  return GestureDetector(
    onTap: () {},
    child: new ClipOval(
      child: new FadeInImage.assetNetwork(
        fadeOutDuration: Duration.zero,
        fadeInDuration: Duration.zero,
        placeholder: avatarPlaceHolder,
        fit: BoxFit.cover,
        image: netImageUrl,
        width: width,
        height: height,
      ),
    ),
  );
}

Widget buildDestination(String addressStr, int beginTime, int endTime){
  return new Container(
    margin: const EdgeInsets.only(top: 10),
    height: 60,
    child: Stack(
      children: <Widget>[
        new Positioned(
          child: new Image.asset(
            "images/mate_date_bg.png",
            fit: BoxFit.fill,
          ),
          left: 0.0,
          right: 0.0,
          top: 0.0,
          bottom: 0.0,
        ),
        new Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: new Center(
            child: new Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    addressStr,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: GlobalConfig.color0D0E15),
                  ),
                ),
                Text(
                  mateTimeStampFormat(beginTime, endTime),
                  style: TextStyle(
                      fontSize: 14, color: GlobalConfig.color666666),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildLocationText(String location, int createdTime){
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Row(
      children: <Widget>[
        Expanded(
          child: new Row(
            children:
            location != null && location.isNotEmpty
                ? <Widget>[
              Image.asset(
                "images/icon_location.png",
                width: 12,
                height: 12,
              ),
              Text(
                location,
                style: TextStyle(
                    fontSize: 12,
                    color: GlobalConfig.color666666),
              )
            ]
                : <Widget>[],
          ),
        ),
        Text(
          getTimestampString(createdTime),
          style: TextStyle(
              fontSize: 12, color: GlobalConfig.color666666),
        )
      ],
    ),
  );
}

Widget buildContentText(String content, int maxLine){
  return  new Container(
    alignment: Alignment.topLeft,
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Text(content,
        maxLines: maxLine,
        overflow: TextOverflow.ellipsis,
        style:
        TextStyle(fontSize: 14, color: GlobalConfig.color0D0E15)),
  );
}

Widget buildIconText(MainAxisAlignment align, String text, String assetImageUrl){
  return Expanded(child: GestureDetector(
    onTap: () {},
    child: Row(
      mainAxisAlignment: align,
      children: <Widget>[
        Image.asset(assetImageUrl, width: 20, height: 20),
        Container(
          padding: const EdgeInsets.only(left: 6),
          child: Text(text,
              style:
              TextStyle(fontSize: 14, color: GlobalConfig.color0D0E15)),
        )
      ],
    ),
  ));
}

Widget buildHeartShare(Topic topic) {
  return Container(
    height: 55,
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Row(
      children: <Widget>[
        buildIconText(MainAxisAlignment.start, topic.likeNum.toString(),
            topic.liked ? "images/icon_love_selected.png" : "images/icon_love.png"),
        buildIconText(MainAxisAlignment.center, topic.commentNum.toString(), "images/icon_comment.png"),
        buildIconText(MainAxisAlignment.end, topic.shareNum.toString(), "images/icon_repost.png"),
      ],
    ),
  );
}

Widget buildImageGrid(context, List<String> list) {
  if (list.length == 0) {
    return new Container(
      padding: const EdgeInsets.only(top: 15),
    );
  }
  double ratio = 1;
  if (list != null && list.length == 1) {
    ratio = 2;
  }
  return new Container(
    child: new GridView.count(
        physics: new NeverScrollableScrollPhysics(),
        crossAxisCount: list.length >= 3 ? 3 : list.length,
        childAspectRatio: ratio,
        shrinkWrap: true,
        padding: const EdgeInsets.all(15),
        mainAxisSpacing: 5.0,
        crossAxisSpacing: 5.0,
        children: _buildGridImageList(context, list)),
  );
}

String _getImageParam(int length){
  String imageFilter = "?x-oss-process=image/resize,h_200";
  switch (length){
    case 1:
      imageFilter = "?x-oss-process=image/resize,h_500";
      break;
    case 2:
      imageFilter = "?x-oss-process=image/resize,h_300";
      break;
  }
  return imageFilter;
}

List<Container> _buildGridImageList(context, List<String> list) {
  String imageFilter = _getImageParam(list != null && list.isNotEmpty ? list.length : 0);
  return new List<Container>.generate(
      list.length,
          (int index) => new Container(
          child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PhotoViewPager(imageList: list, index: index)));
              },
              child: FadeInImage.assetNetwork(
                  fadeInDuration: Duration.zero,
                  fadeOutDuration: Duration.zero,
                  placeholder: "images/default_image.png",
                  image: list[index] + imageFilter,
                  fit: BoxFit
                      .cover)) //Image.network(list[index], fit: BoxFit.cover)
      ));
}