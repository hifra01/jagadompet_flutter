import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionItem {
  final String id;
  final String type;
  final String title;
  final int amount;
  final DateTime date;
  final String? category;
  final String? categoryId;
  final String? source;
  final String? sourceId;
  final String note;

  TransactionItem({
    required this.id,
    required this.type,
    required this.title,
    required this.amount,
    required this.date,
    this.category,
    this.categoryId,
    this.source,
    this.sourceId,
    required this.note,
  });

  TransactionItem.fromJson(Map<String, Object?> json, String id)
      : this(
          id: id,
          type: json['type'] != null ? json['type'] as String : 'out',
          title: json['title'] != null ? json['title'] as String : '',
          amount: json['amount'] != null ? json['amount'] as int : 0,
          date: (json['date'] as Timestamp).toDate(),
          category: json['category'] as String?,
          categoryId: json['category_id'] as String?,
          source: json['source'] as String?,
          sourceId: json['source_id'] as String?,
          note: json['note'] != null ? json['note'] as String : '',
        );
}
