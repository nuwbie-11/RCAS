class CarModel {
  final String carName;
  final String imgUrl;
  final String manufacturer;
  final String ownerMail;
  String renterMail;
  final int year;

  CarModel(
      {required this.carName,
      this.imgUrl = "",
      required this.ownerMail,
      this.manufacturer = "",
      this.renterMail = "",
      required this.year});

  factory CarModel.fromJson(Map<dynamic, dynamic> map) {
    return CarModel(
      carName: map['carName'],
      imgUrl: map['imgUrl'],
      manufacturer: map['manufacturer'],
      ownerMail: map['ownerMail'],
      renterMail: map['renterMail'],
      year: map['year'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'carName': carName,
      'imgUrl': imgUrl,
      'manufacturer': manufacturer,
      'ownerMail': ownerMail,
      'renterMail': renterMail,
      'year': year,
    };
  }
}
