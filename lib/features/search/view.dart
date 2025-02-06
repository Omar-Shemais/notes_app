import 'package:flutter/material.dart' hide SearchController;
import 'package:note_app/core/dimensions/dimensions.dart';
import 'package:note_app/widgets/app_app_bar.dart';

import '../../core/models/note.dart';
import '../../widgets/app/no_search_result.dart';
import '../../widgets/app/note_card.dart';
import '../../widgets/app/search_text_field.dart';
import 'controller.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key, required this.notes});

  final List<Note> notes;

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {

  late SearchController controller;

  @override
  void initState() {
    controller = SearchController(notes: widget.notes);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SearchTextField(
              onChanged: (v) {
                controller.search(v);
                setState(() {});
              },
            ),
            SizedBox(height: 32.height),
            Expanded(
              child: Builder(
                builder: (context) {
                  if (controller.filteredNotes.isEmpty) {
                    return NoSearchResultVector();
                  }
                  return ListView.builder(
                    itemCount: controller.filteredNotes.length,
                    itemBuilder: (context, index) {
                      return NoteCard(note: controller.filteredNotes[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
