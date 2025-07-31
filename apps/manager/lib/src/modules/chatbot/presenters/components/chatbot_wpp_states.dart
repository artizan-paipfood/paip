import 'package:artizan_ui/artizan_ui.dart';
import 'package:flutter/material.dart';
import 'package:manager/l10n/gen/app_localizations.dart';
import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/extensions/context.dart';
import 'package:paipfood_package/paipfood_package.dart' hide AppLocalizations;

enum ChatbotWppStatesVariant {
  disable,
  connnecting,
  connected,
  disconnected;
}

class ChatbotWppStates extends StatefulWidget {
  final ChatbotWppStatesVariant variant;
  final void Function()? onAction;
  const ChatbotWppStates({
    required this.variant,
    super.key,
    this.onAction,
  });

  @override
  State<ChatbotWppStates> createState() => _ChatbotWppStatesState();
}

class _ChatbotWppStatesState extends State<ChatbotWppStates> {
  Color get color => _getColorByVariant(widget.variant);

  @override
  Widget build(BuildContext context) {
    final String title = _title(variant: widget.variant, i18n: context.i18n);
    final String subtitle = _subtitle(variant: widget.variant, i18n: context.i18n);
    final String actionTitle = _actionTitle(variant: widget.variant, i18n: context.i18n);
    return ArtCard(
      backgroundColor: color.withValues(alpha: 0.2),
      shadows: [],
      child: Padding(
        padding: PSize.ii.paddingAll,
        child: Row(
          children: [
            Expanded(
              child: ArtEmptyState.nonTable(
                icon: Icon(PaipIcons.whatsApp),
                color: color,
                title: title,
                subtitle: subtitle,
              ),
            ),
            ArtButton.ghost(
              hoverBackgroundColor: context.artColors().foreground.withValues(alpha: 0.9),
              backgroundColor: context.artColors().foreground,
              onPressed: widget.onAction,
              child: Text(
                actionTitle,
                style: TextStyle(color: context.artColors().background),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorByVariant(ChatbotWppStatesVariant variant) {
    return switch (variant) {
      ChatbotWppStatesVariant.disable => Colors.orange,
      ChatbotWppStatesVariant.connnecting => Colors.amber,
      ChatbotWppStatesVariant.connected => Colors.green,
      ChatbotWppStatesVariant.disconnected => Colors.red,
    };
  }

  String _title({required ChatbotWppStatesVariant variant, required AppLocalizations i18n}) {
    return switch (variant) {
      ChatbotWppStatesVariant.disable => i18n.chatbotStatesDisableTitle,
      ChatbotWppStatesVariant.connnecting => i18n.chatbotStatesConnectingTitle,
      ChatbotWppStatesVariant.connected => i18n.chatbotStatesConnectedTitle,
      ChatbotWppStatesVariant.disconnected => i18n.chatbotStatesDisconnectedTitle,
    };
  }

  String _subtitle({required ChatbotWppStatesVariant variant, required AppLocalizations i18n}) {
    return switch (variant) {
      ChatbotWppStatesVariant.disable => i18n.chatbotStatesDisableSubtitle,
      ChatbotWppStatesVariant.connnecting => i18n.chatbotStatesConnectingSubtitle,
      ChatbotWppStatesVariant.connected => i18n.chatbotStatesConnectedSubtitle,
      ChatbotWppStatesVariant.disconnected => i18n.chatbotStatesDisconnectedSubtitle,
    };
  }

  String _actionTitle({required ChatbotWppStatesVariant variant, required AppLocalizations i18n}) {
    return switch (variant) {
      ChatbotWppStatesVariant.disable => i18n.chatbotStatesDisableAction,
      ChatbotWppStatesVariant.connnecting => i18n.chatbotStatesConnectingAction,
      ChatbotWppStatesVariant.connected => i18n.chatbotStatesConnectedAction,
      ChatbotWppStatesVariant.disconnected => i18n.chatbotStatesDisconnectedAction,
    };
  }
}
