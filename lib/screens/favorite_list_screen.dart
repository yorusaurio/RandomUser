import 'package:flutter/material.dart';
import 'package:randomuser/dao/user_dao.dart';
import 'package:randomuser/models/user.dart';
import 'package:randomuser/screens/user_search_screen.dart';

class FavoriteListScreen extends StatelessWidget {
  const FavoriteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Users"),
      ),
      body: const FavoriteList(),
    );
  }
}

class FavoriteList extends StatefulWidget {
  const FavoriteList({super.key});

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  List<User> _favorites = [];
  final UserDao _userDao = UserDao();

  @override
  void initState() {
    super.initState();
    _fetchFavorites();
  }

  _fetchFavorites() async {
    List<User> favorites = await _userDao.fetchFavorites();
    setState(() {
      _favorites = favorites;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _favorites.length,
      itemBuilder: (context, index) {
        return UserItem(user: _favorites[index]);
      },
    );
  }
}