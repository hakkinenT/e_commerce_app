import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String name;

  const Product({required this.name});

  @override
  List<Object?> get props => [name];
}
