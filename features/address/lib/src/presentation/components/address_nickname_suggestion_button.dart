import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class AddressNicknameSuggestionButton extends StatelessWidget {
  final Widget icon;
  final String nickname;
  final void Function(String nickname) onTap;

  const AddressNicknameSuggestionButton({required this.icon, required this.nickname, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => onTap("$nickname "),
      overlayColor: WidgetStateProperty.all(context.artColorScheme.primary.withOpacity(0.1)),
      child: ArtCard(
        shadows: [],
        padding: PSize.ii.paddingAll,
        child: Row(
          children: [
            DefaultPaipIconStyle(
              style: PaipIconStyle(
                size: 18,
                color: context.artColorScheme.primary,
              ),
              child: icon,
            ),
            PSize.i.sizedBoxW,
            Text(nickname),
          ],
        ),
      ),
    );
  }
}
