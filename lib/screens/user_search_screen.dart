import 'package:flutter/material.dart';
import 'package:randomuser/services/user_service.dart';
import 'package:randomuser/models/user.dart';
import 'package:randomuser/dao/user_dao.dart';

class UserSearchScreen extends StatefulWidget {
  const UserSearchScreen({super.key});

  @override
  State<UserSearchScreen> createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> {
  int _results = 2;
  List<User> _users = [];
  final UserService _userService = UserService();
  final UserDao _userDao = UserDao();

  _fetchUsers() async {
    List<User> users = await _userService.getUsers(_results);
    setState(() {
      _users = users;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Search"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _fetchUsers,
          )
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Number of results: "),
              DropdownButton<int>(
                value: _results,
                items: [1, 2, 5, 10].map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _results = value!;
                    _fetchUsers();
                  });
                },
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                return UserItem(user: _users[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class UserItem extends StatefulWidget {
  const UserItem({super.key, required this.user});

  final User user;

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  bool _isFavorite = false;
  final UserDao _userDao = UserDao();

  @override
  void initState() {
    super.initState();
    _checkFavorite();
  }

  _checkFavorite() async {
    bool isFavorite = await _userDao.isFavorite(widget.user);
    setState(() {
      _isFavorite = isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(widget.user.picture),
        title: Text("${widget.user.title} ${widget.user.firstName} ${widget.user.lastName}"),
        subtitle: Text(widget.user.email),
        trailing: IconButton(
          icon: Icon(
            _isFavorite ? Icons.favorite : Icons.favorite_border,
            color: _isFavorite ? Colors.red : null,
          ),
          onPressed: () {
            setState(() {
              _isFavorite = !_isFavorite;
            });
            _isFavorite
                ? _userDao.insert(widget.user)
                : _userDao.delete(widget.user);
          },
        ),
      ),
    );
  }
}
