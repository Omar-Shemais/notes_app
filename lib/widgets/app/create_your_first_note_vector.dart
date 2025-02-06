import 'package:flutter/material.dart';
import 'package:note_app/core/dimensions/dimensions.dart';
import 'package:note_app/widgets/app_text.dart';

import '../../core/utils.dart';

class CreateYourFirstNoteVector extends StatelessWidget {
  const CreateYourFirstNoteVector({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Utils.getPNGAssetPath('create_your_first_note'),
            height: 286.height,
            width: 350.width,
            fit: BoxFit.fill,
          ),
          SizedBox(height: 12.height),
          AppText(
            title: 'Create your first note !',
            fontSize: 20,
            fontWeight: FontWeight.w300,
          ),
        ],
      ),
    );
  }
}
