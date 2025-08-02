import 'package:address/src/domain/models/address_manually_model.dart';
import 'package:address/src/presentation/components/address_nickname_suggestion_button.dart';
import 'package:address/src/presentation/viewmodels/address_manually_viewmodel.dart';
import 'package:core/core.dart';
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

  final _validateMode = AutovalidateMode.onUnfocus;

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
          label: Text('Rua *'),
          initialValue: _address.street,
          autovalidateMode: _validateMode,
          readOnly: true,
          onPressed: () {
            ArtToaster.show(
              context,
              ArtToast(
                title: Text('A Rua não pode ser alterada'),
                description: Text('Tente reajustar sua posição no mapa.'),
              ),
            );
          },
        ),
        ArtTextFormField(
          label: Text('CEP'),
          initialValue: _address.zipCode,
          autovalidateMode: _validateMode,
          onChanged: (value) => widget.onChanged(_model.copyWith(address: _address.copyWith(zipCode: value))),
        ),
        ArtTextFormField(
          label: Text('Bairro *'),
          initialValue: _address.neighborhood,
          formController: ObrigatoryValidator(),
          autovalidateMode: _validateMode,
          onChanged: (value) => widget.onChanged(_model.copyWith(address: _address.copyWith(neighborhood: value))),
        ),
        ArtTextFormField(
          label: Text('Numero ${_addressWithoutNumber ? '' : '*'}'),
          controller: _numberEC,
          enabled: !_addressWithoutNumber,
          formController: _addressWithoutNumber ? null : ObrigatoryValidator(),
          autovalidateMode: _validateMode,
          onChanged: (value) => widget.onChanged(_model.copyWith(address: _address.copyWith(number: value))),
        ),
        ArtCheckBox(
          initialValue: false,
          inputLabel: Text('Endereço sem número.'),
          onChanged: (value) {
            widget.onAddressWithoutNumberChanged(value);
            if (value) {
              widget.onChanged(_model.copyWith(address: _address.copyWith(number: '')));
              _numberEC.clear();
            }
          },
        ),
        ArtTextFormField(
          label: Text('Complemento ${_addressWithoutComplement ? '' : '*'}'),
          controller: _complementEC,
          enabled: !_addressWithoutComplement,
          formController: _addressWithoutComplement ? null : ObrigatoryValidator(),
          autovalidateMode: _validateMode,
          onChanged: (value) => widget.onChanged(_model.copyWith(address: _address.copyWith(complement: value))),
        ),
        ArtCheckBox(
          initialValue: false,
          inputLabel: Text('Endereço sem complemento.'),
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
              nickname: 'Casa',
              onTap: (nickname) {
                _nickNameEC.text = nickname;
                _nickNameFN.requestFocus();
                widget.onChanged(_model.copyWith(address: _address.copyWith(nickName: nickname)));
              },
            ),
            AddressNicknameSuggestionButton(
              icon: PaipIcon(PaipIcons.cityDuotone),
              nickname: 'Trabalho',
              onTap: (nickname) {
                _nickNameEC.text = nickname;
                _nickNameFN.requestFocus();
                widget.onChanged(_model.copyWith(address: _address.copyWith(nickName: nickname)));
              },
            ),
          ],
        ),
        ArtTextFormField(
          label: Text('Apelido *'),
          placeholder: Text('Ex: Casa, Trabalho...'),
          controller: _nickNameEC,
          focusNode: _nickNameFN,
          autovalidateMode: _validateMode,
          formController: ObrigatoryValidator(),
        ),
      ],
    );
  }
}
