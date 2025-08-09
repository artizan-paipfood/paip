import 'dart:convert';
import 'package:artizan_ui/artizan_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/chatbot/domain/services/chatbot_wpp_connection_service.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ChatbotWppScanQrcodeDialog extends StatefulWidget {
  final ChatbotWppConnectionService wppService;
  final String instanceName;
  const ChatbotWppScanQrcodeDialog({
    required this.wppService,
    required this.instanceName,
    super.key,
  });

  @override
  State<ChatbotWppScanQrcodeDialog> createState() => _ChatbotWppScanQrcodeDialogState();
}

class _ChatbotWppScanQrcodeDialogState extends State<ChatbotWppScanQrcodeDialog> {
  @override
  void initState() {
    widget.wppService.generateQrcode(instanceName: widget.instanceName).then((_) {
      if (mounted) Navigator.pop(context);
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.wppService.disposeGenerateQrcode();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ArtDialog(
      constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.8),
      child: Column(
        children: [
          ColoredBox(
            color: context.color.primaryColor,
            child: Padding(padding: PSize.i.paddingVertical + PSize.ii.paddingHorizontal, child: Row(children: [Icon(PaipIcons.whatsApp, color: Colors.white), PSize.i.sizedBoxW, Text("WhatsApp", style: context.textTheme.titleLarge?.copyWith(color: Colors.white))])),
          ),
          ColoredBox(
            color: context.color.primaryBG,
            child: Padding(
              padding: PSize.ii.paddingAll,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(context.i18n.useWhatsappAutomatizarSistema, style: context.textTheme.titleLarge),
                        Text(context.i18n.atualizeSeusClientesSobreOsStatusDosPedidos, style: context.textTheme.bodyMedium?.muted(context)),
                        PSize.iii.sizedBoxH,
                        Text("1. ${context.i18n.abrirSeuWhatsappNoSeuCelularNaJanelaConversas}", style: context.textTheme.bodyMedium?.muted(context)),
                        PSize.i.sizedBoxH,
                        RichText(
                          text: TextSpan(
                            text: "2. ${context.i18n.toqueEm} ",
                            style: context.textTheme.bodyMedium?.muted(context),
                            children: [
                              TextSpan(text: context.i18n.maisOpcoes, style: context.textTheme.bodyMedium),
                              const WidgetSpan(child: Icon(Icons.more_vert, size: 16)),
                              TextSpan(
                                text: " ${context.i18n.seEstiverNoAndroid} ",
                                style: context.textTheme.bodyMedium?.muted(context),
                                children: [
                                  TextSpan(text: "${context.i18n.configuracoes} ", style: context.textTheme.bodyMedium),
                                  const WidgetSpan(child: Icon(CupertinoIcons.settings, size: 16)),
                                  TextSpan(text: " ${context.i18n.seEstiverNoIos}", style: context.textTheme.bodyMedium?.muted(context)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        PSize.i.sizedBoxH,
                        RichText(
                          text: TextSpan(
                            text: "3. ${context.i18n.toqueEm} ",
                            style: context.textTheme.bodyMedium?.muted(context),
                            children: [
                              TextSpan(text: "${context.i18n.dispositivosConectados} ", style: context.textTheme.bodyMedium),
                              TextSpan(text: "${context.i18n.eEmSeguidaEm} ", style: context.textTheme.bodyMedium?.muted(context), children: [TextSpan(text: context.i18n.conectarDispositivo, style: context.textTheme.bodyMedium)]),
                            ],
                          ),
                        ),
                        PSize.i.sizedBoxH,
                        Text("4. ${context.i18n.aponteSeuCelularParaEstaTelaParaEscanear}", style: context.textTheme.bodyMedium?.muted(context)),
                      ],
                    ),
                  ),
                  PSize.ii.sizedBoxW,
                  ListenableBuilder(
                    listenable: widget.wppService,
                    builder: (context, _) {
                      if (widget.wppService.qrcode == null) return SizedBox(width: 250, height: 250, child: const Center(child: CircularProgressIndicator()));
                      return Material(
                        borderRadius: PSize.i.borderRadiusAll,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: ColorFiltered(colorFilter: const ColorFilter.mode(Colors.black, BlendMode.colorBurn), child: Image.memory(base64Decode(widget.wppService.qrcode!.split(',').last), fit: BoxFit.cover, width: 250, height: 250)),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
