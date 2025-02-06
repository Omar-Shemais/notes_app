import 'package:flutter/material.dart';
import 'package:note_app/core/dimensions/dimensions.dart';
import 'package:note_app/widgets/app_text.dart';

import '../../core/utils.dart';

class NoSearchResultVector extends StatelessWidget {
  const NoSearchResultVector({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Utils.getPNGAssetPath('no_search_result'),
            height: 240.height,
            width: 370.width,
            fit: BoxFit.fill,
          ),
          SizedBox(height: 12.height),
          AppText(
            title: 'Note not found. Try searching again.',
            fontSize: 20,
            fontWeight: FontWeight.w300,
          ),
        ],
      ),
    );
  }
}
