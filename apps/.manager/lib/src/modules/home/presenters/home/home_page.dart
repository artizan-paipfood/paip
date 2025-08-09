import 'dart:async';

import 'package:artizan_ui/artizan_ui.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';

import 'package:manager/l10n/i18n_extension.dart';
import 'package:manager/src/core/helpers/command.dart';
import 'package:manager/src/modules/chatbot/presenters/components/chatbot_wpp_states.dart';
import 'package:manager/src/modules/chatbot/presenters/viewmodels/chatbot_viewmodel.dart';
import 'package:paipfood_package/paipfood_package.dart';
import 'package:manager/src/core/datasources/data_source.dart';
import 'package:manager/src/core/services/update_service.dart';
import 'package:manager/src/core/components/dialogs/dialog_update.dart';
import 'package:manager/src/modules/invoices/presenters/components/invoice_dialog.dart';
import 'package:manager/src/modules/invoices/presenters/components/invoice_dialog_pix.dart';
import 'package:manager/src/modules/invoices/domain/models/invoice_dialog_model.dart';
import 'package:manager/src/modules/invoices/presenters/viewmodels/invoice_viewmodel.dart';
import '../../../../core/components/sidebar/sidebar.dart';

class HomePage extends StatefulWidget {
  final Widget child;
  const HomePage({required this.child, super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final establishmentInvoiceViewmodel = context.read<InvoiceViewmodel>();
  late final dataSource = context.read<DataSource>();
  late final sidebarController = SidebarController.instance;
  final chatbotViewmodel = Modular.get<ChatbotViewmodel>();

  bool _hasCheckedInvoice = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(3.seconds, () {
      checkForUpdate();
      chatbotViewmodel.initialize(establishmentId: establishmentProvider.value.id);
      if (mounted) chatbotViewmodel.handleListStatusToaster(context);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasCheckedInvoice) {
      _hasCheckedInvoice = true;
      establishmentInvoiceViewmodel.checkInvoice(context.i18n, establishmentId: establishmentProvider.value.id).then((dto) {
        if (dto != null && mounted) {
          _showDialogInvoice(dto: dto, viewmodel: establishmentInvoiceViewmodel);
        }
      });
    }
  }

  Future<void> checkForUpdate() async {
    if (isMacOS) return;
    final newVersion = await context.read<UpdateService>().checkForUpdate(context);

    if (newVersion != null && mounted) {
      await showDialog(context: context, builder: (context) => DialogUpdate(version: newVersion, isRequired: newVersion.isRequired));
    }
  }

  Future<void> _showDialogInvoice({required InvoiceDialogModel dto, required InvoiceViewmodel viewmodel}) async {
    await showDialog(
      context: context,
      builder: (_) => InvoiceDialog(
        model: dto,
        viewmodel: viewmodel,
        onGeneratePayment: (invoice) async {
          Command0.executeWithLoader(
            context,
            () async {
              final pix = await viewmodel.generatePix(invoice: invoice);
              if (mounted) {
                unawaited(showDialog(context: context, builder: (context) => InvoiceDialogPix(viewmodel: viewmodel, pix: pix)));
              }
            },
            analyticsDesc: 'Gerando pix para o pagamento...',
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //     backgroundColor: context.color.primaryText,
      //     mini: true,
      //     onPressed: () {
      //       final uri = Uri.parse("https://paipfood.tawk.help/");
      //       launchUrl(uri);
      //     },
      //     child: Icon(
      //       Icomoon.message_question,
      //       color: context.color.surface,
      //     )),
      body: Row(
        children: [
          Sidebar(),
          Expanded(child: Column(children: [Expanded(child: widget.child)])),
        ],
      ),
    );
  }
}
