import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
    final String name;
    final double price;
    final bool available;
    final String? picture;
    final String? id;

  const ProductCard({
    super.key, 
    required this.name, 
    required this.price, 
    required this.available, 
    this.picture, 
    this.id});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.all(20),
      height: 300,
      width: 300,
      decoration: BoxDecoration(
        color:const Color.fromARGB(255, 120, 222, 220),
        borderRadius: BorderRadius.circular(20),
        boxShadow:const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(5,5)
          )
        ]
      ),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children:[
          _BackgroundImage(image: picture,),
          
          _ProductDetail(name,id),
          
          Positioned(
            top: 0,
            right: 0,
            child:_PriceDetail(price) ,),
          if (!available)
            const Positioned(
              top: 0,
              left: 0,
              child: _AvailableContain()
            )
        ],
      ),
    );
  }
}

class _AvailableContain extends StatelessWidget {
  const _AvailableContain();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft:Radius.circular(20),bottomRight: Radius.circular(20)),
        color: Colors.red
      ),
      child:const Text("No Disponible",style: TextStyle(color: Colors.white),),
    );
  }
}

class _PriceDetail extends StatelessWidget {
  final double price;
  const _PriceDetail(this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 50,
      padding:const EdgeInsets.all(10),
      decoration:const BoxDecoration(
        color: Color.fromARGB(255, 39, 200, 197),
        borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomLeft: Radius.circular(30))
      ),
      child:FittedBox(
        //para que no cambie la medida del conainer y se vea el teto en una sola linea
        fit: BoxFit.contain,
        child:  Text('\$$price',style:const TextStyle(color: Colors.white),)),
    );
  }
}

class _ProductDetail extends StatelessWidget {
  final String name;
  final String? id;
  const _ProductDetail(
    this.name, 
    this.id);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.all(10),
      margin:const EdgeInsets.only(right: 60),
      height:70,
      width: double.infinity,
      decoration:const BoxDecoration(
        color: Color.fromARGB(255, 39, 200, 197),
        borderRadius: BorderRadius.only(topRight: Radius.circular(50),bottomLeft: Radius.circular(20))
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Text(name,style:const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),),
          Text(id??'No id',style:const TextStyle(color: Colors.white),)
        ]),
      );
  }
}

class _BackgroundImage extends StatelessWidget {
  final String? image;
  const _BackgroundImage({ 
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FadeInImage(
          placeholder:const  AssetImage('assets/jar-loading.gif'),
          image: NetworkImage(image??'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTj7C90U9uTmNI4EpCsDd9JtuObcfTohaGtLA&usqp=CAU'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}