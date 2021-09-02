class DeliveryModel {
  final String img;
  final String name;
  final String days;
  final int price;

  DeliveryModel({
    required this.img,
    required this.name,
    required this.days,
    required this.price,
  });
}

List<DeliveryModel> deliveryOptions = [
  DeliveryModel(
    img: 'assets/free-shipping.png',
    name: 'Free',
    days: '3-6',
    price: 0,
  ),
  DeliveryModel(
    img: 'assets/fast-delivery.png',
    name: 'Express',
    days: '1-2',
    price: 20,
  ),
];
