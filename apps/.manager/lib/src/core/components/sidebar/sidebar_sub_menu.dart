part of 'sidebar.dart';

class SideBarSubMenu extends StatefulWidget {
  final String label;
  final String id;

  final void Function() onTap;

  const SideBarSubMenu({
    required this.label,
    required this.id,
    required this.onTap,
    super.key,
  });

  @override
  State<SideBarSubMenu> createState() => _SideBarSubMenuState();
}

class _SideBarSubMenuState extends State<SideBarSubMenu> {
  final controller = SidebarController.instance;
  bool get isSelected => controller.subMenuIsSelected(context, id: widget.id);
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          return InkWell(
            onTap: widget.onTap,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(color: context.color.primaryColor, width: 2),
                  ),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Container(
                        color: isSelected ? context.color.primaryColor : context.color.primaryText,
                        width: 8,
                        height: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                      child: SizedBox(
                        width: 142,
                        child: Text(
                          widget.label,
                          style: context.textTheme.labelLarge!.copyWith(
                            color: isSelected ? context.color.primaryColor : context.color.primaryText,
                            decorationThickness: 2,
                            height: 0.9,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
