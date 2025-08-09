import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:portal/src/core/helpers/assets_img.dart';
import 'package:portal/src/core/helpers/routes.dart';
import 'package:portal/src/modules/register/register/presenters/pages/address_page.dart';
import 'package:portal/src/modules/register/register/presenters/components/nav_bar_button.dart';
import 'package:portal/src/modules/register/register/presenters/components/views/data_establishment_view.dart';
import 'package:portal/src/modules/register/register/presenters/components/views/email_password_view.dart';
import 'package:portal/src/modules/register/register/presenters/components/views/name_phone_view.dart';
import 'package:portal/src/modules/register/register/presenters/pages/slug_page.dart';
import '../../aplication/controllers/register_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final RegisterController controller = context.read<RegisterController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(Assets.deliveryPatinet), fit: BoxFit.cover, colorFilter: ColorFilter.mode(Colors.black.withValues(alpha: .3), BlendMode.darken)),
            ),
            width: context.w,
            height: double.infinity,
          ),
          Padding(
            padding: PSize.v.paddingAll,
            child: Align(alignment: Alignment.topLeft, child: GestureDetector(onTap: () => context.go(Routes.home), child: SvgPicture.asset(Assets.logoGreenWhite, width: 150))),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: PSize.ii.paddingAll,
              child: ArtCard(
                child: Container(
                  color: context.artColorScheme.background,
                  constraints: BoxConstraints(maxWidth: 600, minWidth: 300, minHeight: 300, maxHeight: 600),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: PageView(
                          physics: const NeverScrollableScrollPhysics(),
                          allowImplicitScrolling: false,
                          controller: controller.store.pageController,
                          children: [
                            EmailPasswordView(),
                            NamePhoneView(),
                            DataEstablishmentView(),
                            AddressPage(),
                            SlugPage(),
                          ],
                        ),
                      ),
                      const NavBarButton()
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
