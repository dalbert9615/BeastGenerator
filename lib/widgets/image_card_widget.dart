import 'package:flutter/material.dart';
import 'package:BeastGenerator/model/gallery_model.dart';
import 'package:BeastGenerator/screens/detail_screen.dart';

class ImageCard extends StatefulWidget {
  final String imageCode;
  final String userID;
  final int index;
  final String name;

  const ImageCard({
    Key? key,
    required this.galleryImage,
    required this.imageCode,
    required this.userID,
    required this.index,
    required this.name,
  }) : super(key: key);

  final List<GalleryImage>? galleryImage;

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.imageCode != null) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailScreen(
                    galleryID: widget.imageCode,
                    userID: widget.userID,
                  )));
        }
      },
      child: Column(
        children: [
          Card(
            elevation: 0,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.only(top: 0.0),
            child: Image.network(
              widget.imageCode,
            ),
          ),
          Expanded(
            flex: 5,
            child: ListTile(
              title: Text(
                widget.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
