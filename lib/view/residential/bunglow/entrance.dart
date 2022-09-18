import 'dart:convert';
import 'package:aashiyan/components/forms.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../../const.dart';
import '../../../controller/api_services.dart';
import 'package:http/http.dart' as http;

 Text headingFont(String s) {
    return Text(
                  s,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                );
  }

class Entrance extends StatefulWidget {
  const Entrance({Key? key}) : super(key: key);
  static const namedRoute = "/entrance";

  @override
  State<Entrance> createState() => _EntranceState();
}

class _EntranceState extends State<Entrance> {
  List<String> floors = [
    "Select",
    "1(G)",
    "2(G+1)",
    "3(G+2)",
    "4(G+3)",
    "more"
  ];

  String selectedFloor = "Select";

  int floorInt = 1;

  String floorController = " ";
  String gateWidthController = " ";
  TextEditingController selectedCarGateController = TextEditingController();
  TextEditingController selectedSidePadestController = TextEditingController();
  String diffrentCustomizedLocationController = " ";
  String securityKioskLengthController = " ";
  String securityKioskWidthController = " ";
  String porchLengthController = " ";
  String porchWidthController = ' ';
  String noOfCar = ' ';
  String foyerWidthController = ' ';
  String foyerLengthController = ' ';
  String verandaWidthController = ' ';
  String verandaLengthController = ' ';

  void floor() {
    setState(() {
      if (selectedFloor == "2(G+1)") {
        floorInt = 2;
      }
      if (selectedFloor == "3(G+2)") {
        floorInt = 3;
      }
      if (selectedFloor == "4(G+3)") {
        floorInt = 4;
      }
      if (selectedFloor == "more") {
        floorInt = int.parse(floorController);
      }
    });
  }

  List<String> lobbyDesign = [
    "Select",
    "Hilighter/welcome wall",
    "shoe rack space"
  ];

  String SelectedLobbyDesign = "Select";

  List<String> entranceGates = ["Select", "10", "12", "14", "more"];
  String entranceSelectedGates = "Select";

  List<String> noOfCars = ["Select", "1", "2", "3", "4", "5", "more"];
  String SelectedCar = "Select";

  List<String> carGate = ["Select", "10", "12", "14", "more"];
  String selectedCarGate = "Select";

  List<String> sidePadest = ["Select", "3", "4", "more"];
  String selectedSidePadest = "Select";

  String securityKiosqArea = "";

  List<String> visualItems = [
    "Select",
    "single height",
    "Double height",
  ];
  String selectedVisual = "Select";

  List<String> carParkingItems = ["Select", "1", "2", "3", "4", "5", "more"];
  String selectedCarParking = "Select";

  bool? outSideOpen = false;
  bool? outSideClosed = false;

  bool? requiredVeranda = false;
  bool? notReqiredVeranda = false;
  int requiredVerandaInt = 0;
  String verandaArea = "0";

  bool? requiredWelcomeLobyy = false;
  int requiredWelcomeLobyyInt = 0;
  String foyerArea = "0";
  String veranda = "";

  bool? notReqiredWelcomeLobby = false;

  bool? carparking = false;
  String carParkingString = "0";

  bool? visualNature = false;
  String visualNaturString = "0";

  bool? securityRequired = false;
  int securityReqInt = 0;

  bool? securityNotRequired = false;

  bool? adjascent = false;
  bool? diffrentCustom = false;

  bool moderate = false;
  String moderateString = "0";

  bool? consult = false;

  bool? oneGate = false;
  String gate = "OneGate";

  bool? twoGate = false;

  bool? porchRequired = false;
  int porchReqInt = 0;

  bool? porchNotRequired = false;
  String porchArea = "";

  String porch = "";

  var printData;
  bool isloading = false;

  Future<void> getData() async {
    try {
      // var client = http.Client();

      var response = await http.get(Uri.parse(
          "http://192.168.1.99:8080/sdplserver/api/edit-bungalow-entrance/179"));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        setState(() {
          printData = jsonResponse;
          print(printData);
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    if (printData == null) {
      setState(() {
        isloading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    if (printData != null) {
      setState(
        () {
          isloading = false;
        },
      );
    }
    return isloading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    requirementText("No. of\nFloors"),
                    SizedBox(
                      width: width * 0.2,
                    ),
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        height: height * 0.03,
                        width: width * 0.2,
                        margin: const EdgeInsets.all(
                          3,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            icon: const Visibility(
                              visible: false,
                              child: Icon(Icons.arrow_downward),
                            ),
                            hint:
                                printData["bungalow_entrance"]["floor"] != null
                                    ? Text(floors[printData["bungalow_entrance"]
                                        ["floor"]])
                                    : Text(selectedFloor),
                            elevation: 16,
                            items: floors
                                .map(
                                  (it) => DropdownMenuItem<String>(
                                    value: it,
                                    child: Text(
                                      it,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (it) {
                              setState(
                                () {
                                  selectedFloor = it!;
                                  if (selectedFloor == "1(G)") {
                                    printData["bungalow_entrance"]["floor"] = 1;
                                  }
                                  if (selectedFloor == "Select") {
                                    printData["bungalow_entrance"]["floor"] = 0;
                                  }
                                  if (selectedFloor == "2(G+1)") {
                                    printData["bungalow_entrance"]["floor"] = 2;
                                  }
                                  if (selectedFloor == "3(G+2)") {
                                    printData["bungalow_entrance"]["floor"] = 3;
                                  }
                                  if (selectedFloor == "4(G+3)") {
                                    printData["bungalow_entrance"]["floor"] = 4;
                                  }
                                  if (selectedFloor == "more") {
                                    printData["bungalow_entrance"]["floor"] = 5;
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    if (selectedFloor == "more") ...[
                      Material(
                        elevation: 5,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        child: SizedBox(
                          height: height * 0.04,
                          width: width * 0.15,
                          child: TextFormField(
                            initialValue: printData["bungalow_entrance"]
                                            ["floor"]
                                        .toString() !=
                                    null
                                ? printData["bungalow_entrance"]["floor"]
                                    .toString()
                                : "floors",
                            style: const TextStyle(fontSize: 14),
                            decoration: const InputDecoration(
                                hintText: "floors",
                                hintStyle: TextStyle(fontSize: 14),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.all(8)
                                //fillColor: Colors.green
                                ),
                            onChanged: ((value) {
                              floorController = value;
                            }),
                          ),
                        ),
                      )
                      // requirementTextFieldCont(
                      //   height,
                      //   width,
                      //   0.04,
                      //   0.15,
                      //   "floors",
                      //   floorController,
                      // ),
                    ]
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: [
                    requirementText("vastu"),
                    SizedBox(
                      width: width * 0.17,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.035,
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 5,
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            height: height * 0.04,
                            child: Row(
                              children: [
                                Checkbox(
                                  activeColor: checkColor,
                                  checkColor: Colors.white,
                                  value: printData["bungalow_entrance"]
                                              ["vastu"] ==
                                          "1"
                                      ? true
                                      : moderate,
                                  onChanged: (value) {
                                    setState(() {
                                      printData["bungalow_entrance"]["vastu"] =
                                          "2";
                                      moderate = !moderate;
                                    });
                                  },
                                ),
                                requirementText("moderate consideration")
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.29,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(5),
                      elevation: 5,
                      child: Container(
                        height: height * 0.04,
                        margin: EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            StatefulBuilder(builder:
                                (BuildContext context, StateSetter setState) {
                              return Checkbox(
                                  activeColor: checkColor,
                                  checkColor: Colors.white,
                                  value: consult,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      consult = value!;
                                    });
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        content: const Text(
                                          "This service is not started yet",
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                consult = false;
                                              });
                                              Navigator.of(context).pop();
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              color: Colors.black,
                                              child: const Text(
                                                "okay",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            }),
                            requirementText("consult")
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                 Align(
                  alignment: Alignment.topLeft,
                  child: headingFont('Ground floor requirement'),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: [
                    requirementText("Entrance"),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 5,
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            height: height * 0.04,
                            child: Row(
                              children: [
                                Checkbox(
                                  activeColor: checkColor,
                                  checkColor: Colors.white,
                                  value: printData['bungalow_entrance']
                                              ['entrance_gate'] ==
                                          "One gate"
                                      ? false
                                      : oneGate,
                                  onChanged: (value) {
                                    setState(() {
                                      printData['bungalow_entrance']
                                          ['entrance_gate'] = "";
                                      oneGate = !oneGate!;
                                      twoGate = false;
                                      adjascent = false;
                                      diffrentCustom = false;
                                    });
                                  },
                                ),
                                requirementText("one gate")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 5,
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            height: height * 0.04,
                            child: Row(
                              children: [
                                Checkbox(
                                    activeColor: checkColor,
                                    checkColor: Colors.white,
                                    value: printData['bungalow_entrance']
                                                ['entrance_gate'] ==
                                            "Two gate"
                                        ? true
                                        : twoGate,
                                    onChanged: (value) {
                                      setState(() {
                                        printData['bungalow_entrance']
                                            ['entrance_gate'] = "";
                                        twoGate = value;
                                        oneGate = false;
                                      });
                                    }),
                                requirementText("two gates")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: [
                    if (oneGate == true ||
                        printData['bungalow_entrance']['entrance_gate'] ==
                            "One gate") ...[
                      SizedBox(
                        width: width * 0.185,
                      ),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          height: height * 0.04,
                          padding: const EdgeInsets.all(3),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                icon: const Visibility(
                                    visible: false,
                                    child: Icon(Icons.arrow_downward)),
                                hint: printData['bungalow_entrance']
                                            ["one_gate"] !=
                                        null
                                    ? Text(printData['bungalow_entrance']
                                        ["one_gate"])
                                    : Text(entranceSelectedGates),
                                items: entranceGates
                                    .map((e) => DropdownMenuItem<String>(
                                          value: e,
                                          child: Text(e),
                                        ))
                                    .toList(),
                                onChanged: (e) => setState(() {
                                      printData['bungalow_entrance']
                                          ["one_gate"] = null;
                                      entranceSelectedGates = e!;
                                    })),
                          ),
                        ),
                      ),
                      valueContainer(height, width, size, 0.044, 0.05),
                      if (entranceSelectedGates == "more") ...[
                        SizedBox(
                          width: width * 0.065,
                        ),
                        Material(
                          elevation: 5,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          child: SizedBox(
                            height: height * 0.04,
                            width: width * 0.2,
                            child: TextFormField(
                              initialValue: printData['bungalow_entrance']
                                          ['one_gate'] !=
                                      null
                                  ? printData['bungalow_entrance']['one_gate']
                                  : gateWidthController,
                              style: const TextStyle(fontSize: 14),
                              decoration: const InputDecoration(
                                hintText: "gatewidth",
                                hintStyle: TextStyle(fontSize: 14),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.all(8),
                                //fillColor: Colors.green
                              ),
                              onChanged: ((value) {
                                gateWidthController = value;
                              }),
                            ),
                          ),
                        ),
                        // requirementTextFieldCont(height, width, 0.04, 0.2,
                        //     "gatewidth", gateWidthController)
                      ]
                    ],
                    if (twoGate == true ||
                        printData['bungalow_entrance']['entrance_gate'] ==
                            "Two gate") ...[
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: width * 0.075,
                              ),
                              Material(
                                borderRadius: BorderRadius.circular(5),
                                elevation: 5,
                                child: Container(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                          activeColor: checkColor,
                                          checkColor: Colors.white,
                                          value: printData['bungalow_entrance']
                                                      ['two_gate'] ==
                                                  "Adjacent"
                                              ? true
                                              : adjascent,
                                          onChanged: (value) {
                                            setState(() {
                                              printData['bungalow_entrance']
                                                  ['two_gate'] = "";
                                              adjascent = value;
                                              diffrentCustom = false;
                                            });
                                          }),
                                      requirementText("Adjacent")
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: width * 0.185,
                              ),
                              Material(
                                borderRadius: BorderRadius.circular(5),
                                elevation: 5,
                                child: Container(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                          activeColor: checkColor,
                                          checkColor: Colors.white,
                                          value: printData['bungalow_entrance']
                                                      ['two_gate'] ==
                                                  "Twogate"
                                              ? true
                                              : diffrentCustom,
                                          onChanged: (value) {
                                            setState(
                                              () {
                                                printData['bungalow_entrance']
                                                    ['two_gate'] = " ";
                                                diffrentCustom = value;
                                                adjascent = false;
                                              },
                                            );
                                          }),
                                      requirementText("Diffrent Custom")
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ]
                  ],
                ),
                if (adjascent == true ||
                    printData["bungalow_entrance"]["two_gate"] ==
                        "Adjacent") ...[
                  Row(
                    children: [
                      SizedBox(
                        height: height * 0.1,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Column(children: [
                          requirementText("Main car gate"),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Row(
                            children: [
                              Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  height: height * 0.045,
                                  width: width * 0.2,
                                  padding: const EdgeInsets.all(3),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                        icon: const Visibility(
                                            visible: false,
                                            child: Icon(Icons.arrow_downward)),
                                        hint: printData['bungalow_entrance']
                                                    ['main_car_gate'] !=
                                                null
                                            ? Text(
                                                printData['bungalow_entrance']
                                                    ['main_car_gate'])
                                            : Text(selectedCarGate),
                                        // value: selectedCarGate,
                                        items: carGate
                                            .map(
                                                (e) => DropdownMenuItem<String>(
                                                      value: e,
                                                      child: Text(e),
                                                    ))
                                            .toList(),
                                        onChanged: (e) => setState(() {
                                              selectedCarGate = e!;
                                              printData['bungalow_entrance']
                                                      ['main_car_gate'] =
                                                  selectedCarGate;
                                            })),
                                  ),
                                ),
                              ),
                              valueContainer(height, width, size, 0.044, 0.05),
                            ],
                          ),
                        ]),
                      ),
                      SizedBox(
                        width: width * 0.3,
                      ),
                      Container(
                        child: Column(children: [
                          requirementText("Side padestriangate"),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Row(
                            children: [
                              Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  height: height * 0.045,
                                  width: width * 0.2,
                                  padding: const EdgeInsets.all(3),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                        icon: const Visibility(
                                            visible: false,
                                            child: Icon(Icons.arrow_downward)),
                                        hint: printData['bungalow_entrance']
                                                    ['side_padestrian_gate'] !=
                                                null
                                            ? Text(
                                                printData['bungalow_entrance']
                                                    ['side_padestrian_gate'])
                                            : Text(selectedCarGate),
                                        // value: selectedSidePadest,
                                        items: sidePadest
                                            .map(
                                                (e) => DropdownMenuItem<String>(
                                                      value: e,
                                                      child: Text(e),
                                                    ))
                                            .toList(),
                                        onChanged: (e) => setState(() {
                                              selectedSidePadest = e!;
                                              printData['bungalow_entrance']
                                                      ['side_padestrian_gate'] =
                                                  selectedSidePadest;
                                            })),
                                  ),
                                ),
                              ),
                              valueContainer(height, width, size, 0.044, 0.05)
                            ],
                          )
                        ]),
                      )
                    ],
                  )
                ],
                if (diffrentCustom == true) ...[
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Text(
                        "Brief about diffrent custom Location",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Material(
                    elevation: 5,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    child: SizedBox(
                      height: height * 0.05,
                      width: width * 0.95,
                      child: TextFormField(
                        initialValue: printData["bungalow_entrance"]
                                    ["different_customized_location"] !=
                                null
                            ? printData["bungalow_entrance"]
                                ["different_customized_location"]
                            : diffrentCustomizedLocationController,
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(
                            hintText: "Brief of diffrent customed location",
                            hintStyle: TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.all(8)
                            //fillColor: Colors.green
                            ),
                        onChanged: (value) {
                          diffrentCustomizedLocationController = value;
                        },
                      ),
                    ),
                  ),
                ],
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.025,
                    ),
                    if (selectedCarGate == "more" && adjascent == true) ...[
                      requirementTextFieldCont(height, width, 0.04, 0.2,
                          "gate width", selectedCarGateController)
                    ],
                    SizedBox(
                      width: width * 0.375,
                    ),
                    if (selectedSidePadest == "more" && adjascent == true) ...[
                      requirementTextFieldCont(height, width, 0.04, 0.28,
                          "side gate width", selectedSidePadestController)
                    ],
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: requirementText("Security kiosk"),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: height * 0.04,
                                  child: Checkbox(
                                      activeColor: checkColor,
                                      checkColor: Colors.white,
                                      value: printData['bungalow_entrance']
                                                  ['security_kiosq_req'] ==
                                              1
                                          ? true
                                          : securityRequired,
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            printData['bungalow_entrance']
                                                ['security_kiosq_req'] = 5;
                                            securityRequired = value;
                                            securityNotRequired = false;
                                          },
                                        );
                                      }),
                                ),
                                requirementText("Required")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: height * 0.04,
                                  child: Checkbox(
                                      activeColor: checkColor,
                                      checkColor: Colors.white,
                                      value: printData['bungalow_entrance']
                                                  ['security_kiosq_req'] ==
                                              0
                                          ? true
                                          : securityNotRequired,
                                      onChanged: (value) {
                                        setState(() {
                                          printData['bungalow_entrance']
                                              ['security_kiosq_req'] = 5;

                                          securityNotRequired = value;
                                          securityRequired = false;
                                        });
                                      }),
                                ),
                                requirementText("Not Required")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (securityRequired == true ||
                    printData['bungalow_entrance']['security_kiosq_req'] ==
                        1) ...[
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      requirementText("Length"),
                      SizedBox(
                        width: width * 0.015,
                      ),
                      Material(
                        elevation: 5,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        child: SizedBox(
                          height: height * 0.04,
                          width: width * 0.15,
                          child: TextFormField(
                            initialValue: printData["bungalow_entrance"]
                                ["security_kiosq_length"],
                            style: const TextStyle(fontSize: 14),
                            decoration: const InputDecoration(
                                hintText: "lenght",
                                hintStyle: TextStyle(fontSize: 14),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.all(8)
                                //fillColor: Colors.green
                                ),
                            onChanged: (value) {
                              securityKioskLengthController = value;
                            },
                          ),
                        ),
                      ),
                      // requirementTextFieldCont(height, width, 0.04, 0.15,
                      //     "length", securityKioskLengthController),
                      valueContainer(height, width, size, 0.04, 0.05),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      requirementText("Width"),
                      SizedBox(
                        width: width * 0.015,
                      ),
                      Material(
                        elevation: 5,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        child: SizedBox(
                          height: height * 0.04,
                          width: width * 0.15,
                          child: TextFormField(
                            initialValue: printData["bungalow_entrance"]
                                ["security_kiosq_width"],
                            style: const TextStyle(fontSize: 14),
                            decoration: const InputDecoration(
                                hintText: "width",
                                hintStyle: TextStyle(fontSize: 14),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.all(8)
                                //fillColor: Colors.green
                                ),
                            onChanged: (value) {
                              securityKioskWidthController = value;
                            },
                          ),
                        ),
                      ),
                      valueContainer(height, width, size, 0.04, 0.05),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      requirementText("help ?")
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Material(
                    elevation: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      color: Colors.white,
                      child: SizedBox(
                        width: width * 9,
                        height: height * 0.3,
                        child: FutureBuilder(
                            future: getRecent(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Container(
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              } else {
                                return CarouselSlider.builder(
                                  itemCount: bunglowPageRecentList.length,
                                  itemBuilder: (context, i, id) {
                                    return Container(
                                      height: height * 0.4,
                                      width: width * 0.9,
                                      child: Image.network(
                                        imageUrl +
                                            bunglowPageRecentList[i]
                                                ["img_path"],
                                        fit: BoxFit.fill,
                                      ),
                                    );
                                  },
                                  options: CarouselOptions(
                                    autoPlay: true,
                                    enableInfiniteScroll: true,
                                    autoPlayAnimationDuration:
                                        const Duration(milliseconds: 800),
                                    viewportFraction: 1,
                                  ),
                                );
                              }
                            }),
                      ),
                    ),
                  )
                ],
                SizedBox(
                  height: height * 0.02,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: requirementText("Porch"),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: height * 0.04,
                                  child: Checkbox(
                                    activeColor: checkColor,
                                    checkColor: Colors.white,
                                    value: printData["bungalow_entrance"]
                                                ['porch_req'] ==
                                            1
                                        ? true
                                        : porchRequired,
                                    onChanged: (value) {
                                      setState(() {
                                        porchRequired = value;
                                        porchNotRequired = false;
                                        printData["bungalow_entrance"]
                                            ['porch_req'] = 5;
                                      });
                                    },
                                  ),
                                ),
                                requirementText("Required")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: height * 0.04,
                                  child: Checkbox(
                                      activeColor: checkColor,
                                      checkColor: Colors.white,
                                      value: printData["bungalow_entrance"]
                                                  ['porch_req'] ==
                                              0
                                          ? true
                                          : porchNotRequired,
                                      onChanged: (value) {
                                        setState(() {
                                          porchNotRequired = value;
                                          porchRequired = false;
                                          printData["bungalow_entrance"]
                                              ['porch_req'] = 5;
                                        });
                                      }),
                                ),
                                requirementText("Not Required")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (porchRequired == true ||
                    printData["bungalow_entrance"]['porch_req'] == 1) ...[
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      requirementText("Length"),
                      SizedBox(
                        width: width * 0.015,
                      ),
                      Material(
                        elevation: 5,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        child: SizedBox(
                          height: height * 0.04,
                          width: width * 0.15,
                          child: TextFormField(
                            initialValue: printData['bungalow_entrance']
                                ['porch_length'],
                            style: const TextStyle(fontSize: 14),
                            decoration: const InputDecoration(
                              hintText: "length",
                              hintStyle: TextStyle(fontSize: 14),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              isDense: true,
                              contentPadding: EdgeInsets.all(8),
                              //fillColor: Colors.green
                            ),
                            onChanged: ((value) {
                              porchLengthController = value;
                            }),
                          ),
                        ),
                      ),
                      valueContainer(
                        height,
                        width,
                        size,
                        0.04,
                        0.05,
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      requirementText("Width"),
                      SizedBox(
                        width: width * 0.015,
                      ),
                      Material(
                        elevation: 5,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        child: SizedBox(
                          height: height * 0.04,
                          width: width * 0.15,
                          child: TextFormField(
                            initialValue: printData['bungalow_entrance']
                                ['porch_width'],
                            style: const TextStyle(fontSize: 14),
                            decoration: const InputDecoration(
                              hintText: "width",
                              hintStyle: TextStyle(fontSize: 14),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              isDense: true,
                              contentPadding: EdgeInsets.all(8),
                              //fillColor: Colors.green
                            ),
                            onChanged: ((value) {
                              porchWidthController = value;
                            }),
                          ),
                        ),
                      ),
                      valueContainer(height, width, size, 0.04, 0.05),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      requirementText("help ?")
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(5),
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.only(right: 10),
                          child: Row(
                            children: [
                              SizedBox(
                                height: height * 0.04,
                                child: Checkbox(
                                    activeColor: checkColor,
                                    checkColor: Colors.white,
                                    value: printData['bungalow_entrance']
                                                ['visual_nature'] ==
                                            "1"
                                        ? true
                                        : visualNature,
                                    onChanged: (value) {
                                      setState(() {
                                        printData['bungalow_entrance']
                                            ['visual_nature'] = "0";
                                        visualNature = value;
                                      });
                                    }),
                              ),
                              requirementText("visual nature")
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  if (visualNature == true ||
                      printData['bungalow_entrance']['visual_nature'] ==
                          "1") ...[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: height * 0.045,
                          width: width * 0.3,
                          padding: const EdgeInsets.all(3),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              icon: const Visibility(
                                  visible: false,
                                  child: Icon(Icons.arrow_downward)),
                              hint: printData['bungalow_entrance'][''],
                              value: selectedVisual,
                              items: visualItems
                                  .map((e) => DropdownMenuItem<String>(
                                        value: e,
                                        child: Text(e),
                                      ))
                                  .toList(),
                              onChanged: (e) => setState(
                                () {
                                  selectedVisual = e!;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                  ],
                  Material(
                    elevation: 10,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      color: Colors.white,
                      child: SizedBox(
                        width: width * 9,
                        height: height * 0.3,
                        child: FutureBuilder(
                            future: getRecent(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Container(
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              } else {
                                return CarouselSlider.builder(
                                  itemCount: bunglowPageRecentList.length,
                                  itemBuilder: (context, i, id) {
                                    return Container(
                                      height: height * 0.4,
                                      width: width * 0.9,
                                      child: Image.network(
                                        imageUrl +
                                            bunglowPageRecentList[i]
                                                ["img_path"],
                                        fit: BoxFit.fill,
                                      ),
                                    );
                                  },
                                  options: CarouselOptions(
                                    autoPlay: true,
                                    enableInfiniteScroll: true,
                                    autoPlayAnimationDuration:
                                        const Duration(milliseconds: 800),
                                    viewportFraction: 1,
                                  ),
                                );
                              }
                            }),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      borderRadius: BorderRadius.circular(5),
                      elevation: 5,
                      child: Container(
                        width: width * 0.4,
                        child: Row(
                          children: [
                            SizedBox(
                              height: height * 0.04,
                              child: Checkbox(
                                  activeColor: checkColor,
                                  checkColor: Colors.white,
                                  value: carparking,
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        carparking = value;
                                      },
                                    );
                                  }),
                            ),
                            requirementText("car parking space"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
                SizedBox(
                  height: height * 0.01,
                ),
                if (carparking == true) ...[
                  Row(
                    children: [
                      const Text("No. of Colors"),
                      SizedBox(
                        width: width * 0.04,
                      ),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: height * 0.035,
                          width: width * 0.15,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                icon: const Visibility(
                                  visible: false,
                                  child: Icon(Icons.arrow_downward),
                                ),
                                hint: printData['bungalow_entrance']
                                            ['car_parking_space'] !=
                                        null
                                    ? Text(printData['bungalow_entrance']
                                        ['car_parking_space'])
                                    : Text(SelectedCar),
                                // value: SelectedCar,
                                items: noOfCars
                                    .map((e) => DropdownMenuItem<String>(
                                          value: e,
                                          child: Text(e),
                                        ))
                                    .toList(),
                                onChanged: (e) => setState(() {
                                      SelectedCar = e!;
                                      printData['bungalow_entrance']
                                          ['car_parking_space'] = SelectedCar;
                                    })),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.03,
                      ),
                      if (SelectedCar == "more") ...[
                        Material(
                          elevation: 5,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          child: SizedBox(
                            height: height * 0.035,
                            width: width * 0.2,
                            child: TextFormField(
                              style: const TextStyle(fontSize: 14),
                              decoration: const InputDecoration(
                                  hintText: "no of cars",
                                  hintStyle: TextStyle(fontSize: 14),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(8)
                                  //fillColor: Colors.green
                                  ),
                              onChanged: (value) {
                                noOfCar = value;
                                printData["bungalow_entrance"]
                                    ['car_parking_space'] = noOfCar;
                              },
                            ),
                          ),
                        ),
                      ],
                    ],
                  )
                ],
                SizedBox(
                  height: height * 0.01,
                ),
                if (porchRequired == true) ...[
                  Material(
                    elevation: 10,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      color: Colors.white,
                      child: SizedBox(
                        width: width * 9,
                        height: height * 0.3,
                        child: FutureBuilder(
                            future: getRecent(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Container(
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              } else {
                                return CarouselSlider.builder(
                                  itemCount: bunglowPageRecentList.length,
                                  itemBuilder: (context, i, id) {
                                    return Container(
                                      height: height * 0.4,
                                      width: width * 0.9,
                                      child: Image.network(
                                        imageUrl +
                                            bunglowPageRecentList[i]
                                                ["img_path"],
                                        fit: BoxFit.fill,
                                      ),
                                    );
                                  },
                                  options: CarouselOptions(
                                    autoPlay: true,
                                    enableInfiniteScroll: true,
                                    autoPlayAnimationDuration:
                                        const Duration(milliseconds: 800),
                                    viewportFraction: 1,
                                  ),
                                );
                              }
                            }),
                      ),
                    ),
                  ),
                ],
                SizedBox(
                  height: height * 0.01,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: requirementText("Foyer/welcome lobby"),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: [
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(5),
                      elevation: 5,
                      child: Container(
                        width: width * 0.4,
                        child: Row(
                          children: [
                            SizedBox(
                              height: height * 0.04,
                              child: Checkbox(
                                  activeColor: checkColor,
                                  checkColor: Colors.white,
                                  value: printData['bungalow_entrance']
                                              ['foyer_req'] ==
                                          1
                                      ? true
                                      : requiredWelcomeLobyy,
                                  onChanged: (value) {
                                    setState(() {
                                      requiredWelcomeLobyy = value;
                                      printData['bungalow_entrance']
                                          ['foyer_req'] = 5;
                                      notReqiredWelcomeLobby = false;
                                    });
                                  }),
                            ),
                            requirementText("Required"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(5),
                      elevation: 5,
                      child: Container(
                        width: width * 0.4,
                        child: Row(
                          children: [
                            SizedBox(
                              height: height * 0.04,
                              child: Checkbox(
                                  activeColor: checkColor,
                                  checkColor: Colors.white,
                                  value: printData['bungalow_entrance']
                                              ['foyer_req'] ==
                                          0
                                      ? true
                                      : notReqiredWelcomeLobby,
                                  onChanged: (value) {
                                    setState(() {
                                      notReqiredWelcomeLobby = value;
                                      requiredWelcomeLobyy = false;
                                      printData['bungalow_entrance']
                                          ['foyer_req'] = 5;
                                    });
                                  }),
                            ),
                            requirementText("Not Required"),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                if (requiredWelcomeLobyy == true ||
                    printData['bungalow_entrance']['foyer_req'] == 1) ...[
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      requirementText("Length"),
                      SizedBox(
                        width: width * 0.015,
                      ),
                      Material(
                        elevation: 5,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        child: SizedBox(
                          height: height * 0.04,
                          width: width * 0.15,
                          child: TextFormField(
                            initialValue: printData['bungalow_entrance']
                                ['foyer_length'],
                            style: const TextStyle(fontSize: 14),
                            decoration: const InputDecoration(
                                hintText: "length",
                                hintStyle: TextStyle(fontSize: 14),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.all(8)
                                //fillColor: Colors.green
                                ),
                            onChanged: (value) {
                              foyerLengthController = value;
                            },
                          ),
                        ),
                      ),
                      valueContainer(height, width, size, 0.04, 0.05),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      requirementText("Width"),
                      SizedBox(
                        width: width * 0.015,
                      ),
                      Material(
                        elevation: 5,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        child: SizedBox(
                          height: height * 0.04,
                          width: width * 0.15,
                          child: TextFormField(
                            initialValue: printData['bungalow_entrance']
                                ['foyer_width'],
                            style: const TextStyle(fontSize: 14),
                            decoration: const InputDecoration(
                                hintText: "Width",
                                hintStyle: TextStyle(fontSize: 14),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.all(8)
                                //fillColor: Colors.green
                                ),
                            onChanged: (value) {
                              foyerWidthController = value;
                            },
                          ),
                        ),
                      ),
                      valueContainer(height, width, size, 0.04, 0.05),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      requirementText("help ?")
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      requirementText("Lobby Design"),
                      SizedBox(
                        width: width * 0.03,
                      ),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          height: height * 0.035,
                          width: width * 0.45,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              icon: const Visibility(
                                  visible: false,
                                  child: Icon(Icons.arrow_downward)),
                              hint: printData['bungalow_entrance']
                                          ['foyer_lobby'] !=
                                      null
                                  ? Text(printData['bungalow_entrance']
                                      ['foyer_lobby'])
                                  : Text(SelectedLobbyDesign),
                              // value: SelectedLobbyDesign,
                              items: lobbyDesign
                                  .map(
                                    (e) => DropdownMenuItem<String>(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (e) => setState(
                                () {
                                  SelectedLobbyDesign = e!;
                                  printData['bungalow_entrance']
                                      ['foyer_lobby'] = SelectedLobbyDesign;
                                },
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Material(
                    elevation: 10,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      color: Colors.white,
                      child: SizedBox(
                        width: width * 9,
                        height: height * 0.3,
                        child: FutureBuilder(
                            future: getRecent(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Container(
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              } else {
                                return CarouselSlider.builder(
                                  itemCount: bunglowPageRecentList.length,
                                  itemBuilder: (context, i, id) {
                                    return Container(
                                      height: height * 0.4,
                                      width: width * 0.9,
                                      child: Image.network(
                                        imageUrl +
                                            bunglowPageRecentList[i]
                                                ["img_path"],
                                        fit: BoxFit.fill,
                                      ),
                                    );
                                  },
                                  options: CarouselOptions(
                                    autoPlay: true,
                                    enableInfiniteScroll: true,
                                    autoPlayAnimationDuration:
                                        const Duration(milliseconds: 800),
                                    viewportFraction: 1,
                                  ),
                                );
                              }
                            }),
                      ),
                    ),
                  ),
                ],
                SizedBox(
                  height: height * 0.01,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: requirementText("veranda"),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: [
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(5),
                      elevation: 5,
                      child: Container(
                        width: width * 0.4,
                        child: Row(
                          children: [
                            SizedBox(
                              height: height * 0.04,
                              child: Checkbox(
                                  activeColor: checkColor,
                                  checkColor: Colors.white,
                                  value: printData["bungalow_entrance"]
                                              ["verandah_req"] ==
                                          1
                                      ? true
                                      : requiredVeranda,
                                  onChanged: (value) {
                                    setState(() {
                                      printData["bungalow_entrance"]
                                          ["verandah_req"] = 5;
                                      requiredVeranda = value;
                                      notReqiredVeranda = false;
                                    });
                                  }),
                            ),
                            requirementText("Required"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(5),
                      elevation: 5,
                      child: Container(
                        width: width * 0.4,
                        child: Row(
                          children: [
                            SizedBox(
                              height: height * 0.04,
                              child: Checkbox(
                                  activeColor: checkColor,
                                  checkColor: Colors.white,
                                  value: printData["bungalow_entrance"]
                                              ["verandah_req"] ==
                                          0
                                      ? true
                                      : notReqiredVeranda,
                                  onChanged: (value) {
                                    setState(() {
                                      printData["bungalow_entrance"]
                                          ["verandah_req"] = 5;
                                      notReqiredVeranda = value;
                                      requiredVeranda = false;
                                    });
                                  }),
                            ),
                            requirementText("Not Required"),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                if (requiredVeranda == true ||
                    printData["bungalow_entrance"]["verandah_req"] == 1) ...[
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      requirementText("Length"),
                      SizedBox(
                        width: width * 0.015,
                      ),
                      Material(
                        elevation: 5,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        child: SizedBox(
                          height: height * 0.04,
                          width: width * 0.15,
                          child: TextFormField(
                            initialValue: printData['bungalow_entrance']
                                ['verandah_length'],
                            style: const TextStyle(fontSize: 14),
                            decoration: const InputDecoration(
                                hintText: "Width",
                                hintStyle: TextStyle(fontSize: 14),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.all(8)
                                //fillColor: Colors.green
                                ),
                            onChanged: (value) {
                              verandaLengthController = value;
                            },
                          ),
                        ),
                      ),
                      valueContainer(height, width, size, 0.04, 0.05),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      requirementText("Width"),
                      SizedBox(
                        width: width * 0.015,
                      ),
                      Material(
                        elevation: 5,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        child: SizedBox(
                          height: height * 0.04,
                          width: width * 0.15,
                          child: TextFormField(
                            initialValue: printData['bungalow_entrance']
                                ['verandah_width'],
                            style: const TextStyle(fontSize: 14),
                            decoration: const InputDecoration(
                                hintText: "length",
                                hintStyle: TextStyle(fontSize: 14),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.all(8)
                                //fillColor: Colors.green
                                ),
                            onChanged: (value) {
                              verandaWidthController = value;
                            },
                          ),
                        ),
                      ),
                      valueContainer(height, width, size, 0.04, 0.05),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      requirementText("help ?")
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      borderRadius: BorderRadius.circular(5),
                      elevation: 5,
                      child: Container(
                        width: width * 0.4,
                        child: Row(
                          children: [
                            SizedBox(
                              height: height * 0.04,
                              child: Checkbox(
                                  activeColor: checkColor,
                                  checkColor: Colors.white,
                                  value: printData["bungalow_entrance"]
                                              ["verandah"] ==
                                          "Out side open"
                                      ? true
                                      : outSideOpen,
                                  onChanged: (value) {
                                    setState(() {
                                      outSideOpen = value;
                                      outSideClosed = false;
                                      printData["bungalow_entrance"]
                                          ["verandah"] = "1";
                                    });
                                  }),
                            ),
                            requirementText("out side open"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(5),
                    elevation: 5,
                    child: Container(
                      width: width * 1,
                      child: Row(
                        children: [
                          SizedBox(
                            height: height * 0.04,
                            child: Checkbox(
                                activeColor: checkColor,
                                checkColor: Colors.white,
                                value: printData["bungalow_entrance"]
                                            ["verandah"] ==
                                        "Out side Closed with glass or grill"
                                    ? true
                                    : outSideClosed,
                                onChanged: (value) {
                                  setState(() {
                                    outSideClosed = value;
                                    outSideOpen = false;
                                    printData["bungalow_entrance"]["verandah"] =
                                        "4";
                                  });
                                }),
                          ),
                          requirementText(
                              "Out side closed with glass or grill"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Material(
                    elevation: 10,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      color: Colors.white,
                      child: SizedBox(
                        width: width * 9,
                        height: height * 0.3,
                        child: FutureBuilder(
                            future: getRecent(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Container(
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              } else {
                                return CarouselSlider.builder(
                                  itemCount: bunglowPageRecentList.length,
                                  itemBuilder: (context, i, id) {
                                    return Container(
                                      height: height * 0.4,
                                      width: width * 0.9,
                                      child: Image.network(
                                        imageUrl +
                                            bunglowPageRecentList[i]
                                                ["img_path"],
                                        fit: BoxFit.fill,
                                      ),
                                    );
                                  },
                                  options: CarouselOptions(
                                    autoPlay: true,
                                    enableInfiniteScroll: true,
                                    autoPlayAnimationDuration:
                                        const Duration(milliseconds: 800),
                                    viewportFraction: 1,
                                  ),
                                );
                              }
                            }),
                      ),
                    ),
                  ),
                ],
                SizedBox(
                  height: height * 0.01,
                ),
                InkWell(
                  onTap: () {
                    setState(
                      () {
                        if (moderate == true) {
                          moderateString = "0";
                        }
                        floor();
                        if (oneGate == false) {
                          gate = "Twogate";
                        }
                        if (selectedCarGate == "more") {
                          selectedCarGate = selectedCarGateController.text;
                        }
                        if (selectedSidePadest == "more") {
                          selectedSidePadest =
                              selectedSidePadestController.text;
                        }

                        if (securityRequired == true) {
                          securityReqInt = 1;
                          int securityArea =
                              int.parse(securityKioskLengthController) *
                                  int.parse(securityKioskWidthController);

                          securityKiosqArea = securityArea.toString();
                        }
                        if (porchRequired == true) {
                          porchReqInt = 1;
                          int pArea = int.parse(porchLengthController) *
                              int.parse(porchWidthController);
                          porchArea = pArea.toString();
                        }
                        if (visualNature == true) {
                          porch = "visual nature ";
                        }
                        if (carparking == true) {
                          porch = "car parking space";
                        }
                        if (carparking == true && visualNature == true) {
                          porch = "visual nature car parking space ";
                        }
                        if (carparking == true) {
                          carParkingString = "1";
                        }
                        if (visualNature == true) {
                          visualNaturString = "1";
                        }
                        if (requiredWelcomeLobyy == true) {
                          requiredWelcomeLobyyInt = 1;
                          int fArea = int.parse(foyerLengthController) *
                              int.parse(foyerWidthController);

                          porchArea = fArea.toString();
                        }
                        if (requiredVeranda == true) {
                          requiredVerandaInt = 1;
                          int vArea = 0;

                          vArea = int.parse(verandaLengthController) *
                              int.parse(verandaWidthController);
                          verandaArea = vArea.toString();

                          if (outSideOpen == true) {
                            veranda = "out side open";
                          }
                          if (outSideClosed == true) {
                            veranda = "out side closed with glass or grill";
                          }
                        }
                      },
                    );
                    entrancePost(
                      123,
                      moderateString,
                      floorInt,
                      gate,
                      entranceSelectedGates,
                      gate,
                      selectedCarGate,
                      selectedSidePadest,
                      diffrentCustomizedLocationController,
                      securityReqInt,
                      securityKioskLengthController,
                      securityKioskWidthController,
                      securityKiosqArea,
                      0,
                      porchReqInt,
                      porchLengthController,
                      porchWidthController,
                      porchArea,
                      porch,
                      visualNaturString,
                      carParkingString,
                      requiredWelcomeLobyyInt,
                      foyerLengthController,
                      foyerWidthController,
                      foyerArea,
                      SelectedLobbyDesign,
                      requiredVerandaInt,
                      verandaLengthController,
                      verandaWidthController,
                      verandaArea,
                      veranda,
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.circular(4)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: const Text(
                      "save and continue",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                )
              ],
            ),
          );
  }

 
}
