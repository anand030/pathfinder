import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:pathfinder/model/user_model.dart';
import 'package:pathfinder/utilities/consts/color_consts.dart';
import 'package:pathfinder/utilities/consts/constants.dart';
import 'package:pathfinder/utilities/pref_utils.dart';
import 'package:pathfinder/utilities/text_styles.dart';
import 'package:provider/provider.dart';

import '../../view_model/dashboard_view_model.dart';
import '../../widgets/buttons/primary_button.dart';
import '../widget_screens/add_notes.dart';
import '../widget_screens/empty_data_screen.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DashboardViewModel dashboardViewModel = context.watch<DashboardViewModel>();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: dashboardViewModel.loadingNotes
            ? Center(
                child: CircularProgressIndicator(),
              )
            : dashboardViewModel.notesModel.data == null ||
                    dashboardViewModel.notesModel.data!.isEmpty
                ? Center(
                    child: EmptyDataScreen(
                        image: 'empty_box.jpg',
                        title: 'Oops, Its empty in here'),
                  )
                : ListView.builder(
                    itemCount: dashboardViewModel.notesModel.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dashboardViewModel
                                          .notesModel.data![index].note ??
                                      '',
                                  style: CustomTextStyles().text(),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    formatDate(
                                        DateTime.parse(dashboardViewModel
                                            .notesModel
                                            .data![index]
                                            .timeStamp!),
                                        [
                                          hh,
                                          ':',
                                          mm,
                                          ' ',
                                          dd,
                                          '-',
                                          M,
                                          '-',
                                          yy
                                        ]),
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black.withOpacity(.5)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
      ),
      floatingActionButton: FutureBuilder(
        future: PrefUtils().getUserData(),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            UserModel userModel =
                UserModel.fromJson(jsonDecode(snapShot.data!));
            if (userModel.teamRole == UserRole.mr) {
              return dashboardViewModel.hospitalAlertType ==
                      HospitalAlertType.red
                  ? FloatingActionButton.extended(
                      onPressed: () {
                        showNoteModalBottomSheet(context, dashboardViewModel);
                      },
                      label: Text('Add Note'),
                      icon: Icon(Icons.add),
                      backgroundColor: Palette.primaryColor,
                    )
                  : Container();
            }
            return Container();
          }
          return Container();
        },
      ),
    );
  }

  showNoteModalBottomSheet(
      BuildContext context, DashboardViewModel dashboardViewModel) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: 400,
                child: Form(
                  key: dashboardViewModel.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      AppBar(
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
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                            controller:
                                dashboardViewModel.textEditingControllerNotes,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a comment';
                              }
                              return null;
                            },
                            style: CustomTextStyles()
                                .text(color: Colors.grey.shade800),
                            maxLines: 5,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                hintText: 'Enter your reason here...',
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Palette.primaryColor))),
                            // autofocus: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: PrimaryButton(
                          isStretched: true,
                          onPressed: () async {
                            if (dashboardViewModel.formKey.currentState!
                                .validate()) {
                              dashboardViewModel.addNote();
                              Navigator.pop(context);
                            }
                          },
                          text: 'Add Note',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));

    // showModalBottomSheet<void>(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return Container(
    //       height: 400,
    //       child: Center(
    //         child: AddNotes(),
    //       ),
    //     );
    //   },
    // );
  }
}
