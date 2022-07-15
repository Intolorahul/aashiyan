import 'package:aashiyan/constants/bungalow_steps.dart';
import 'package:flutter/material.dart';

import '../../../const.dart';
import '../../../constants/app_bar.dart';

class Requirement extends StatefulWidget {
  static const namedRoute = "/intrestedNext";

  @override
  State<Requirement> createState() => _RequirementState();
}

class _RequirementState extends State<Requirement> {
  List<String> items = ["select", "Mr", "Mrs", "Ms", "M/s"];
  String selectedItems = 'select';

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: requirementColor,
      appBar: appBar("Requirement"),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            bungalowSteps(context),
            Row(
              children: [
                const Text(
                  "Name",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: height * 0.02,
                ),
                Material(
                  elevation: 5,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    height: height * 0.04,
                    width: width * 0.19,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedItems,
                        icon: const Icon(Icons.keyboard_arrow_down_sharp),
                        elevation: 16,
                        items: items
                            .map((it) => DropdownMenuItem<String>(
                                  value: it,
                                  child: Text(it,
                                      style:
                                          TextStyle(fontSize: height * 0.02)),
                                ))
                            .toList(),
                        onChanged: (it) => setState(() => selectedItems = it!),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Material(
                  elevation: 5,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  child: SizedBox(
                    height: height * 0.04,
                    width: width * 0.25,
                    child: TextFormField(
                      style: TextStyle(fontSize: height * 0.018),
                      decoration: InputDecoration(
                          hintText: "firstname",
                          hintStyle: TextStyle(fontSize: height * 0.018),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.all(8)
                          //fillColor: Colors.green
                          ),
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.01,
                ),
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: TextFormField(
                      style: TextStyle(fontSize: height * 0.018),
                      decoration: InputDecoration(
                          hintText: "last name",
                          hintStyle: TextStyle(fontSize: height * 0.018),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.all(8)
                          //fillColor: Colors.green
                          ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              children: [
                Text(
                  "Email",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: width * 0.05,
                ),
                Material(
                  elevation: 5,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  child: SizedBox(
                    height: height * 0.04,
                    width: width * 0.6,
                    child: TextFormField(
                      style: TextStyle(fontSize: height * 0.018),
                      decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(fontSize: height * 0.018),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.all(8)
                          //fillColor: Colors.green
                          ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "project \n Address",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: width * 0.05,
                ),
                Material(
                  elevation: 5,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  child: SizedBox(
                    height: height * 0.04,
                    width: width * 0.6,
                    child: TextFormField(
                      style: TextStyle(fontSize: height * 0.018),
                      decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(fontSize: height * 0.018),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.all(8)
                          //fillColor: Colors.green
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNav(),
    );
  }
}
