import 'dart:async';

import 'package:flutter_social/BLoC/bloc.dart';
import 'package:flutter_social/models/post.dart';

class PostBloc extends Bloc {
  List<Post>? _listePosts;
  List<Post>? get selectedController => _listePosts;

  final _postController = StreamController<PostBloc>();
  Stream<PostBloc> get postStream => _postController.stream;

  void getAllPosts() {}

  @override
  void dispose() {
    _postController.close();
  }
}
