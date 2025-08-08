import 'package:address/src/.i18n/gen/strings.g.dart';
import 'package:address/src/data/events/route_events.dart';
import 'package:address/src/presentation/viewmodels/post_code_viewmodel.dart';
import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class PostcodePage extends StatefulWidget {
  final PostCodeViewmodel viewmodel;
  const PostcodePage({required this.viewmodel, super.key});

  @override
  State<PostcodePage> createState() => _PostcodePageState();
}

class _PostcodePageState extends State<PostcodePage> {
  String _postcode = '';
  final _formKey = GlobalKey<FormState>();

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    await Command0.executeWithLoader(
      context,
      () async => await widget.viewmodel.searchByPostcode(_postcode),
      onSuccess: (r) => ModularEvent.fire(GoMyPositionEvent(lat: r.lat!, lng: r.long!)),
      onError: (e, s) {
        if (e is AppError) {
          if (AddressError.isCepInvalid(e)) {
            return ArtToaster.show(
                context,
                ArtToast.destructive(
                    title: Text(
                  e.messageTranslated(),
                )));
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PaipAppBar(
        title: Text(t.buscar_por_cep),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: PSize.spacer.paddingHorizontal + PSize.i.paddingTop + PSize.ii.paddingBottom,
              child: ArtTextFormField(
                placeholder: Text(t.cep),
                autofocus: true,
                decoration: ArtDecoration(color: context.artColorScheme.muted),
                formController: PaipAppLocale.locale.isBr ? CepValidator(isRequired: true) : PostCodeValidator(isRequired: true),
                onChanged: (value) {
                  _postcode = value;
                },
                trailing: PaipIcon(
                  PaipIcons.searchLinear,
                  color: context.artColorScheme.ring,
                  size: 18,
                ),
              ),
            ),
            Expanded(
              child: IgnorePointer(
                child: Center(
                  child: ArtEmptyState.small(
                    icon: PaipIcon(
                      PaipIcons.searchDuotone,
                      color: context.artColorScheme.primary,
                    ),
                    title: t.cep,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onSubmit,
        backgroundColor: context.artColorScheme.primary,
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
