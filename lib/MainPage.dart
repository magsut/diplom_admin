import 'dart:convert';

import 'package:diplom_admin/ServerMetods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AddCar.dart';
import 'CarPage.dart';

class AppData{
  static List<Car> cars = [];
}

class Car{
  String mark;
  String model;
  String generation;
  String petrol_type;
  List<Service> services = [];

  Car(this.mark, this.model, this.generation, this.petrol_type);

  factory Car.fromJson(Map<String, dynamic> json){
    return Car(json['mark'], json['model'], json['generation'], json['petrol_type']);
  }
}

class Service{
  String title;
  int period;

  Service(this.title, this.period);

  @override
  String toString() {
    return 'Service{title: $title, period: $period}';
  }

  Map<String, String> toJson(){
    return {
      'title' : title,
      'period': period.toString()
    };
  }

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(json['title'], json['period']);
  }
}

class mainPage extends StatefulWidget {
  const mainPage({Key? key}) : super(key: key);

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  @override
  Widget build(BuildContext context) {
      
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff007AFF),
        title: const Text(
          "Приложение администрирования",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(itemCount: AppData.cars.length,itemBuilder: (BuildContext context, int i) {
                return CarCard(car: AppData.cars[i], callback: setState,);
              }),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 3),
                    color: const Color(0xffFFFFFF),
                    //color: Colors.red,
                    borderRadius:
                    const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: CupertinoButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddCar(callback: setState,)));
                    },
                    child: const Center(
                      child: Text('Добавить авто',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black)),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CarCard extends StatefulWidget {
  Function callback;
  Car car;
  CarCard({Key? key, required this.car, required this.callback}) : super(key: key);

  @override
  State<CarCard> createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          String data = await ServerMetods.getServicers(widget.car.mark, widget.car.model, widget.car.generation);

          var Data = jsonDecode(data);

          widget.car.services = [];

          for(var service in Data){
            widget.car.services.add(Service.fromJson(service));
          }

          Navigator.of(context).push(MaterialPageRoute(builder: (context) => carpage(car: widget.car,)));
        },
        child: Container(
          height: 80,
          decoration: BoxDecoration(
              color: Color(0xff007AFF),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Color(0xffF2F2F7), blurRadius: 20)]),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.car.mark + " " + widget.car.model, style: const TextStyle(color: Colors.white)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.car.generation, style: const TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

