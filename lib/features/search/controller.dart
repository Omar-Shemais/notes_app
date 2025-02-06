import '../../core/models/note.dart';

class SearchController {

  SearchController({required this.notes});
  final List<Note> notes;

  List<Note> filteredNotes = [];

  Future<void> search(String? value) async {
    filteredNotes.clear();
    if (value == null || value.trim().isEmpty) {
      return;
    }
    for (var note in notes) {
      if (note.title.toLowerCase().contains(value.toLowerCase())) {
        filteredNotes.add(note);
      }
    }
  }

}