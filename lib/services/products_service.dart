import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

import 'package:formulario/models/poduct_model.dart';


class ProductsService extends ChangeNotifier {
  final baseUrl='products-62044-default-rtdb.firebaseio.com';
  
  List<Product> products=[];
  bool isLoading=false;

  //para obtener el token del secure de una autenticacion
  final storage=const FlutterSecureStorage();
  
  //Pat para obtener la ruta de la imagen
  File? newImageFile;

  //para poder manejar los cambios
  Product? product;

  ProductsService(){  
    isLoading=true;
    notifyListeners();
    
    getProducts();
    
    isLoading=false;
    notifyListeners();
  }

  Future getProducts()async{
    final url=Uri.https(baseUrl,'products.json',{
      'auth':await storage.read(key:'token')??''
    });
    final response=await http.get(url);
    final Map<String,dynamic> responseData=json.decode(response.body);

    responseData.forEach((key, value) { 
      //creamos los valores del mapa
      final tempProduct=Product.fromMap(value);
      //asignamos la llave del mapa
      tempProduct.id=key;
      //lo añadimos a una lista
      products.add(tempProduct);
      notifyListeners();
    });
    
    
  }

  Future createOrUpdateProduct(Product product)async{
    isLoading=true;
    notifyListeners();
    if(product.id==null){
      
      await createProduct(product);
      
    }else{
      await updateProduct(product);
    }
    isLoading=false;
    notifyListeners();
  }

  //metodo para actualizar
  Future updateProduct(Product productUpdate)async{
    final url=Uri.https(baseUrl,'products/${productUpdate.id}.json',{
      'auth':await storage.read(key: 'token')??''
    });
    //actualizamos el producto
    await http.put(url,body: productUpdate.toJson());
    
    // for (Product product in products) {
    //   if (product.id==productUpdate.id) {
    //     products[products.indexOf(product)]=productUpdate;
    //     notifyListeners();
    //   }
    // }
    final index=products.indexWhere((element) => element.id==productUpdate.id);
    products[index]=productUpdate;
 
  }

  //para crear un producto
  Future createProduct(Product newProduct)async{

    final url=Uri.https(baseUrl,'products.json',{
      'auth':await storage.read(key: 'token')??''
    });
    final response=await http.post(url,body: newProduct.toJson());
    //obtenemos el id del producto (key del producto en Firebase)
    final decodedData=json.decode(response.body);
    //ahora asignamos el name decodeData al id del producto
    newProduct.id=decodedData['name'];
    
    //añadimos a la lista de productos
    products.add(newProduct);
 
  }

  //XXXXXXXXXX Para la imagen XXXXXXXXXXXXXXXX
  void updateSelectedImage(String path){
    //para actualizar la imagen asignamos el path 
    product?.picture=path;
    //tenemos el archivo de la imagen
    newImageFile=File.fromUri(Uri(path: path));
    notifyListeners();
  }

  Future<String?> uploadImage()async{
    if(newImageFile==null)return null;
    //ponemos la url del cloudynari
    final url=Uri.parse('https://api.cloudinary.com/v1_1/ddua8ra2j/image/upload?upload_preset=kf2upbep');
    
    //creamos la peticion POST
    final imageUploadRequest=http.MultipartRequest('POST',url);
    
    //este es el archibvo que queremos mandar
    final file=await http.MultipartFile.fromPath('file', newImageFile!.path);  

    imageUploadRequest.files.add(file);

    final streamResponse=await imageUploadRequest.send();
    final response=await http.Response.fromStream(streamResponse);

    if(response.statusCode!=200 && response.statusCode!=201){
      return null;
    }
    newImageFile=null;

    final responseData=json.decode(response.body);
    return responseData['secure_url'];
  }
  
}