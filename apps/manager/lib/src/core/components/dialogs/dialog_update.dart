import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/services/update_service.dart';
import 'package:paipfood_package/paipfood_package.dart';

class DialogUpdate extends StatefulWidget {
  final VersionModel version;
  final bool isRequired;
  const DialogUpdate({required this.version, required this.isRequired, super.key});

  @override
  State<DialogUpdate> createState() => _DialogUpdateState();
}

class _DialogUpdateState extends State<DialogUpdate> {
  late final updateService = context.read<UpdateService>();
  ValueNotifier<StateData> state = ValueNotifier(StateData.initial());
  double progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return CwDialog(
      canPop: !widget.isRequired,
      title: Text(context.i18n.novaVersaoDisponivel),
      content: StateNotifier(
        stateNotifier: state,

        // overlay: false,
        onInitial: (context) => Container(decoration: BoxDecoration(color: context.color.surface, shape: BoxShape.circle), height: 130, width: 130, child: Lottie.asset('assets/lotties/lottie_download.json', package: 'paipfood_package')),
        onLoad: (context) => StreamBuilder(
          stream: Stream.periodic(100.milliseconds),
          builder: (context, snapshot) {
            return SizedBox(
              height: 120,
              width: 120,
              child: Stack(
                children: [
                  Align(child: SizedBox(height: 120, width: 120, child: CircularProgressIndicator(value: progress, backgroundColor: context.color.surface, strokeWidth: 8, strokeCap: StrokeCap.round))),
                  Align(child: Text("${(progress * 100).toStringAsFixed(0)}%", textAlign: TextAlign.center)),
                ],
              ),
            );
          },
        ),
        onComplete: (context) => _buildinstaller(),
      ),
      actions: [
        PButton(
          label: context.i18n.atualizar.toUpperCase(),
          onPressedFuture: () async {
            state.value = StateData.loading();

            await updateService.installUpdate(
              urlDownload: widget.version.urlDownload!,
              exeFileName: widget.version.fileName!,
              onReceiveProgress: (p0, p1) {
                progress = p0 / p1;
                if (progress > 0.98) state.value = StateData.complete();
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildinstaller() {
    return SizedBox(
      height: 120,
      width: 120,
      child: Stack(children: [const Align(child: SizedBox(height: 120, width: 120, child: CircularProgressIndicator(strokeWidth: 8, strokeCap: StrokeCap.round))), Align(child: Text(context.i18n.iniciandoInstalador, textAlign: TextAlign.center))]),
    );
  }
}
