import 'package:app_test/widget/key_item.dart';
import 'package:app_test/widget/pie_data.dart';
import 'package:app_test/widget/scaffold_wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import "package:flutter/material.dart";

class GradesScreen extends StatelessWidget {
  final Map<String, Color> _keyData = {
    "Fr": Colors.lightBlue,
    "So": Colors.lightGreen,
    "Ju": Colors.yellow,
    "Se": Colors.red
  };

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      content: Center(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('meta')
              .doc('grades')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            Map<String, dynamic> map = snapshot.data.data();
            var sum = map["freshman"] +
                map["sophomore"] +
                map["junior"] +
                map["senior"];

            if (sum <= 0) {
              return Text(
                "No data.",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              );
            }

            double fr = map["freshman"] / sum * 100;
            double so = map["sophomore"] / sum * 100;
            double ju = map["junior"] / sum * 100;
            double se = map["senior"] / sum * 100;

            double width = MediaQuery.of(context).size.width;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: width / 1.1,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Key",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ..._keyData.keys.map((String key) {
                        return KeyItem(
                          key,
                          _keyData[key],
                        );
                      }).toList()
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: width,
                  height: width,
                  child: PieChart(
                    PieChartData(
                      sections: [
                        PieData(fr, _keyData["Fr"], width / 3),
                        PieData(so, _keyData["So"], width / 3),
                        PieData(ju, _keyData["Ju"], width / 3),
                        PieData(se, _keyData["Se"], width / 3)
                      ],
                      centerSpaceRadius: 0,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
