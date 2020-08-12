import 'dart:convert';

List<Order> orderFromJson(String str) => List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
    Order({
        this.orderId,
        this.totalPago,
        this.orderDate,
        this.createdAt,
        this.updatedAt,
        this.userId,
        this.productOrders,
    });

    int orderId;
    int totalPago;
    DateTime orderDate;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic userId;
    List<ProductOrder> productOrders;

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderId: json["order_id"],
        totalPago: json["total_pago"] == null ? null : json["total_pago"],
        orderDate: DateTime.parse(json["order_date"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        userId: json["userId"],
        productOrders: List<ProductOrder>.from(json["product_orders"].map((x) => ProductOrder.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "total_pago": totalPago == null ? null : totalPago,
        "order_date": orderDate.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "userId": userId,
        "product_orders": List<dynamic>.from(productOrders.map((x) => x.toJson())),
    };
}

class ProductOrder {
    ProductOrder({
        this.id,
        this.cantidad,
        this.createdAt,
        this.updatedAt,
        this.orderOrderId,
        this.productId,
    });

    int id;
    int cantidad;
    DateTime createdAt;
    DateTime updatedAt;
    int orderOrderId;
    int productId;

    factory ProductOrder.fromJson(Map<String, dynamic> json) => ProductOrder(
        id: json["id"],
        cantidad: json["cantidad"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        orderOrderId: json["orderOrderId"],
        productId: json["productId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cantidad": cantidad,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "orderOrderId": orderOrderId,
        "productId": productId,
    };
}