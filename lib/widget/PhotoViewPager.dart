///create by elileo on 2018/12/19
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

///zoom and can not slide  https://github.com/renancaraujo/photo_view/issues/61
class PhotoViewPager extends StatefulWidget{
  final List<String> imageList;
  final int index;
  final PageController pageController;
  PhotoViewPager({Key key, this.imageList, this.index}): pageController = new PageController(initialPage: index), super(key: key);

  @override
  _PhotoViewPagerState createState() => new _PhotoViewPagerState();
}

class _PhotoViewPagerState extends State<PhotoViewPager>{
  int currentIndex;

  void onPageChange(int index){
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.pageController.dispose();
  }

  @override
  void initState() {
    currentIndex = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Container(
        child: Stack(
          children: <Widget>[
            PhotoViewGallery(
              pageController: widget.pageController,
              onPageChanged: onPageChange,
              pageOptions: widget.imageList.map((url){
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(url),
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  maxScale: PhotoViewComputedScale.covered * 1.2,
                );
              }).toList(),
              backgroundDecoration: new BoxDecoration(
                  color: Colors.black
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(top:50.0),
              child: Text(
                "${currentIndex + 1}/${widget.imageList.length}",
                style: TextStyle(
                    color: Colors.white, fontSize: 17.0, decoration: TextDecoration.none),
              ),
            )
          ],
        )
      ),
    );
  }
}