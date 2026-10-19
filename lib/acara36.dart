// lib/acara36.dart
import 'package:flutter/material.dart';
import 'model/user_model.dart';
import 'data/user_api.dart';

class Acara36 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acara 36: User Directory'),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            tooltip: 'Kembali ke Beranda',
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ],
      ),
      body: UserListScreen(),
    );
  }
}

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  // State
  List<User> _users = [];
  bool _isLoading = true;
  String? _errorMessage;
  int _currentPage = 1;
  int _totalPages = 1;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUsers(_currentPage);
  }

  // Ambil data dari API
  Future<void> _fetchUsers(int page) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await UserApi.getUsers(page);
      setState(() {
        _users = response.data;
        _currentPage = response.page;
        _totalPages = response.totalPages;
        _isLoading = false;
        // Reset pencarian setiap ganti halaman
        _searchQuery = '';
        _searchController.clear();
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  // Fungsi Filter Pencarian (berdasarkan Nama atau Email)
  List<User> get _filteredUsers {
    if (_searchQuery.isEmpty) return _users;
    return _users.where((user) {
      final nameLower = user.fullName.toLowerCase();
      final emailLower = user.email.toLowerCase();
      final queryLower = _searchQuery.toLowerCase();
      return nameLower.contains(queryLower) || emailLower.contains(queryLower);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Cari nama atau email...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              filled: true,
              fillColor: Colors.grey[100],
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
        ),

        // Konten Utama
        Expanded(
          child: _buildContent(),
        ),

        // Pagination (Next/Prev)
        if (!_isLoading && _errorMessage == null) _buildPagination(),
      ],
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 60, color: Colors.red),
            SizedBox(height: 16),
            Text(_errorMessage!, textAlign: TextAlign.center),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _fetchUsers(_currentPage),
              child: Text('Coba Lagi'),
            ),
          ],
        ),
      );
    }

    final displayUsers = _filteredUsers;

    if (displayUsers.isEmpty) {
      return Center(child: Text('User tidak ditemukan.'));
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 12),
      itemCount: displayUsers.length,
      itemBuilder: (context, index) {
        final user = displayUsers[index];
        return Card(
          margin: EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.avatar),
              radius: 25,
            ),
            title: Text(
              user.fullName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(user.email),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              // Tampilkan Dialog Detail
              _showUserDetail(context, user);
            },
          ),
        );
      },
    );
  }

  // Widget Navigasi Halaman (Prev / Next)
  Widget _buildPagination() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, -2))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton.icon(
            onPressed: _currentPage > 1
                ? () => _fetchUsers(_currentPage - 1)
                : null, // Disable kalau halaman 1
            icon: Icon(Icons.arrow_back),
            label: Text('Prev'),
          ),
          Text(
            'Page $_currentPage / $_totalPages',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          ElevatedButton.icon(
            onPressed: _currentPage < _totalPages
                ? () => _fetchUsers(_currentPage + 1)
                : null, // Disable kalau halaman terakhir
            icon: Icon(Icons.arrow_forward),
            label: Text('Next'),
          ),
        ],
      ),
    );
  }

  // Dialog Detail User
  void _showUserDetail(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(user.avatar)),
            SizedBox(width: 12),
            Text('Detail User'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${user.id}'),
            SizedBox(height: 8),
            Text('Nama: ${user.fullName}'),
            SizedBox(height: 8),
            Text('Email: ${user.email}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Tutup'),
          )
        ],
      ),
    );
  }
}
