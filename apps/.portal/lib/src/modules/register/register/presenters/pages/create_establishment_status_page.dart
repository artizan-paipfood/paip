// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:paipfood_package/paipfood_package.dart';
import 'package:portal/src/core/helpers/routes.dart';
import 'package:portal/src/modules/register/register/aplication/controllers/register_controller.dart';

class CreateEstablishmentStatusPage extends StatefulWidget {
  const CreateEstablishmentStatusPage({super.key});

  @override
  State<CreateEstablishmentStatusPage> createState() => _CreateEstablishmentStatusPageState();
}

class _CreateEstablishmentStatusPageState extends State<CreateEstablishmentStatusPage> {
  Future<List<int>?> get() async {
    await Future.delayed(1.seconds);
    return null;
  }

  final controller = Modular.get<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Expanded(
            flex: 2,
            child: Column(
              children: [],
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: FutureState(
                future: controller.insertCompany(),
                onComplete: (context, _) {
                  Future.delayed(5.seconds, () {
                    if (context.mounted) context.go(Routes.downloads);
                  });
                  return const Text("Completo: ");
                },
                onLoading: (context) => const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [CircularProgressIndicator(), Text("Aguarde alguns segundos enquanto cadastramos seu estabelecimento")],
                ),
                onEmpty: (context) {
                  Future.delayed(5.seconds, () {
                    if (context.mounted) context.go(Routes.downloads);
                  });
                  return PButton(label: "Download", onPressed: () {});
                },
                onError: (context, value) => Text("Error: ${value.toString()}"),
              ),
            ),
          ),
        ],
      ),
    );

    // FutureBuilder(
    //   future: ,
    //   builder: (context, snapshot){

    // },);
  }
}
