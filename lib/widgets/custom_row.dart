import 'package:flutter/material.dart';

Widget customRow({required String title, required String value}) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10, bottom: 5),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text(value),
          ],
        ),
        SizedBox(height: 5),
        Divider(),
      ],
    ),
  );
}
