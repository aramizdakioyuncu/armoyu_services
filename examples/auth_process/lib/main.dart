import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:armoyu_services/armoyu_services.dart';

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
  late final ARMOYUServices armoyuServices;

  @override
  void initState() {
    super.initState();
    armoyuServices = ARMOYUServices(apiKey: "1");
  }

  static void getSnackBar(getUsersResult) {
    try {
      Get.snackbar(
        "Sistem",
        "${getUsersResult['aciklama'].toString()}${getUsersResult['icerik'].length != 0 ? "\n${getUsersResult['icerik']}" : ""}",
        colorText: Colors.white,
        backgroundColor: Colors.black38,
      );
    } catch (e) {
      Get.snackbar(
        "Sistem",
        "${getUsersResult['aciklama'].toString()}${getUsersResult['icerik'] != null ? "\n${getUsersResult['icerik']}" : ""}",
        colorText: Colors.white,
        backgroundColor: Colors.black38,
      );
    }
  }

  Future<void> login() async {
    final Map<String, dynamic> getUsersResult = await armoyuServices.login(
      loginRequestModel: LoginRequestModel(
        username: "deneme",
        password: "deneme",
      ),
    );

    if (getUsersResult['durum'] != 1) {
      getSnackBar(getUsersResult);
      return;
    }
  }

  Future<void> befriend() async {
    final Map<String, dynamic> getUsersResult = await armoyuServices.addFriend(
      addFriendRequestModel: AddFriendRequestModel(
        kiminle: 2,
      ),
    );

    if (getUsersResult['durum'] != 1) {
      getSnackBar(getUsersResult);
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
    final Map<String, dynamic> getUsersResult = await armoyuServices.register(
      registerRequestModel: RegisterRequestModel(
        firstname: firstname,
        lastname: lastname,
        username: username,
        email: email,
        password: password,
      ),
    );

    if (getUsersResult['durum'] != 1) {
      getSnackBar(getUsersResult);
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
              child: const Text("Test Login"),
            ),
            ElevatedButton(
              onPressed: () async => await befriend(),
              child: const Text("Test Add Friend"),
            ),
            ElevatedButton(
              onPressed: () async => await register(
                firstname: "TEST1",
                lastname: "SOYAD2",
                email: "tesst@ema32il.com",
                password: "12345678",
                username: "test23",
              ),
              child: const Text("Test Register"),
            ),
          ],
        ),
      ),
    );
  }
}
