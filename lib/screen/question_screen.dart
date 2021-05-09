import 'package:app_test/flutterfire.dart';
import 'package:app_test/screen/grades_screen.dart';
import 'package:app_test/util.dart';
import 'package:app_test/widget/menu_button.dart';
import 'package:app_test/widget/notifications.dart';
import "package:flutter/material.dart";
import "package:app_test/widget/scaffold_wrapper.dart";

enum Grade { freshman, sophomore, junior, senior }

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  Grade _grade = Grade.freshman;

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      content: Center(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 20,
                  width: MediaQuery.of(context).size.width,
                ),
                Text(
                  "Which grade are you in?",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 95),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          "Freshman",
                          style: TextStyle(fontSize: 20),
                        ),
                        leading: Radio<Grade>(
                          value: Grade.freshman,
                          groupValue: _grade,
                          onChanged: (value) {
                            setState(() {
                              _grade = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Sophomore",
                          style: TextStyle(fontSize: 20),
                        ),
                        leading: Radio<Grade>(
                          value: Grade.sophomore,
                          groupValue: _grade,
                          onChanged: (value) {
                            setState(() {
                              _grade = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Junior",
                          style: TextStyle(fontSize: 20),
                        ),
                        leading: Radio<Grade>(
                          value: Grade.junior,
                          groupValue: _grade,
                          onChanged: (value) {
                            setState(() {
                              _grade = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Senior",
                          style: TextStyle(fontSize: 20),
                        ),
                        leading: Radio<Grade>(
                          value: Grade.senior,
                          groupValue: _grade,
                          onChanged: (value) {
                            setState(() {
                              _grade = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MenuButton(
                      text: "Submit",
                      clickFunc: () async {
                        bool success = await recordGrade(_grade
                            .toString()
                            .substring(_grade.toString().indexOf(".") + 1));
                        print(success);
                        if (success) {
                          showDialog(
                              context: context,
                              builder: (context) => SuccessNotification());
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) => ErrorNotification());
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MenuButton(
                      text: "View Data",
                      clickFunc: () => pushScreen(
                        context,
                        GradesScreen(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
