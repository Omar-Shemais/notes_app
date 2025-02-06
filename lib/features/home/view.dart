import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_app/core/app_colors/app_colors.dart';
import 'package:note_app/core/caching_utils/caching_utils.dart';
import 'package:note_app/core/dimensions/dimensions.dart';
import 'package:note_app/features/login/view.dart';

import '../../core/route_utils/route_utils.dart';
import '../../widgets/app/create_your_first_note_vector.dart';
import '../../widgets/app/note_card.dart';
import '../../widgets/app_app_bar.dart';
import '../../widgets/app_icon_button.dart';
import '../note_editor/view.dart';
import '../search/view.dart';
import 'home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController controller = HomeController();

  @override
  void initState() {
    controller.getCachedNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: "Notes",
        actions: [
          AppIconButton(
            icon: FontAwesomeIcons.magnifyingGlass,
            onTap: () => RouteUtils.push(
              context: context,
              view: SearchView(notes: controller.notes),
            ),
          ),
          SizedBox(width: 12.width),
          AppIconButton(
            icon: FontAwesomeIcons.arrowRightFromBracket,
            onTap: () async {
              await CachingUtils.deleteUser();
              RouteUtils.pushAndPopAll(
                context: context,
                view: LoginView(),
              );
            },
          ),
          SizedBox(width: 16.width),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (controller.notes.isEmpty) {
            return CreateYourFirstNoteVector();
          }
          return RefreshIndicator(
            onRefresh: () async {
              await controller.getCachedNotes();
              setState(() {});
            },
            color: AppColors.white,
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: controller.notes.length,
              itemBuilder: (context, index) {
                return NoteCard(
                  note: controller.notes[index],
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          FontAwesomeIcons.plus,
          size: 24.height,
        ),
        onPressed: () async {
          final result = await RouteUtils.push(
            context: context,
            view: NoteEditorView(),
          );
          if (result != null) {
            controller.notes.insert(0, result);
            setState(() {});
          }
        },
      ),
    );
  }
}
