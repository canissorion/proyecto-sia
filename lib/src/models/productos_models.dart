import 'dart:convert';

List<Productos> productosFromJson(String str) => List<Productos>.from(json.decode(str).map((x) => Productos.fromJson(x)));

String productosToJson(List<Productos> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Productos {
    Productos({
        this.id,
        this.nombre,
        this.categoria,
        this.precio,
        this.stock,
        this.activo,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String nombre;
    String categoria;
    int precio;
    int stock;
    bool activo;
    DateTime createdAt;
    DateTime updatedAt;

    factory Productos.fromJson(Map<String, dynamic> json) => Productos(
        id: json["id"],
        nombre: json["nombre"],
        categoria: json["categoria"],
        precio: json["precio"],
        stock: json["stock"],
        activo: json["activo"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "categoria": categoria,
        "precio": precio,
        "stock": stock,
        "activo": activo,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
