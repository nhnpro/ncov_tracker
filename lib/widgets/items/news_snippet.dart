import 'package:cached_network_image/cached_network_image.dart';
import 'package:division/division.dart';
import 'package:virus_corona_tracker/utils/constants.dart';
import 'package:virus_corona_tracker/utils/helper.dart';
import 'package:flutter/material.dart';

class NewsSnippet extends StatelessWidget {
  final int nid;
  final String title;
  final String timestamp;
  final String url;
  final String imgUrl;
  final void Function(int) onTap;

  const NewsSnippet({
    Key key,
    this.nid,
    this.title,
    this.timestamp,
    this.url,
    this.imgUrl,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userCardStyle = ParentStyle()
      ..padding(horizontal: 4.0, vertical: 4)
      ..alignment.center()
      ..background.color(Colors.white)
      ..width(MediaQuery.of(context).size.width - (2 * 10))
      ..borderRadius(all: 15.0)
      ..elevation(1, color: Colors.black45);
    return Parent(
        style: userCardStyle,
        child: InkWell(
          onTap: () => onTap(nid),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 400.0,
                minWidth: MediaQuery.of(context).size.width - (2 *10),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black.withOpacity(0.75),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          timestamp != ''
                              ? Text(
                                  Helper.formatLongDate(timestamp),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                  CachedNetworkImage(
                    imageUrl: imgUrl,
                    width: 100.0,
                    height: 100.0,
                    fit: BoxFit.cover,
                    fadeInDuration: Duration(milliseconds: 300),
                    errorWidget: (context, url, error) {
                      return Image.asset(
                        AppConstants.placeholderImgPath,
                        fit: BoxFit.cover,
                        width: 100.0,
                        height: 100.0,
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
