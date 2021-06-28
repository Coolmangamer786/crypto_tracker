

class Coin {
  final String name;
  final dynamic rank;
  final dynamic price;
  final String image;

  const Coin({required this.name, 
 this.rank, required this.image, this.price
  });

  static Coin fromJson(json) => Coin(
      // name: json['AR']['districts'],
      name: json['name'],
      rank: json['market_data']['market_cap_rank'],
      price: json['market_data']['current_price']['inr'],
      image: json['image']['large']
      );
}
