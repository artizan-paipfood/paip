import 'package:address/src/_i18n/gen/strings.g.dart';
import 'package:address/src/domain/models/address_manually_model.dart';
import 'package:address/src/domain/usecases/form_extensions.dart';
import 'package:address/src/presentation/components/address_nickname_suggestion_button.dart';
import 'package:address/src/presentation/viewmodels/address_manually_viewmodel.dart';
import 'package:core/core.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class AddressManuallyForm extends StatefulWidget {
  final void Function(AddressManuallyModel addressManuallyModel) onChanged;
  final void Function(bool value) onAddressWithoutNumberChanged;
  final void Function(bool value) onAddressWithoutComplementChanged;
  final AddressManuallyViewmodel viewmodel;

  const AddressManuallyForm({
    required this.onChanged,
    required this.viewmodel,
    required this.onAddressWithoutNumberChanged,
    required this.onAddressWithoutComplementChanged,
    super.key,
  });

  @override
  State<AddressManuallyForm> createState() => _AddressManuallyFormState();
}

class _AddressManuallyFormState extends State<AddressManuallyForm> {
  AddressEntity get _address => widget.viewmodel.addressManuallyModel.address;
  bool get _addressWithoutNumber => widget.viewmodel.addressManuallyModel.addressWithoutNumber;
  bool get _addressWithoutComplement => widget.viewmodel.addressManuallyModel.addressWithoutComplement;
  AddressManuallyModel get _model => widget.viewmodel.addressManuallyModel;

  late final _numberEC = TextEditingController(text: _address.number);
  late final _complementEC = TextEditingController(text: _address.complement);
  late final _nickNameEC = TextEditingController(text: _address.nickName);
  final _nickNameFN = FocusNode();

  final _validateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _numberEC.dispose();
    _complementEC.dispose();
    _nickNameEC.dispose();
    _nickNameFN.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: PSize.iii.value,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArtTextFormField(
          label: Text('${t.rua} *'),
          initialValue: _address.street,
          autovalidateMode: _validateMode,
          readOnly: true,
          onPressed: () {
            ArtToaster.show(
              context,
              ArtToast(
                title: Text(t.a_rua_nao_pode_ser_alterada),
                description: Text(t.a_rua_nao_pode_ser_alterada_descricao),
              ),
            );
          },
        ),
        ArtTextFormField(
          label: Text(t.cep),
          initialValue: _address.zipCode,
          autovalidateMode: _validateMode,
          formController: AppLocale.locale.cepValidator(isRequired: true),
          onChanged: (value) => widget.onChanged(_model.copyWith(address: _address.copyWith(zipCode: value))),
        ),
        ArtTextFormField(
          label: Text('${t.bairro} *'),
          initialValue: _address.neighborhood,
          formController: ObrigatoryValidator(),
          autovalidateMode: _validateMode,
          onChanged: (value) => widget.onChanged(_model.copyWith(address: _address.copyWith(neighborhood: value))),
        ),
        ArtTextFormField(
          label: Text('${t.numero} ${_addressWithoutNumber ? '' : '*'}'),
          controller: _numberEC,
          enabled: !_addressWithoutNumber,
          formController: _addressWithoutNumber ? null : ObrigatoryValidator(),
          autovalidateMode: _validateMode,
          onChanged: (value) => widget.onChanged(_model.copyWith(address: _address.copyWith(number: value))),
        ),
        ArtCheckBox(
          initialValue: false,
          inputLabel: Text('${t.endereco_sem_numero}.'),
          onChanged: (value) {
            widget.onAddressWithoutNumberChanged(value);
            if (value) {
              widget.onChanged(_model.copyWith(address: _address.copyWith(number: '')));
              _numberEC.clear();
            }
          },
        ),
        ArtTextFormField(
          label: Text('${t.complemento} ${_addressWithoutComplement ? '' : '*'}'),
          controller: _complementEC,
          enabled: !_addressWithoutComplement,
          formController: _addressWithoutComplement ? null : ObrigatoryValidator(),
          autovalidateMode: _validateMode,
          onChanged: (value) => widget.onChanged(_model.copyWith(address: _address.copyWith(complement: value))),
        ),
        ArtCheckBox(
          initialValue: false,
          inputLabel: Text('${t.endereco_sem_complemento}.'),
          onChanged: (value) {
            widget.onAddressWithoutComplementChanged(value);
            if (value) {
              widget.onChanged(_model.copyWith(address: _address.copyWith(complement: '')));
              _complementEC.clear();
            }
          },
        ),
        Row(
          spacing: PSize.ii.value,
          children: [
            AddressNicknameSuggestionButton(
              icon: PaipIcon(PaipIcons.homeDuotone),
              nickname: t.casa,
              onTap: (nickname) {
                _nickNameEC.text = nickname;
                _nickNameFN.requestFocus();
                widget.onChanged(_model.copyWith(address: _address.copyWith(nickName: nickname)));
              },
            ),
            AddressNicknameSuggestionButton(
              icon: PaipIcon(PaipIcons.cityDuotone),
              nickname: t.trabalho,
              onTap: (nickname) {
                _nickNameEC.text = nickname;
                _nickNameFN.requestFocus();
                widget.onChanged(_model.copyWith(address: _address.copyWith(nickName: nickname)));
              },
            ),
          ],
        ),
        ArtTextFormField(
          label: Text('${t.apelido} *'),
          placeholder: Text(t.apelido_placeholder),
          controller: _nickNameEC,
          focusNode: _nickNameFN,
          autovalidateMode: _validateMode,
          formController: ObrigatoryValidator(),
        ),
      ],
    );
  }
}
