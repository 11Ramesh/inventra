import 'package:flutter/material.dart';

class Myroute extends StatefulWidget {
  //this list come from the login page
  List<dynamic> datalist = [];
  Myroute({required this.datalist});
  @override
  State<Myroute> createState() => _MyrouteState(datalist: datalist);
}

class _MyrouteState extends State<Myroute> {
  _MyrouteState({required this.datalist});
  List<dynamic> datalist = [];
  List<String> routelist = [];
  bool indicator = true;

  @override
  void initState() {
    //data add neww List for retriew
    datalist.forEach((route) {
      routelist.add(route["route"]);
    });
    super.initState();
  }

  //images add in to app bar and can't to use two widget with Listview
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        actions: [
          SingleChildScrollView(
            child: Column(
              children: [head_image(), head_image2()],
            ),
          ),
        ],
      ),
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            alignment: Alignment(1.0, 2.0),
            image: AssetImage('assets/icon/background.png'),
          )),
          child: list()),
    );
  }

  // this is image get from the figma
  Widget head_image() {
    return Container(
      margin: const EdgeInsets.only(top: 20, right: 140),
      child: Image.asset(
        'assets/icon/router_image1.png',
        width: 250,
      ),
    );
  }

  // this is image get from the figma
  Widget head_image2() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 0, right: 40),
      child: Image.asset(
        'assets/icon/router_image2.png',
        width: 350,
      ),
    );
  }

  // this is image get from the figma
  Widget logo_image() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Image.asset(
        'assets/icon/logo.png',
        width: 150,
      ),
    );
  }

  // this is Listview widget
  Widget list() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: ListView.separated(
          itemCount: datalist.length,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(); // Add a divider between ListTiles
          },
          itemBuilder: (context, index) {
            return ListTile(
              onLongPress: () {},
              title: Text(routelist[index]),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward_ios_outlined),
                onPressed: () {},
              ),
              leading: const Icon(Icons.navigation_sharp),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              tileColor: Color.fromARGB(113, 228, 236, 234),
            );
          }),
    );
  }
}
