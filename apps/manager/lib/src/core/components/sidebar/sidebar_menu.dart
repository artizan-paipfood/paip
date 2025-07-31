part of 'sidebar.dart';

class SidebarMenu extends StatefulWidget {
  final String label;
  final String id;
  final IconData icon;
  final List<SideBarSubMenu> subMenus;
  final void Function() onTap;

  const SidebarMenu({
    required this.id,
    required this.icon,
    required this.onTap,
    required this.label,
    super.key,
    this.subMenus = const [],
  });

  @override
  State<SidebarMenu> createState() => _SidebarMenuState();
}

class _SidebarMenuState extends State<SidebarMenu> {
  late final controller = SidebarController.instance;
  bool get isSelected => controller.menuIsSelected(context, id: widget.id);
  bool get isExpanded => SidebarController.instance.menuIsExpanded(context, id: widget.id) && widget.subMenus.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          return Column(
            children: [
              InkWell(
                onTap: widget.onTap,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: context.color.primaryBG, borderRadius: BorderRadius.circular(5)),
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: isSelected ? context.color.primaryColor.withOpacity(0.3) : context.color.primaryBG, borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                            child: Icon(
                              widget.icon,
                              color: isSelected ? context.color.primaryColor : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: controller.isCollapsed,
                      child: Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.label,
                                style: context.textTheme.labelLarge!.copyWith(
                                  color: isSelected ? context.color.primaryColor : context.color.primaryText,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                              child: widget.subMenus.isNotEmpty ? Icon(isExpanded && isSelected ? PaipIcons.chevronUp : PaipIcons.chevronDown, size: 18) : const SizedBox.shrink(),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: isExpanded,
                child: Column(children: widget.subMenus),
              )
            ],
          );
        });
  }
}
