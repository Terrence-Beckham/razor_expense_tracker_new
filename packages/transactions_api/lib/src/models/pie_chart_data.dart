import 'package:equatable/equatable.dart';

class PieChartDataObject extends Equatable {
  const PieChartDataObject({
    required this.title,
    required this.value,
    required this.amount,
    required this.color,
  });

  final String title;
  final double value;
  final double amount;
  final String color;

  PieChartDataObject copyWith({
    String? title,
    double? value,
    double? amount,
    String? color,
  }) {
    return PieChartDataObject(
      title: title ?? this.title,
      value: value ?? this.value,
      amount: amount ?? this.amount,
      color: color ?? this.color,
    );
  }

  @override
  String toString() {
    return 'PieChartData{title: $title, value: $value, amount: $amount, color: $color}';
  }

  @override
  List<Object> get props => [title, value, amount, color];
}