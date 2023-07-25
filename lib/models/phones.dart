class Phones {
  final Results results;
  Phones({this.results});
  factory Phones.fromJson(Map<String, dynamic> parsedJson) {
    return Phones(
      results: Results.fromJson(parsedJson['result']),
    );
  }
}

class Results {
  final String nextUrl;
  final List<Products> horizontalProducts;
  final List<Products> products;

  Results({this.nextUrl, this.horizontalProducts, this.products});

  factory Results.fromJson(Map<String, dynamic> parsedJson) {
    return Results(
      nextUrl: parsedJson['nextUrl'] ?? '',
      horizontalProducts: parsedJson["horizontalProducts"] != null
          ? List<Products>.from(
              parsedJson["horizontalProducts"].map((x) => Products.fromJson(x)))
          : <Products>[],
      products: List<Products>.from(
          parsedJson["products"].map((x) => Products.fromJson(x))),
    );
  }
}

class Products {
  final int code;
  final String imageUrl;
  final String name;
  final double dropRatio;
  final double price;
  final int countOfPrices;
  final int followCount;

  Products(
      {this.code,
      this.imageUrl,
      this.name,
      this.dropRatio,
      this.price,
      this.countOfPrices,
      this.followCount});

  factory Products.fromJson(Map<String, dynamic> parsedJson) {
    return Products(
        code: parsedJson['code'],
        imageUrl: parsedJson['imageUrl'],
        name: parsedJson['name'],
        dropRatio: parsedJson['dropRatio']?.toDouble(),
        price: parsedJson['price']?.toDouble(),
        countOfPrices: parsedJson['countOfPrices'],
        followCount: parsedJson['followCount']);
  }
}
