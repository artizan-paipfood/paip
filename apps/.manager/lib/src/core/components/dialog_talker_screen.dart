import 'package:flutter/material.dart';
import 'package:manager/src/core/logs/logs.dart';
import 'package:talker_flutter/talker_flutter.dart';

class DialogTalkerScreen extends StatelessWidget {
  final Logs logs;
  const DialogTalkerScreen({required this.logs, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: MediaQuery.sizeOf(context).width * .5 > 300 ? MediaQuery.sizeOf(context).width * .5 : 300,
        child: TalkerScreen(
          talker: logs.talker,
          appBarTitle: logs.displayName,
        ),
      ),
    );
  }
}
