import 'dart:convert';

import 'package:diplom_admin/MainPage.dart';
import 'package:diplom_admin/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddCar extends StatefulWidget {
  final Function callback;

  const AddCar({Key? key, required this.callback}) : super(key: key);

  @override
  State<AddCar> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AddCar> {
  bool isLoading = false;

  List<ServiceCard> cards = [];
  TextEditingController manufacturer = TextEditingController();
  TextEditingController model = TextEditingController();
  TextEditingController startYear = TextEditingController();
  TextEditingController endYear = TextEditingController();

  List<Service> services = [];

  @override
  Widget build(BuildContext context) {
    return isLoading? const Loading() : Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff007AFF),
        title: const Text(
          "Приложение администрирования",
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
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
                            placeholder: "Производитель",
                            keyboardType: TextInputType.text,
                            controller: manufacturer,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: (MediaQuery.of(context).size.width - 32),
                          child: CupertinoTextField(
                            placeholder: "Модель",
                            keyboardType: TextInputType.text,
                            controller: model,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: (MediaQuery.of(context).size.width - 32),
                          child: CupertinoTextField(
                            placeholder: "Поколение",
                            keyboardType: TextInputType.text,
                            controller: startYear,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: (MediaQuery.of(context).size.width - 32),
                          child: CupertinoTextField(
                            placeholder: "Тип топлива",
                            keyboardType: TextInputType.text,
                            controller: endYear,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: services.length,
                    itemBuilder: (BuildContext context, int i) {
                      return ServiceCard(service: services[i]);
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 8, right: 80),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: RaisedButton(
                    onPressed: () async {
                      Car c = Car(manufacturer.text, model.text, startYear.text, endYear.text);
                      c.services = services;
                      AppData.cars.add(c);

                      widget.callback(() {});

                      Navigator.of(context).pop();
                    },
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    color: const Color(0xff007AFF),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .85,
                      height: 55,
                      child: const Center(
                        child: Text(
                          'Сохранить',
                          style: TextStyle(
                            color: Color(0xffF2F2F7),
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff007AFF),
        onPressed: () {
          setState(() {
            //cards.add(ServiceCard(localId: cards.length + 1));
            services.add(Service('', -1));
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
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
                    ),
                  ),
                  
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

