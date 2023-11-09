import 'package:flutter/material.dart';
import 'package:inventra/screen/route_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Mylogin extends StatefulWidget {
  const Mylogin({super.key});

  @override
  State<Mylogin> createState() => _MyloginState();
}

class _MyloginState extends State<Mylogin> {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  final _key = GlobalKey<FormState>();

  //this bool value use for pasword suffix icon
  bool pass_visible = true;

  @override
  void initState() {
    pass_visible = true;
    super.initState();
  }

  //this use for creating aseamless user expriense
  void indicator() async {
    showDialog(
        context: context,
        builder: ((context) {
          return const Center(child: CircularProgressIndicator());
        }));
  }

  // this fiel use for when user login the successfuly automatic text field going empty
  void field_clear() {
    password.clear();
    userName.clear();
  }

  //this is the API call
  @override
  Future<void> signIn(String userName, String password) async {
    try {
      const url = 'http://app360dev-001-site14.atempurl.com/api/v2/Auth/SignIn';

      final resturl = Uri.parse(url);
      var body = {'userName': userName, 'password': password};

      final response = await http.put(
        resturl,
        body: json.encode(body),
        headers: {
          "Content-Type": "application/json",
        },
      );
      //check connection issue with API
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        //give to permission to log route screen
        if (data['status'] == 'Success') {
          indicator();
          final content = json.decode(response.body);
          final routes = content['content'];
          final data = routes['routes'];
          field_clear();

          List<dynamic> datalist = data;

          await Future.delayed(const Duration(seconds: 1));
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();

          // data list is a List and it will send route page using bellow segment
          // ignore: use_build_context_synchronously
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Myroute(datalist: datalist)));
        }
        //when password or user name going wron display message
        else {
          const snackBar = SnackBar(
              content: Center(child: Text('Invalid User Name or Password')));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment(0.8, 1.8),
            image: AssetImage('assets/icon/background.png'),
            fit: BoxFit.none,
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                head_image(),
                sub_image(),
                text1(),
                text2(),
                textButton(),
                button(),
                logo_image()
              ],
            ),
          ),
        ),
      ),
    );
  }

  //user name field
  Widget text1() {
    return Container(
      margin: const EdgeInsets.only(top: 80, right: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(50, 183, 187, 189),
            hintText: 'Email Address',
            prefixIcon: const Icon(Icons.email),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          ),
          controller: userName,
          validator: (value) {
            if (value == "") {
              return "Email field is empty";
            }
            return null;
          },
        ),
      ),
    );
  }

  //password field
  Widget text2() {
    return Container(
      margin: const EdgeInsets.only(top: 40, right: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: TextFormField(
          obscureText: pass_visible,
          decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromARGB(50, 183, 187, 189),
              hintText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    pass_visible = !pass_visible;
                  });
                },
                icon: pass_visible
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
              )),
          validator: (value) {
            if (value == "") {
              return "Password field is empty";
            }
            return null;
          },
          controller: password,
        ),
      ),
    );
  }

  // Sign In button
  Widget button() {
    return Container(
      margin: const EdgeInsets.only(top: 20, right: 20),
      child: ElevatedButton(
        onPressed: () async {
          if (_key.currentState!.validate()) {
            _key.currentState!.save();
            signIn(userName.text.toString(), password.text.toString());
          }
        },
        child: Text('Sign In', style: TextStyle(fontSize: 17)),
        style: ElevatedButton.styleFrom(
          foregroundColor: Color.fromARGB(255, 255, 255, 255),
          backgroundColor: Color.fromARGB(196, 56, 183, 158),
          padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  // this is image get from the figma
  Widget head_image() {
    return Container(
      margin: const EdgeInsets.only(top: 30, right: 150),
      child: Image.asset(
        'assets/icon/head.png',
        width: 200,
      ),
    );
  }

  // this is image get from the figma
  Widget sub_image() {
    return Container(
      margin: const EdgeInsets.only(top: 10, right: 200),
      child: Image.asset(
        'assets/icon/sub_head.png',
        width: 150,
      ),
    );
  }

  // this is image get from the figma
  Widget logo_image() {
    return Container(
      margin: const EdgeInsets.only(top: 160, left: 15),
      child: Image.asset(
        'assets/icon/logo.png',
        width: 150,
      ),
    );
  }

  // this is Foget Password text button field
  Widget textButton() {
    return Container(
      margin: const EdgeInsets.only(top: 15, right: 200),
      child: TextButton(
        onPressed: () {
          // Handle the button press
        },
        child: const Text(
          "Forget Password ?",
          style: TextStyle(
            fontSize: 17,
            color: Color.fromARGB(196, 16, 123, 100),
          ),
        ),
      ),
    );
  }
}
