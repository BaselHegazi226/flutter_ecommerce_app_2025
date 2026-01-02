import 'package:flutter/material.dart';

import 'edit_profile_data_section.dart';

class EditProfileViewBody extends StatelessWidget {
  const EditProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(child: EditDataSection()),
    );
  }
}
