import 'package:flutter/material.dart';

class IconButtonExample extends StatefulWidget {
  final Future<void> Function() onTap;

  const IconButtonExample({Key? key, required this.onTap}) : super(key: key);

  @override
  State<IconButtonExample> createState() => _IconButtonExampleState();
}

class _IconButtonExampleState extends State<IconButtonExample> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.volume_up),
          tooltip: 'Increase volume by 10',
          onPressed: () async {
            await widget.onTap();
            if (widget.onTap != null) {
              widget.onTap!();
            }
          },
        ),
        // Text('Play'),
      ],
    );
  }
}
