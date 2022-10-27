// ignore_for_file: curly_braces_in_flow_control_structures, sized_box_for_whitespace

import 'package:aashiyan/components/constant.dart';
import 'package:aashiyan/controller/api_services.dart';

// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:aashiyan/view/residential/bunglow/bungalow_detail.dart';
import 'package:aashiyan/view/residential/bunglow/entrance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Hotels extends StatefulWidget {
  const Hotels({super.key});

  @override
  State<Hotels> createState() => _HotelsState();
}

class _HotelsState extends State<Hotels> {
  bool isloading = false;
  var gallery;
  @override
  initState() {
    super.initState();
    getData();
  }

  // }

  void getData() async {
    gallery = await getGalleryAPI(HOSPITALITY);

    if (gallery != null)
      setState(() {
        isloading = true;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: headingFont('Hospitality'),
        ),
        body: Center(
          child: isloading == false
              ? CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Column(
                  children: [
                    for (var i = 0; i < gallery.length; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: InkWell(
                          onTap: () {
                            Get.to(BungalowDetail(
                              img_path: gallery[i]['img_path'],
                              project_location: gallery[i]['project_location'],
                              description: gallery[i]['description'],
                              id: gallery[i]['id'],
                            ));
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0)),
                            shadowColor: Colors.blueAccent,
                            elevation: 10,
                            child: Column(
                              children: [
                                Container(
                                  height: 225,
                                  width:
                                      MediaQuery.of(context).size.width * .95,
                                  child: gallery == []
                                      ? const CircularProgressIndicator()
                                      : Image.network(
                                          'https://sdplweb.com/sdpl/public/storage/${(gallery[i]['img_path'])}',
                                          fit: BoxFit.fill,
                                        ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Container(
                                    child: gallery == []
                                        ? const CircularProgressIndicator()
                                        : headingFont(gallery[i]['img_title']
                                            .toString()
                                            .toUpperCase()),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, bottom: 10),
                                  child: Container(
                                    child: gallery == []
                                        ? const CircularProgressIndicator()
                                        : headingFont(gallery[i]
                                                ['project_location']
                                            .toString()
                                            .toUpperCase()),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                  ],
                )),
        ));
  }
}
