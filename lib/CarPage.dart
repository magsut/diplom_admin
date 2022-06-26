import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MainPage.dart';

class carpage extends StatefulWidget {
  Car car;
  carpage({Key? key, required this.car}) : super(key: key);

  @override
  State<carpage> createState() => _carpageState();
}

class _carpageState extends State<carpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff007AFF),
        title: const Text(
          "Приложение администрирования",
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  widget.car.mark + " " + widget.car.model + widget.car.generation,
                style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xff007AFF),
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Expanded(child: ListView.builder(
              itemCount: widget.car.services.length,
                semanticChildCount: widget.car.services.length,
                itemBuilder: (BuildContext context, int i) {
              return serviceCard(service: widget.car.services[i]);
            })),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red, width: 3),
                    color: const Color(0xffFFFFFF),
                    //color: Colors.red,
                    borderRadius:
                    const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: CupertinoButton(
                    onPressed: (){

                    },
                    child: const Center(
                      child: Text('Удалить авто',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.red)),
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

class serviceCard extends StatefulWidget {
  Service service;
  serviceCard({Key? key, required this.service}) : super(key: key);

  @override
  State<serviceCard> createState() => _serviceCardState();
}

class _serviceCardState extends State<serviceCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xff007AFF)),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        child: Column(
          children: [
            Text(widget.service.title),
            Text(widget.service.period.toString() + " тыс. км")
          ],
        )
      ),
    );
  }
}

