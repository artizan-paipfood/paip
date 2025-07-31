import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paipfood_package/paipfood_package.dart';

class SecretPage extends StatefulWidget {
  const SecretPage({super.key});
  static const String route = '/j23b4igh23b4_7t5cvsughvb3_h234vjh_89gs7dfhu';

  @override
  State<SecretPage> createState() => _SecretPageState();
}

class _SecretPageState extends State<SecretPage> {
  String _key = 'secret';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate JWT'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CwTextFormFild(
              label: 'secret',
              initialValue: 'secret',
              onChanged: (value) {
                _key = value;
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: PButton(
                      label: 'Generate',
                      onPressed: () {
                        final token = JwtService.buildToken(map: JwtService.toMap('teste'), expiresIn: const Duration(days: 90), secret: _key);
                        Clipboard.setData(ClipboardData(text: token));
                        toast.showSucess('Token copiado para area de transferencia');
                      }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
