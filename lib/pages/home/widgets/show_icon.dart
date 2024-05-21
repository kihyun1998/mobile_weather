// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mobile_weather/constants/constants.dart';

class ShowIcon extends StatelessWidget {
  const ShowIcon({
    Key? key,
    required this.icon,
  }) : super(key: key);
  final String icon;

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/images/loading.gif',
      image: 'https://$pubICONHOST/img/wn/$icon@4x.png',
      width: 96,
      height: 96,
      imageErrorBuilder: (context, error, stackTrace) {
        return Image.asset(
          'assets/images/no_image_icon.png',
          width: 96,
          height: 96,
        );
      },
    );
  }
}
