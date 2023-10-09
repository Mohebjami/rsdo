import 'package:flutter/material.dart';

class Sarvear extends StatefulWidget {
  const Sarvear({super.key});

  @override
  State<Sarvear> createState() => _SarvearState();
}

class _SarvearState extends State<Sarvear> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 35, top: 100),
          child:const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                'Welcome',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 38,
                    fontFamily: "RobotoSlab"
                ),
              ),Text(
                ' Sarver Page',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: "RobotoSlab"
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.4,
              right: 35,
              left: 35,
            ),
            child: Column(
              children: [
                TextField(
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    // fillColor: const Color(0xff4c505b),
                    fillColor: const Color(0xff4c505b),
                    filled: true,
                    hintText: 'Email',
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),

                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  obscureText: true,
                  decoration: InputDecoration(
                      fillColor: const Color(0xff4c505b),
                      filled: true,
                      hintText: 'Password',
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      " Login",
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 0.9),
                          fontSize: 27,
                          fontFamily: "RobotoSlab",
                          fontWeight: FontWeight.w700),
                    ),
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: const Color(0xff4c505b),
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pushNamed(context, "show");
                        },
                        icon: const Icon(Icons.arrow_forward, size: 30,),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot Password',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 18,
                              color: Color.fromRGBO(255, 255, 255, 0.9),
                              fontFamily: "RobotoSlab"
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
