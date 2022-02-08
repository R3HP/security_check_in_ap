import 'package:flutter/material.dart';



class MyDivider extends StatelessWidget {
  const MyDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(
          height: 2,
        ),
        Divider(
          color: Colors.cyan,
        ),
        SizedBox(
          height: 8.0,
        ),
      ],
    );
  }
}

