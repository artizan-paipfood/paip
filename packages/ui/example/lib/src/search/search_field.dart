import 'dart:math';

import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:ui/ui.dart';

class _SearchState<T> {
  List<T> _options;
  _SearchState(this._options) {
    list.value = _options;
  }

  String searchValue = '';

  T? selectedValue;

  late final ValueNotifier<List<T>> list = ValueNotifier([]);
}

@immutable
class UiSearchField<T> extends StatefulWidget {
  final Widget? label;
  final void Function(String value)? onChanged;
  final void Function(T? value)? onSelected;
  final List<T> Function(String value)? onFiltering;
  final Widget Function(BuildContext context, T value) optionBuilder;
  final String Function(T value) selectedTextBuilder;
  final FocusNode? focusNode;
  final List<T> options;
  final TextEditingController? controller;

  const UiSearchField({
    super.key,
    this.label,
    this.onChanged,
    this.onSelected,
    this.focusNode,
    required this.options,
    required this.optionBuilder,
    required this.selectedTextBuilder,
    this.controller,
    this.onFiltering,
  });

  @override
  State<UiSearchField<T>> createState() => _UiSearchFieldState<T>();
}

class _UiSearchFieldState<T> extends State<UiSearchField<T>> {
  String searchValue = '';
  late final state = _SearchState<T>(widget.options);

  late FocusNode _focusNode;
  late TextEditingController _controller;
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> showScrollToTop = ValueNotifier(false);
  final ValueNotifier<bool> showScrollToBottom = ValueNotifier(false);

  void _onSelect(T value) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      state.selectedValue = value;
      widget.onSelected?.call(value);
      _focusNode.unfocus();
      Future.delayed(50.milliseconds, () {
        _controller.text = widget.selectedTextBuilder(value);
      });
    });
  }

  // void _onUnfocus() {
  //   if (_controller.text.isNotEmpty && state.selectedValue != null) {
  //     if (widget.selectedTextBuilder(state.selectedValue as T) != _controller.text) {
  //       _onSelect(state.selectedValue as T);
  //     }
  //   }
  // }

  void _onRebuild() {
    if (widget.options != state._options) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        state._options = widget.options;
        state.list.value = widget.options;
      });
    }
  }

  void _clear() {
    _controller.clear();
    state.selectedValue = null;
    widget.onSelected?.call(null);
  }

  void _onfocus(BuildContext context) {
    final theme = UiTheme.of(context);
    final size = theme.size;

    final isMobile = MediaQuery.sizeOf(context).width < 500;

    final component = _SearchComponent<T>(
      state: state,
      controller: _controller,
      onReset: () => _clear(),
      onSelected: (value) {
        _onSelect(value);
      },
      optionBuilder: widget.optionBuilder,
      onChanged: (value) {
        state.searchValue = value;
        widget.onChanged?.call(value);
        if (widget.onFiltering != null) state.list.value = widget.onFiltering!.call(value);
      },
      pageRoute: isMobile,
      onFiltering: (value) {
        state.list.value = widget.onFiltering?.call(value) ?? state._options;
        return state.list.value;
      },
    );
    if (isMobile) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SafeArea(
            bottom: false,
            top: true,
            maintainBottomViewPadding: true,
            child: component,
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => ShadDialog.alert(
          padding: size.i.paddingAll,
          child: SizedBox(
            height: 400,
            child: component,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();

    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        showScrollToTop.value = _scrollController.offset > 0;
        showScrollToBottom.value = _scrollController.offset < _scrollController.position.maxScrollExtent;
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _scrollController.dispose();
    showScrollToBottom.dispose();
    showScrollToTop.dispose();
    super.dispose();
  }

  Future<void> animateToTop() async {
    while (showScrollToTop.value) {
      await _scrollController.animateTo(
        max(_scrollController.offset - 30, 0),
        duration: const Duration(milliseconds: 20),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  Future<void> animateToBottom() async {
    while (showScrollToBottom.value) {
      await _scrollController.animateTo(
        min(_scrollController.offset + 30, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 20),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = UiTheme.of(context);
    _onRebuild();

    return LayoutBuilder(
      builder: (context, constraints) {
        return UiInputFormField(
          onPressed: () => _onfocus(context),
          controller: _controller,
          readOnly: true,
          prefix: Icon(
            LucideIcons.search,
            size: 16,
            color: theme.colorScheme.popoverForeground,
          ),
          suffix: Visibility.maintain(
            visible: state.selectedValue != null,
            child: InkResponse(
              onTap: _clear,
              child: Icon(
                LucideIcons.x,
                size: 16,
                color: theme.colorScheme.popoverForeground,
              ),
            ),
          ),
          label: widget.label ?? const Text('Search'),
          onChanged: (value) {
            setState(() {
              searchValue = value;
              _controller.text = value;
            });
            widget.onChanged?.call(value);
          },
        );
      },
    );
  }
}

class _SearchComponent<T> extends StatefulWidget {
  final _SearchState state;
  final List<T> Function(String value)? onFiltering;
  final void Function(String value)? onChanged;
  final void Function(T value)? onSelected;
  final Widget Function(BuildContext context, T value) optionBuilder;
  final bool pageRoute;
  final TextEditingController controller;
  final void Function() onReset;

  const _SearchComponent({
    super.key,
    required this.state,
    required this.onSelected,
    this.onFiltering,
    this.onChanged,
    required this.optionBuilder,
    this.pageRoute = false,
    required this.controller,
    required this.onReset,
  });

  @override
  State<_SearchComponent<T>> createState() => _SearchComponentState<T>();
}

class _SearchComponentState<T> extends State<_SearchComponent<T>> {
  @override
  Widget build(BuildContext context) {
    final theme = UiTheme.of(context);
    final size = theme.size;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: size.i.paddingAll,
            child: Row(
              children: [
                if (widget.pageRoute)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: InkResponse(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(
                        LucideIcons.arrowLeft,
                        size: 16,
                        color: theme.colorScheme.foreground,
                      ),
                    ),
                  ),
                Expanded(
                  child: TextField(
                    autofocus: widget.controller.text.isEmpty,
                    controller: widget.controller,
                    onChanged: (value) {
                      widget.state.searchValue = value;
                      widget.onChanged?.call(value);
                      if (widget.onFiltering != null) widget.state.list.value = widget.onFiltering!.call(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Rua numero, bairro, cidade...',
                      hintStyle: theme.inputTheme.placeholderStyle,
                      border: InputBorder.none,
                      alignLabelWithHint: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              widget.onReset();
                            });
                          },
                          icon: const Icon(
                            PIcons.strokeRoundedCancel01,
                            size: 16,
                          )),
                      prefixIcon: const Icon(
                        LucideIcons.search,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: size.i.value),
          Expanded(
            child: Padding(
              padding: size.i.paddingBottom,
              child: IconTheme(
                data: IconThemeData(color: theme.colorScheme.foreground),
                child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 400),
                    child: ValueListenableBuilder(
                        valueListenable: widget.state.list,
                        builder: (context, list, _) {
                          if (list.isEmpty) {
                            return Center(
                              child: UiEmptyState.minimal(
                                color: theme.colorScheme.border,
                                icon: const Icon(LucideIcons.search),
                                title: widget.state.searchValue.trim().isNotEmpty ? 'Nenhum resultado encontrado para:' : null,
                                subtitle: widget.state.searchValue.trim().isNotEmpty ? widget.state.searchValue : 'Comece a buscar...',
                              ),
                            );
                          }

                          return ListView(
                              shrinkWrap: true,
                              children: list
                                  .map((option) => InkWell(
                                        borderRadius: size.s.borderRadiusAll,
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          widget.onSelected?.call(option);
                                        },
                                        child: Padding(
                                          padding: size.i.paddingAll + size.i.paddingHorizontal,
                                          child: widget.optionBuilder(context, option),
                                        ),
                                      ))
                                  .toList());
                        })),
              ),
            ),
          )
        ],
      ),
    );
  }
}
