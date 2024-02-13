import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:NewsNest/components/bottomsheet.dart';
import 'components.dart' ;

class NewsBox extends StatelessWidget {
  final String imageurl, title, time, description, url;
  const NewsBox(
      {Key? key,
      required this.imageurl,
      required this.title,
      required this.time,
      required this.description,
      required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            showMyBottomSheet(context, title, description, imageurl, url);
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
            width:  MediaQuery.of(context).size.width,
            color: Colors.black,
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: imageurl,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.yellow),
                  ),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(color: Colors.black),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(title , style: const TextStyle(color: Colors.white),),
                      const SizedBox(height: 5),
                      Text(time ,style: const TextStyle(color: Colors.white),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const DividerWidget() ,
      ],
    );
  }
}