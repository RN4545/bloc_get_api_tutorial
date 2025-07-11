import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchPost extends PostEvent {}

class SearchItem extends PostEvent {
  final String searchString;

  SearchItem(this.searchString);
}
