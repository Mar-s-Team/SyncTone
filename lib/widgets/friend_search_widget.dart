import 'package:flutter/material.dart';
import 'package:synctone/models/user_model.dart';

class FriendSearchBar extends StatefulWidget {
  final List<UserModel> allFriends;
  final void Function(List<UserModel>) onSearch;

  const FriendSearchBar({
    super.key,
    required this.allFriends,
    required this.onSearch,
  });

  @override
  State<FriendSearchBar> createState() => _FriendSearchBarState();
}

class _FriendSearchBarState extends State<FriendSearchBar> {
  final TextEditingController _controller = TextEditingController();

  void _handleSearch() {
    final query = _controller.text.trim().toLowerCase();
    final filtered = widget.allFriends.where((friend) {
      final username = friend.username.toLowerCase();
      return username.startsWith(query);
    }).toList();

    widget.onSearch(filtered);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Search friends',
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onSubmitted: (_) => _handleSearch(),
          ),
        ),
        const SizedBox(width: 8),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: _handleSearch,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
              ),
              child: const Icon(Icons.search, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
