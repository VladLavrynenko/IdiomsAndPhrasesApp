import 'package:flutter/material.dart';

class SoundButton extends StatefulWidget {
  final Future<void> Function() onTap;

  const SoundButton({Key? key, required this.onTap}) : super(key: key);

  @override
  State<SoundButton> createState() => _SoundButtonState();
}

class _SoundButtonState extends State<SoundButton> {
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
