import 'package:flutter/material.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:portal/l10n/i18n_extension.dart';
import 'package:ui/ui.dart';

class LoginSupportButton extends StatefulWidget {
  const LoginSupportButton({super.key});

  @override
  State<LoginSupportButton> createState() => _LoginSupportButtonState();
}

class _LoginSupportButtonState extends State<LoginSupportButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: OverflowBar(
        alignment: MainAxisAlignment.spaceBetween,
        overflowAlignment: OverflowBarAlignment.start,
        children: [
          // Row(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     const Text("Já tem conta?"),
          //     UiButton.link(
          //       padding: 0.0.paddingHorizontal,
          //       onTap: () {
          //         Modular.to.pushNamed(
          //           '${Routes.mercadoPago.route}?code=TG-65baa1620746840001627c18-1657627583&state=26c6c358-ef75-40c1-9be2-19a9bbce45a5|eyJhbGciOiJIUzI1NiIsImtpZCI6Im5kcUdSR1ZSQVErQnhac2giLCJ0eXAiOiJKV1QifQ.eyJhdWQiOiJhdXRoZW50aWNhdGVkIiwiZXhwIjoxNzA2ODE3NDYxLCJpYXQiOjE3MDY3MzEwNjEsImlzcyI6Imh0dHBzOi8vdmlwd2JidXloc3pteGRqc2Nsemcuc3VwYWJhc2UuY28vYXV0aC92MSIsInN1YiI6IjQyZjE3NWUyLWRhYWItNGZjMS05MGU3LTJlZDEyYWM1MjQwNiIsImVtYWlsIjoiZWR1YXJkb2hyLm11bml6QGdtYWlsLmNvbSIsInBob25lIjoiIiwiYXBwX21ldGFkYXRhIjp7InByb3ZpZGVyIjoiZW1haWwiLCJwcm92aWRlcnMiOlsiZW1haWwiXX0sInVzZXJfbWV0YWRhdGEiOnt9LCJyb2xlIjoiYXV0aGVudGljYXRlZCIsImFhbCI6ImFhbDEiLCJhbXIiOlt7Im1ldGhvZCI6InBhc3N3b3JkIiwidGltZXN0YW1wIjoxNzA2NzMxMDYxfV0sInNlc3Npb25faWQiOiI2ZTgzOWZhMC01YjMyLTRiMGQtYmJmZS01MDBkNTc1NjNmNzYifQ.RztS76kcTMa2VP68WWsFv-L1VatsYnRSttVScbtLL7E',
          //         );
          //       },
          //       child: Text("Acesse por aqui"),
          //     ),
          //   ],
          // ),
          ArtButton.link(
            padding: 0.0.paddingHorizontal,
            onPressed: () {
              launchUrl(Uri.parse('https://tawk.to/paipfood'));
            },
            child: Text(context.i18n.precisaAjuda),
          ),
        ],
      ),
    );
  }
}
