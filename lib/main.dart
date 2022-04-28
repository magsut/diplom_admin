import 'package:diplom_admin/loading.dart';
import 'package:diplom_admin/utils/mysql.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  bool isLoading = false;

  List<ServiceCard> cards = [];
  TextEditingController manufacturer = TextEditingController();
  TextEditingController model = TextEditingController();
  TextEditingController year = TextEditingController();

  addCarToBd() async{
    setState(() {
      isLoading = true;
    });

    var db = MySql();

    await db.getConnection().then((con) async {
      String man = manufacturer.text;
      String mod = model.text;
      String yea = year.text;
      String sql = "INSERT INTO `sql11488530`.`car` (`manufacturer`, `model`, `year`) VALUES ('$man', '$mod', '$yea');";

      await con.query(sql).then((result) async {
        int? carId = result.insertId;
        sql = "INSERT INTO `sql11488530`.`service` (`title`, `period`, `car_idcar`) VALUES (?, ?, '$carId');";
        var serviceList = carServices.map((e) => [e.title, e.period]);
        await con.queryMulti(sql, serviceList);
        manufacturer.text = '';
        model.text = '';
        year.text = '';
        cards = [];
        carServices = [];
        isLoading = false;
      });
    });
    setState(() {
      isLoading = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return isLoading? const Loading() : Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff007AFF),
        title: const Text(
          "Приложение администрирования",
          style: TextStyle(color: Colors.white, fontSize: 20),
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
                            placeholder: "Год",
                            keyboardType: TextInputType.text,
                            controller: year,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: cards.length,
                    itemBuilder: (BuildContext context, int i) {
                      return ServiceCard(localId: i);
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8, top: 8, right: 80),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: RaisedButton(
                    onPressed: () async {
                      carServices.forEach((element) {
                        print(element.toString());
                      });
                      await addCarToBd();
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Данные сохранены')));
                    },
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    color: const Color(0xff007AFF),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .85,
                      height: 50,
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
            cards.add(ServiceCard(localId: cards.length + 1));
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ServiceCard extends StatefulWidget {
  const ServiceCard({Key? key, required this.localId}) : super(key: key);
  final int localId;

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  late TextEditingController titleController;
  late TextEditingController periodController;

  bool isEnable = true;

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
                  enabled: isEnable,
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
                      enabled: isEnable,
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        bool isUpdate = false;
                         for(int i = 0; i < carServices.length; i++){
                           if(carServices[i].localId == widget.localId){
                             carServices[i] = Service(titleController.text, int.parse(periodController.text), widget.localId);
                             isUpdate = true;
                             break;
                           }
                         }
                         if(!isUpdate) {
                           carServices.add(Service(titleController.text, int.parse(periodController.text), widget.localId));
                         }

                         isEnable = !isEnable;
                         setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isEnable
                                ? const Color(0xff007AFF)
                                : Colors.transparent),
                        child: isEnable
                            ? const Icon(
                                Icons.done_outline,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.done,
                                color: Color(0xff007AFF),
                              ),
                      ))
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
    titleController = TextEditingController();
    periodController = TextEditingController();
  }
}

class Service{
  String title;
  int period;
  int localId;

  Service(this.title, this.period, this.localId);

  @override
  String toString() {
    return 'Service{title: $title, period: $period, localId: $localId}';
  }
}
