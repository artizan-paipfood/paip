import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';

/// Flutter code sample for [SearchBar].

class CwSearchFild extends StatefulWidget {
  final String? initialValue;
  final String? label;
  final double? maxheight;
  final String? hintText;
  final SearchController searchController;
  final int debounceMilisecons;
  final Future<List<Widget>> Function(String value)? onChanged;
  final bool searchOnTap;
  final TextStyle? textStyle;
  final bool autoFocus;
  final bool? isMobile;
  const CwSearchFild({
    required this.searchController,
    super.key,
    this.initialValue,
    this.label,
    this.maxheight,
    this.hintText,
    this.debounceMilisecons = 0,
    this.onChanged,
    this.searchOnTap = true,
    this.textStyle,
    this.autoFocus = true,
    this.isMobile,
  });

  @override
  State<CwSearchFild> createState() => _CwSearchFildState();
}

class _CwSearchFildState extends State<CwSearchFild> {
  late final debounce = Debounce(milliseconds: widget.debounceMilisecons);
  List<Widget> children = [];
  String fildContent = '';
  bool _init = false;
  bool get _isMobile => widget.isMobile ?? (isAndroid || isIOS);

  @override
  void initState() {
    if (widget.initialValue != null) {
      fildContent = widget.initialValue!;
    }
    widget.searchController.text = fildContent;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) Padding(padding: const EdgeInsets.only(bottom: 4), child: Text(widget.label!, style: context.textTheme.labelMedium, overflow: TextOverflow.ellipsis)),
        SearchAnchor(
            textCapitalization: TextCapitalization.sentences,
            viewHintText: widget.hintText,
            headerHintStyle: context.textTheme.labelLarge!.copyWith(color: context.color.secondaryText.withOpacity(0.5)),
            viewSurfaceTintColor: _isMobile ? context.color.primaryBG : context.color.onPrimaryBG,
            viewBackgroundColor: _isMobile ? context.color.primaryBG : context.color.onPrimaryBG,
            viewConstraints: _isMobile ? null : const BoxConstraints(maxHeight: 300),
            isFullScreen: _isMobile ? true : false,
            viewShape: _isMobile
                ? null
                : const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    side: BorderSide(
                      color: PColors.primaryColor_,
                    ),
                  ),
            dividerColor: context.color.secondaryText.withOpacity(0.2),
            searchController: widget.searchController,
            builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                textStyle: widget.textStyle != null ? WidgetStatePropertyAll(widget.textStyle!) : null,
                textCapitalization: TextCapitalization.words,
                hintText: widget.hintText,
                hintStyle: WidgetStatePropertyAll<TextStyle>(context.textTheme.labelLarge!.copyWith(color: context.color.secondaryText.withOpacity(0.5))),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    side: BorderSide(
                      width: context.isDarkTheme ? 0 : 1,
                      color: context.isDarkTheme ? context.color.onPrimaryBG : PColors.neutral_.get300,
                    ),
                  ),
                ),
                autoFocus: widget.autoFocus,
                backgroundColor: WidgetStatePropertyAll(context.color.onPrimaryBG),
                surfaceTintColor: WidgetStatePropertyAll(context.color.onPrimaryBG),
                elevation: const WidgetStatePropertyAll(0),
                controller: controller,
                constraints: const BoxConstraints(
                  maxHeight: 45,
                  minHeight: 45,
                ),
                padding: const WidgetStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(horizontal: 16.0)),
                onTap: () async {
                  if (widget.searchOnTap && _init == false) {
                    children = await widget.onChanged?.call("a") ?? [];
                  }
                  fildContent = controller.value.text;

                  controller.openView();
                  if (fildContent.length > 3) {
                    widget.searchController.selection = TextSelection.fromPosition(TextPosition(offset: widget.searchController.value.text.length, affinity: TextAffinity.upstream));
                  }
                },
                onChanged: (_) {
                  controller.openView();
                },
                leading: const Icon(PIcons.strokeRoundedSearch01),
              );
            },
            suggestionsBuilder: (BuildContext conte, SearchController controller) async {
              final String value = controller.value.text;
              if (value.isEmpty && children.isNotEmpty && _init) {
                if (widget.searchOnTap) return children;
                return children = [];
              }
              if (fildContent != value && _init == true) {
                await debounce.startTimer(
                  length: 3,
                  value: controller.value.text,
                  onComplete: () async {
                    children = await widget.onChanged?.call(value) ?? [];
                    fildContent = value;
                  },
                );
              }
              _init = true;

              return children;
            }),
      ],
    );
  }
}
