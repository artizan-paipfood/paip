import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

class CwErrorWidget extends StatelessWidget {
  final void Function()? onPop;
  final FlutterErrorDetails details;
  final String? messageError;

  const CwErrorWidget({
    required this.details,
    this.messageError,
    this.onPop,
    super.key,
  });

  String extractErrorSource() {
    final stackTrace = details.stack.toString();
    final lines = stackTrace.split('\n');
    // Filtrar as linhas relevantes do stack trace
    final relevantLines = lines.where((line) => line.contains('.dart') && !line.contains('framework')).toList();
    return relevantLines.isNotEmpty ? relevantLines.join('\n\n') : "Nenhuma informação relevante encontrada";
  }

  String filterRelevantStackTrace(String stackTrace) {
    // Filtrar apenas linhas que pertencem ao seu código (normalmente começam com ../packages/)
    final relevantLines = stackTrace
        .split('\n')
        .where((line) => line.contains('../packages/') && !line.contains('view') && !line.contains('binding')) // Inclui apenas pacotes relevantes
        .toList();
    return relevantLines.isNotEmpty ? relevantLines.join('\n\n') : "Nenhuma linha relevante encontrada.";
  }

  @override
  Widget build(BuildContext context) {
    final errorSource = extractErrorSource();
    return Scaffold(
      body: ColoredBox(
        color: context.color.primaryBG,
        child: Padding(
          padding: PSize.ii.paddingHorizontal,
          child: SelectionArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Icon(Icons.error_outline, color: Colors.red, size: 100),
                ),
                Text(
                  "Ops! Algo deu errado.",
                  style: context.textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                PSize.i.sizedBoxH,
                Text(
                  messageError ?? details.summary.toString(),
                  style: context.textTheme.bodyMedium?.muted(context),
                  textAlign: TextAlign.center,
                ),
                PSize.iii.sizedBoxH,
                PSize.spacer.sizedBoxH,
                Row(
                  children: [
                    Expanded(
                      child: PButton(
                        label: "TENTAR NOVAMENTE",
                        color: context.color.black,
                        colorText: context.color.white,
                        onPressed: () {
                          onPop?.call();
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
                PSize.vi.sizedBoxH,
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: context.color.border),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Details',
                        ),
                        PSize.i.sizedBoxH,
                        Text(
                          filterRelevantStackTrace(errorSource),
                          style: context.textTheme.bodySmall?.muted(context),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
