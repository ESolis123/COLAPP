

class Producto {
  final dynamic id;
  final dynamic nombre;
  final dynamic descripcion;
  final dynamic categoria;
  final dynamic fechaCompra;
  final dynamic fechaCreacion;
  final dynamic fechaVencimiento;
  final dynamic precioCompra;
  final dynamic precioVenta;
  final dynamic estado;
  final dynamic stock;
  Producto({
    this.id, this.nombre,this.descripcion,this.categoria,this.fechaCompra,this.fechaCreacion,
    this.fechaVencimiento,this.precioCompra,this.precioVenta,this.estado,this.stock
    });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: (json['id']),
      nombre: json['nombre'] ,
      descripcion: json['descripcion'] ,
      fechaCompra: json['fec_compra'] ,
      fechaCreacion: json['fec_elaboracion'] ,
      fechaVencimiento: json['fec_vencimiento'] ,
      precioCompra: json['precio_compra'] ,
      precioVenta: json['precio_venta'] ,
      estado: json['status'] ,
      stock: json['stock'], 
      categoria: json['id_tipo_producto'] ,
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["nombre"] = nombre;
    map["descripcion"] = descripcion;
    map["id_tipo_producto"] = categoria;
    map["fec_elaboracion"] = fechaCreacion;
    map["fec_vencimiento"] = fechaVencimiento;
    map["precio_compra"] = precioCompra;
    map["precio_venta"] = precioVenta;
    map["fec_compra"] = fechaCompra;
    map["status"] = estado;
    map["stock"] = stock;
    return map;
  }
}

class TiposProductos {
  final int id;
  final String nombre;
  final String descripcion;
 
  TiposProductos({
    this.id,this.nombre,this.descripcion
    });

  factory TiposProductos.fromJson(Map<String, dynamic> json) {
    return TiposProductos(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
      descripcion: json['descripcion'] as String,
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["nombre"] = nombre;
    map["descripcion"] = descripcion;
    return map;
  }
}

class Proveedor {
  final dynamic id;
  final dynamic nombre;
  final dynamic descripcion;
  final dynamic direccion;
  final dynamic telefono;
  final dynamic estado;
  Proveedor({
    this.id,this.nombre,this.descripcion, this.direccion, this.telefono, this.estado
    });

  factory Proveedor.fromJson(Map<String, dynamic> json) {
    return Proveedor(
      id: json['id'],
      nombre: json['nombre'] ,
      descripcion: json['descripcion'] ,
      direccion: json['direccion'] ,
      telefono: json['telefono'] ,
      estado: json['status'] ,
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["nombre"] = nombre;
    map["descripcion"] = descripcion;
    map["direccion"] = direccion;
    map["telefono"] = telefono;
    map["status"] = estado;
    return map;
  }
}


class Account {
  final String username;
  final String email;
  final String password;

  Account({this.username, this.email, this.password,});

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
  username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }
  Map toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = username;
    map["email"] = email;
    map["password"] = password;

    return map;
  }
}
