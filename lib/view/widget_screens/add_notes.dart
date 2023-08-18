import 'package:flutter/material.dart';
import 'package:pathfinder/utilities/dialogs.dart';
import 'package:pathfinder/utilities/text_styles.dart';
import 'package:provider/provider.dart';

import '../../utilities/consts/color_consts.dart';
import '../../view_model/dashboard_view_model.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  @override
  Widget build(BuildContext context) {
    DashboardViewModel dashboardViewModel = context.watch<DashboardViewModel>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text('What is the issue?'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.keyboard_arrow_down_outlined,
                size: 30,
              ))
        ],
      ),
      body: Container(),
      // body: ListView.builder(
      //     itemCount: dashboardViewModel.noteList.length,
      //     itemBuilder: (context, index) => ListTile(
      //           onTap: () {
      //             dashboardViewModel.setNoteSelected(index);
      //           },
      //           shape: RoundedRectangleBorder(
      //               side: BorderSide(color: Colors.grey, width: 0.5)),
      //           tileColor: dashboardViewModel.noteList[index].isSelected!
      //               ? Colors.orange.withOpacity(0.3)
      //               : Colors.white,
      //           title: Text(
      //             dashboardViewModel.noteList[index].text!,
      //             style: CustomTextStyles().text(),
      //           ),
      //         )),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Palette.primaryColor,
          icon: Icon(Icons.check),
          onPressed: () {
            if (dashboardViewModel.selectedNotesListModel.text == null) {
              showSnackBar(context, message: 'Please select a note');
            } else {
              dashboardViewModel.addNote();
              Navigator.pop(context);
            }
          },
          label: Text('Submit')),
    );
  }
}
