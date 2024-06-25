import 'package:flutter/material.dart';

class IconButtonExample extends StatefulWidget {
  const IconButtonExample({super.key, this.onTap});

  final Function()? onTap;
  @override
  State<IconButtonExample> createState() => _IconButtonExampleState();
}

class _IconButtonExampleState extends State<IconButtonExample> {
  get onTap => null;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.volume_up),
          tooltip: 'Increase volume by 10',
          onPressed: onTap,
      ),
        // Text('Play'),
      ],
    );
  }
}
