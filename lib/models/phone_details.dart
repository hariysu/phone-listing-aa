class PhoneDetails {
  final Result result;

  PhoneDetails({this.result});

  factory PhoneDetails.fromJson(Map<String, dynamic> parsedJson) {
    return PhoneDetails(result: Result.fromJson(parsedJson['result']));
  }
}

class Result {
  final String mkName;
  final String productName;
  final String badge;
  final double rating;
  final String imageUrl;
  final List<String> storageOptions;
  final int countOfPrices;
  final int price;
  final bool freeShipping;
  final String lastUpdate;

  Result(
      {this.mkName,
      this.productName,
      this.badge,
      this.rating,
      this.imageUrl,
      this.storageOptions,
      this.countOfPrices,
      this.price,
      this.freeShipping,
      this.lastUpdate});

  factory Result.fromJson(Map<String, dynamic> parsedJson) {
    return Result(
      mkName: parsedJson['mkName'],
      productName: parsedJson['productName'],
      badge: parsedJson['badge'],
      rating: parsedJson['rating']?.toDouble(),
      imageUrl: parsedJson['imageUrl'],
      storageOptions: parsedJson['storageOptions'] == null
          ? []
          : List<String>.from(parsedJson['storageOptions'].map((x) => x)),
      countOfPrices: parsedJson['countOfPrices'],
      price: parsedJson['price'],
      freeShipping: parsedJson['freeShipping'],
      lastUpdate: parsedJson['lastUpdate'],
    );
  }
}
