import 'package:flutter/material.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('build account view');
    return const Scaffold(body: Center(child: Text('we in profile')));
  }
}
