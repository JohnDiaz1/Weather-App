import 'package:flutter/material.dart';

import 'custom_text.dart';

class PlaceListTile extends StatefulWidget {
  final String mainText;
  final String? address;
  final Icon? icon;
  const PlaceListTile(
      {super.key, required this.mainText, this.address, this.icon});

  @override
  State<PlaceListTile> createState() => _PlaceListTileState();
}

class _PlaceListTileState extends State<PlaceListTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            leading: const Icon(Icons.location_on),
            title: CustomText(
              text: widget.mainText,
              fontSize: 15,
              isBold: true,
              textColor: Colors.black,
            ),
            subtitle: CustomText(
              text: widget.address == null ? "" : widget.address!,
              fontSize: 12,
              isBold: false,
              textColor: Colors.grey,
            ),
            trailing: widget.icon,
          onTap: () {

          },
        ),
      ],
    );
  }
}
