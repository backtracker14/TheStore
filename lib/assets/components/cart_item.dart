class CartItemModel {
  static const iD = "id";
  static const iMAGE = "image";
  static const nAME = "name";
  static const qUANTITY = "quantity";
  static const cOST = "cost";
  static const pRICE = "price";
  static const pRODUCTID = "productId";

  String? id;
  String? image;
  String? name;
  int? quantity;
  double? cost;
  String? productId;
  double? price;

  CartItemModel(
      {required this.productId,
      required this.id,
      required this.image,
      required this.name,
      required this.quantity,
      required this.cost});

  CartItemModel.fromMap(Map<String, dynamic> data) {
    id = data[iD];
    image = data[iMAGE];
    name = data[nAME];
    quantity = data[qUANTITY];
    cost = data[cOST].toDouble();
    productId = data[pRODUCTID];
    price = data[pRICE].toDouble();
  }

  Map toJson() => {
        iD: id,
        pRODUCTID: productId,
        iMAGE: image,
        nAME: name,
        qUANTITY: quantity,
        cOST: price! * quantity!,
        pRICE: price
      };
}
