import 'dart:convert';

import 'package:diplom_admin/Auth.dart';
import 'package:diplom_admin/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

List<Service> carServices = [];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return const Authorise();
  }
}

class ServiceCard extends StatefulWidget {
  const ServiceCard({Key? key, required this.service}) : super(key: key);
  final Service service;

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  late TextEditingController titleController;
  late TextEditingController periodController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff007AFF)),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: (MediaQuery.of(context).size.width - 32),
                child: CupertinoTextField(
                  placeholder: "Описание",
                  keyboardType: TextInputType.text,
                  controller: titleController,
                  enabled: widget.service.isEnable,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: (MediaQuery.of(context).size.width - 32) * .8,
                    child: CupertinoTextField(
                      placeholder: "Период",
                      keyboardType: TextInputType.number,
                      controller: periodController,
                      enabled: widget.service.isEnable,
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        widget.service.title = titleController.text;
                        widget.service.period = int.parse(periodController.text);

                        widget.service.isEnable = !widget.service.isEnable;
                         setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.service.isEnable
                                ? const Color(0xff007AFF)
                                : Colors.transparent),
                        child: widget.service.isEnable
                            ? const Icon(
                                Icons.done_outline,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.done,
                                color: Color(0xff007AFF),
                              ),
                      )
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.service.title);
    periodController = TextEditingController(text: widget.service.period == -1 ? '' : widget.service.period.toString());
  }
}

class Service{
  String title;
  int period;
  int localId;
  bool isEnable = true;

  Service(this.title, this.period, this.localId);

  @override
  String toString() {
    return 'Service{title: $title, period: $period, localId: $localId}';
  }

  Map<String, String> toJson(){
    return {
      'title' : title,
      'period': period.toString(),
      'localId': localId.toString()
    };
  }
}
