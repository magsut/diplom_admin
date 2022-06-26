import 'dart:convert';

import 'package:diplom_admin/ServerMetods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MainPage.dart';

class Authorise extends StatefulWidget {

  const Authorise({Key? key}) : super(key: key);

  @override
  State<Authorise> createState() => _AuthoriseState();
}

class _AuthoriseState extends State<Authorise> {
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();


  Future<bool> singMeIn() async {

    setState(() {
      isLoading  = true;
    });

    try{

      if(passController.text == "admin" && emailController.text == "admin"){
        String data = await ServerMetods.getAllCars();

        var Data = jsonDecode(data);

        for(var car in Data){
          print(car);
          AppData.cars.add(Car.fromJson(car));
        }
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Authorise()));
        showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                title: const Text('Ошибка'),
                content: const Text("Неверные логин и пароль"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'OK');
                    },
                    child: const Text('OK'),
                  ),
                ]));
        return false;
      }

      return true;

    } catch(e){
      print(e.toString());
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Authorise()));
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
              title: const Text('Ошибка'),
              content: Text(e.toString()),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'OK');
                  },
                  child: const Text('OK'),
                ),
              ]));
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 35),
              child: Center(
                child: Text(
                  'SMART CAR OWNER ADMIN',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff007AFF)
                  ),
                ),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(
                        118, 118, 128, 0.12), //color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  height: 36,
                  child: CupertinoTextField(
                    controller: emailController,
                    keyboardType: TextInputType.text,
                    placeholder: "Email",
                    decoration: const BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10))),
                  )),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(
                        118, 118, 128, 0.12), //color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  height: 36,
                  child: CupertinoTextField(
                    controller: passController,
                    keyboardType: TextInputType.text,
                    placeholder: "Пароль",
                    decoration: const BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10))),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color(0xff007AFF), width: 3),
                  color: const Color(0xff007AFF),
                  //color: Colors.red,
                  borderRadius:
                  const BorderRadius.all(Radius.circular(10)),
                ),
                child: CupertinoButton(
                  onPressed: () async {
                    bool isLogged = await singMeIn();
                    if(isLogged){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const mainPage()));
                    }
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    child: const Center(
                      child: Text('Войти',
                          style: TextStyle(
                              fontSize: 14, color: Colors.white)),
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
