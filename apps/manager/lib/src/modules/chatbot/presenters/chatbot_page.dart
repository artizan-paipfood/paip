import 'package:artizan_ui/artizan_ui.dart';
import 'package:flutter/material.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/core/helpers/command.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/modules/chatbot/presenters/components/chatbot_message_card.dart';
import 'package:manager/src/modules/chatbot/presenters/components/chat_bot_integration_card.dart';
import 'package:manager/src/modules/chatbot/presenters/components/chatbot_wpp_states.dart';
import 'package:manager/src/modules/chatbot/presenters/viewmodels/chatbot_viewmodel.dart';
import 'package:manager/src/modules/chatbot/presenters/components/chatbot_wpp_scan_qrcode_dialog.dart';
import 'package:manager/src/modules/chatbot/domain/services/chatbot_wpp_connection_service.dart';
import 'package:paipfood_package/paipfood_package.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  late final ChatbotViewmodel viewmodel = context.read<ChatbotViewmodel>();
  late final ChatbotWppConnectionService wppService = context.read<ChatbotWppConnectionService>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeMessages();
  }

  Future<void> _initializeMessages() async {
    try {
      setState(() => _isLoading = true);
      await viewmodel.initialize(establishmentId: establishmentProvider.value.id);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar mensagens: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleActionWppStates(ChatbotWppStatesVariant variant) async {
    switch (variant) {
      case ChatbotWppStatesVariant.disable:
        await _enableWhatsApp();
        break;
      case ChatbotWppStatesVariant.connnecting:
        break;
      case ChatbotWppStatesVariant.connected:
        await _disconnectWhatsApp();
        break;
      case ChatbotWppStatesVariant.disconnected:
        await _reconnectWhatsApp();
        break;
    }
  }

  Future<void> _enableWhatsApp() async {
    await Command0.executeWithLoader(
      context,
      () async {
        await viewmodel.toggleWppEnabled(
          value: true,
          establishmentId: establishmentProvider.value.id,
        );
        await viewmodel.verifyConnection(
          establishmentId: establishmentProvider.value.id,
        );
      },
      onSuccess: (v) => _showQRCodeDialog(),
    );
  }

  Future<void> _disconnectWhatsApp() async {
    await Command0.executeWithLoader(
      context,
      () async => await viewmodel.disconnect(
        establishmentId: establishmentProvider.value.id,
      ),
    );
  }

  Future<void> _reconnectWhatsApp() async {
    await Command0.executeWithLoader(
      context,
      () async => await viewmodel.verifyConnection(
        establishmentId: establishmentProvider.value.id,
      ),
      onSuccess: (v) => _showQRCodeDialog(),
    );
  }

  void _showQRCodeDialog() {
    showDialog(
      context: context,
      builder: (context) => ChatbotWppScanQrcodeDialog(
        wppService: wppService,
        instanceName: establishmentProvider.value.id,
      ),
    );
  }

  Future<void> _handleMessageSave(MessageModel message) async {
    try {
      await viewmodel.updateChangedMessages(messages: [message]);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.i18n.salvo)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar mensagem: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: PSize.ii.paddingAll,
        child: _isLoading ? const Center(child: CircularProgressIndicator()) : _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildIntegrationSection(),
        ArtDivider.horizontal(),
        _buildMessagesSection(),
      ],
    );
  }

  Widget _buildIntegrationSection() {
    return ListenableBuilder(
      listenable: viewmodel.listenables,
      builder: (context, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Integraçoes', style: context.artTextTheme.h4),
            PSize.i.sizedBoxH,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ChatBotIntegrationCard(
                  initialValue: viewmodel.wppEnabled,
                  onChanged: (value) async {
                    await Command0.executeWithLoader(
                      context,
                      () async => await viewmodel.toggleWppEnabled(
                        value: value,
                        establishmentId: establishmentProvider.value.id,
                      ),
                    );
                  },
                ),
                PSize.i.sizedBoxW,
                Expanded(
                  child: ChatbotWppStates(
                    variant: viewmodel.wppStates,
                    onAction: () => _handleActionWppStates(viewmodel.wppStates),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildMessagesSection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Mensagens de status', style: context.artTextTheme.h4),
          PSize.i.sizedBoxH,
          Expanded(
            child: viewmodel.messages.isEmpty
                ? Center(
                    child: Text('Nenhuma mensagem configurada'),
                  )
                : ListView.builder(
                    itemCount: viewmodel.messages.length,
                    itemBuilder: (context, index) {
                      final message = viewmodel.messages[index];
                      return Padding(
                        padding: PSize.ii.paddingBottom,
                        child: ChatbotMessageCard(
                          message: message,
                          onSave: _handleMessageSave,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
