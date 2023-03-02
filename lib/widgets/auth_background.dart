import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Column(children: [
      Container(
        height: size.height*0.4,
        width: double.infinity,
        decoration:colorsGradient(),
        child: Stack(children: [
          const Positioned(
            bottom: 70,
            right: 10,
            child: _Bubble(),
          ),
          const Positioned(
            top: 10,
            left: 10,
            child: _Bubble(),
          ),
          const Positioned(
            bottom: -50,
            right: 100,
            child: _Bubble(),
          ),
          const Positioned(
            top:-50,
            left:200,
            child: _Bubble(),
          ),
          const Positioned(
            bottom: 10,
            right: 250,
            child: _Bubble(),
          ),
          
          Positioned(
            left: size.width*0.5-40,
            top: 40,              
            child:const SafeArea(child: Icon(Icons.person_pin,size:80 ,color: Colors.white,)))
          
        ],),
      ),
      //Expanded(child:Container(color:const Color(0xffB2ECE1),))
    ],
    );
  }

  BoxDecoration colorsGradient() {
    return const BoxDecoration(
        gradient:  LinearGradient(
          colors: [
            Color(0xff841C26),
            Color(0xffBA274A)
          ]
        )
      );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0xff8CDEDC).withOpacity(0.3),
        shape: BoxShape.circle
      ),
      
    );
  }
}