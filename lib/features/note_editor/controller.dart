import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/models/note.dart';

class NoteEditorController {
  NoteEditorController({this.note});

  Note? note;

  final formKey = GlobalKey<FormState>();

  TextEditingController titleTXController = TextEditingController();
  TextEditingController subtitleTXController = TextEditingController();

  Future<Note?> addNote() async {
    if (!formKey.currentState!.validate()) {
      return null;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    List<String> cachedNotes = prefs.getStringList('notes') ?? [];
    cachedNotes.insert(
      0,
      jsonEncode({
        'title': titleTXController.text,
        'subtitle': subtitleTXController.text,
        "id": id,
      }),
    );
    await prefs.setStringList(
      'notes',
      cachedNotes,
    );
    return Note(
      title: titleTXController.text,
      id: id,
      subtitle: subtitleTXController.text,
    );
  }

  Future<Note?> editNote() async {
    if (!formKey.currentState!.validate()) {
      return null;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    note!.title = titleTXController.text;
    note!.subtitle = subtitleTXController.text;
    List<String> cachedNotes = prefs.getStringList('notes') ?? [];
    int index = cachedNotes.indexWhere((element) {
      return jsonDecode(element)['id'] == note!.id;
    });
    cachedNotes.removeAt(index);
    cachedNotes.insert(index, jsonEncode({
      'id': note!.id,
      'title': titleTXController.text,
      'subtitle': subtitleTXController.text,
    }));
    await prefs.setStringList(
      'notes',
      cachedNotes,
    );
    return note;
  }
}

/*
SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    prefs.setString(
      id,
      jsonEncode({
        'title': title,
        'subtitle': subtitle,
        "id": id,
      }),
    );
    for (String i in prefs.getKeys()) {
      print(prefs.getString(i));
    }
 */

// List<String> cachedNotes = prefs.getStringList('notes') ?? [];
// cachedNotes.insert(
//   0,
//   jsonEncode({
//     'title': title,
//     'subtitle': subtitle,
//     "id": 12,
//   }),
// );
// prefs.setStringList(
//   'notes',
//   cachedNotes,
// );
