import 'package:flutter/material.dart';

class SideDrawerHeader extends StatefulWidget {
  const SideDrawerHeader({Key? key}) : super(key: key);

  @override
  _SideDrawerHeaderState createState() => _SideDrawerHeaderState();
}

class _SideDrawerHeaderState extends State<SideDrawerHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/man.png'),
              ),
            ),
          ),
          const Text(
            "Rock Dwayne Johnson",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          Text(
            "03495861794",
            style: TextStyle(
              color: Colors.grey[100],
              fontSize: 16,
            ),
          ),
          Text(
            "rock@gmail.com",
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
