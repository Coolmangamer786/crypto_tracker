class Coin {
  final String name;
  final dynamic rank;
  final dynamic price;
  final String image;
  final double change;
  final String sortform;

  const Coin(
      {required this.name,
      this.rank,
      required this.image,
      this.price,
      required this.change,
      required this.sortform});

  static Coin fromJson(json) => Coin(
      name: json['name'],
      rank: json['market_data']['market_cap_rank'],
      price: json['market_data']['current_price']['inr'],
      image: json['image']['large'],
      change: json['market_data']['price_change_percentage_24h'],
      sortform: json['symbol']);
}
