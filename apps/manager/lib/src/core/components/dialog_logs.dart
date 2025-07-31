import 'package:flutter/material.dart';
import 'package:manager/src/core/logs/logs.dart';
import 'package:manager/src/core/components/dialog_talker_screen.dart';
import 'package:paipfood_package/paipfood_package.dart';

class DialogLogs extends StatelessWidget {
  const DialogLogs({super.key});

  @override
  Widget build(BuildContext context) {
    return CwDialog(
      content: SizedBox(
        width: MediaQuery.sizeOf(context).width * .5 > 300 ? MediaQuery.sizeOf(context).width * .5 : 300,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: Logs.getAll
                  .map((log) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          title: Text(log.displayName),
                          subtitle: Text("Logs: ${log.talker.history.length}"),
                          onTap: () => showDialog(
                            context: context,
                            builder: (context) => DialogTalkerScreen(logs: log),
                          ),
                          shape: OutlineInputBorder(
                            borderSide: BorderSide(color: context.color.border),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
