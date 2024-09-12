import 'package:armoyu_services/services/api.dart';
import 'package:armoyu_services/services/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late APIServices serviceARMOYU;

  @override
  void initState() {
    super.initState();
    serviceARMOYU = APIServices(apiKEY: "1");
  }

  Future<void> login() async {
    final Map<String, dynamic> getUsersResult =
        await serviceARMOYU.login(username: "deneme", password: "deneme");

    if (getUsersResult['durum'] != 1) {
      ARMOYUWidgets.getSnackBar(getUsersResult);
      return;
    }
  }

  Future<void> befriend() async {
    final Map<String, dynamic> getUsersResult =
        await serviceARMOYU.addfriend(kiminle: 2);

    if (getUsersResult['durum'] != 1) {
      ARMOYUWidgets.getSnackBar(getUsersResult);
      return;
    }
  }

  Future<void> register({
    required String firstname,
    required String lastname,
    required String username,
    required String email,
    required String password,
  }) async {
    final Map<String, dynamic> getUsersResult = await serviceARMOYU.register(
        firstname: firstname,
        lastname: lastname,
        username: username,
        email: email,
        password: password);

    if (getUsersResult['durum'] != 1) {
      ARMOYUWidgets.getSnackBar(getUsersResult);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async => await login(),
              child: const Text("TIKLA"),
            ),
            ElevatedButton(
              onPressed: () async => await befriend(),
              child: const Text("Arkadaş ol"),
            ),
            ElevatedButton(
              onPressed: () async => await register(
                firstname: "TEST1",
                lastname: "SOYAD2",
                email: "tesst@ema32il.com",
                password: "12345678",
                username: "test23",
              ),
              child: const Text("Kayıt Ol"),
            ),
          ],
        ),
      ),
    );
  }
}
