class Wallet {
  final int? total;

  Wallet({this.total});

  Wallet.fromJson(Map<String, Object?> json)
      : this(
          total: json['total'] != null ? json['total'] as int : 0,
        );
}
