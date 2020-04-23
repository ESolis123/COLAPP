import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'dart:io';
import 'package:myapp/globals/user.dart';


List<TiposProductos> obtenerTiposProductos(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  
  return parsed.map<TiposProductos>((json) => TiposProductos.fromJson(json)).toList();
}

List<Producto> obtenerProductos(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  
  return parsed.map<Producto>((json) => Producto.fromJson(json)).toList();
}

List<Proveedor> obtenerProveedores(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  
  return parsed.map<Proveedor>((json) => Proveedor.fromJson(json)).toList();
}

Future<dynamic> loginCredentials(context, url, {Map body}) async {
  http.Response response = await http.post(url, body: body);

  if (response.statusCode != 200) {
    return response;
  } else {
    return response;
  }
}

 fetchPost(http.Client client, url, token, objeto) async {
  final response = await client.get(url, headers: {
    HttpHeaders.authorizationHeader:
      "Token $token"
  });
  final int res = response.statusCode;

  if (res == 401 || res == 403) {
    throw new Exception("Error");
  }

if(objeto==1){return compute(obtenerProductos, response.body);}
else if(objeto==2) {return compute(obtenerTiposProductos, response.body);}
else if(objeto==3) {return compute(obtenerTiposProductos, response.body);}
}


crearObjeto(url, body, token) async {
     return await http.post(url, body: body, headers: {HttpHeaders.authorizationHeader:"Token $token",HttpHeaders.contentTypeHeader: "application/json"}).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 400 || json == null) {
      throw Exception("Error while fetching data");
      
      
    }
  
    //return Producto.fromJson(json.decode(response.body));
  });
}

Future<dynamic> createObjetoNoJson(url, body, token) async {
     return await http.post(url, body: body, headers: {HttpHeaders.authorizationHeader:"Token $token"}).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw Exception("Error while fetching data");
    }
    return Proveedor.fromJson(json.decode(response.body));
  });
}


Future<void> actualizarObjeto(id, body, url, token) async {
  
    http.Response res = await http.put("$url$id/", body: body, headers: {HttpHeaders.authorizationHeader:"Token $token",HttpHeaders.contentTypeHeader: "application/json"});

  if (res.statusCode == 200 || res.statusCode == 204 || res.statusCode == 201) {
    
  } else {
    throw "Can't delete post.";
  }
}

Future<void> actualizarObjetoNoJson(id, body, url, token) async {
  
    http.Response res = await http.put("$url$id/", body: body, headers: {HttpHeaders.authorizationHeader:"Token $token"});

  if (res.statusCode == 200 || res.statusCode == 204 || res.statusCode == 201) {
    
  } else {
    throw "Can't delete post.";
  }
}



Future<void> borrarObjeto(id, url, token) async {
 
 String urlfinal= url+id.toString()+'/';
  http.Response res = await http.delete(urlfinal, headers: {
    HttpHeaders.authorizationHeader:
      "Token $token"
  });

  if (res.statusCode == 200 || res.statusCode == 204) {
    
  } else {
    throw "Can't delete post.";
  }
}

Future<dynamic> createUser(context, url, body, token) async {
     http.Response response = await http.post(url, body: body);

    if (response.statusCode != 200) {
      return response;
    } else {
      return response;
    }
}

Future<dynamic> forgotUser(context, url, body) async {
     http.Response response = await http.post(url, body: body);

    if (response.statusCode != 200) {
      return response;
    } else {
      return response;
    }
}
