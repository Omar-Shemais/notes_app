import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_app/core/dimensions/dimensions.dart';
import 'package:note_app/core/route_utils/route_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/app_colors/app_colors.dart';
import '../../core/models/note.dart';
import '../../core/utils.dart';
import '../../features/note_details/view.dart';
import '../app_text.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.note});

  final Note note;

  EdgeInsets get _cardMargin => EdgeInsets.only(bottom: 24.height);

  BorderRadius get _radius => BorderRadius.circular(12);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) async {
        final prefs = await SharedPreferences.getInstance();
        final cachedNotes = prefs.getStringList('notes') ?? [];
        final index = cachedNotes.indexWhere((element) {
          return note.id == jsonDecode(element)['id'];
        });
        cachedNotes.removeAt(index);
        prefs.setStringList('notes', cachedNotes);
      },
      background: Container(
        margin: _cardMargin,
        width: double.infinity,
        alignment: Alignment.center,
        child: Icon(FontAwesomeIcons.trash),
        decoration: BoxDecoration(
          color: AppColors.red,
          borderRadius: _radius,
        ),
      ),
      child: Padding(
        padding: _cardMargin,
        child: InkWell(
          borderRadius: _radius,
          onTap: () => RouteUtils.push(
            context: context,
            view: NoteDetailsView(note: note),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.width,
              vertical: 16.height,
            ),
            width: double.infinity,
            alignment: Alignment.center,
            child: AppText(
              title: note.title,
              color: AppColors.black,
              fontSize: 24,
            ),
            decoration: BoxDecoration(
              borderRadius: _radius,
              color: Utils.noteColors[Random().nextInt(Utils.noteColors.length - 1)],
            ),
          ),
        ),
      ),
    );
  }
}
