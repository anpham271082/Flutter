import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_app_flutter/core/constants/colors.dart';
import 'package:my_app_flutter/core/utils/devices.dart';
class NotificationWidget extends StatelessWidget {
  final String? label;
  final String? desc;
  final String? imgUrl;
  final String? date;
  const NotificationWidget(
      {super.key, this.label, this.desc, this.imgUrl, this.date});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(left: 20, right: 0, bottom: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: imgUrl!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                            text: label,
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 12 * AppDevices.shared.ratio),
                            children: <TextSpan>[
                              TextSpan(
                                text: desc!,
                                style: TextStyle(
                                    color: AppColors.colorTextInput,
                                    fontSize: 12 * AppDevices.shared.ratio),
                              )
                            ]),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        date!,
                        style: TextStyle(
                            fontSize: 11 * AppDevices.shared.ratio,
                            fontWeight: FontWeight.w600,
                            color: Colors.black38),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          color: Colors.grey,
          height: 1,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
