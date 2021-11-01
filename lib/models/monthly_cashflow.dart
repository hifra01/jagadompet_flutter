class MonthlyCashflow {
  final int? income;
  final int? outcome;
  final int? outFood;
  final int? outDaily;
  final int? outEducation;
  final int? outHealth;
  final int? outOther;

  MonthlyCashflow(
      {
    this.income,
    this.outcome,
    this.outFood,
    this.outDaily,
    this.outEducation,
    this.outHealth,
    this.outOther,
  });

  MonthlyCashflow.fromJson(Map<String, Object?> json)
  : this(
    income: json['income'] != null ? json['income'] as int : 0,
    outcome: json['outcome'] != null ? json['outcome'] as int : 0,
    outFood: json['out_food'] != null ? json['out_food'] as int : 0,
    outDaily: json['out_daily'] != null ? json['out_daily'] as int : 0,
    outEducation: json['out_education'] != null ? json['out_education'] as int : 0,
    outHealth: json['out_health'] != null ? json['out_health'] as int : 0,
    outOther: json['out_other'] != null ? json['out_other'] as int : 0,
  );
}