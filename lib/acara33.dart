// lib/acara33.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Acara33 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acara 33: REST API'),
        backgroundColor: Colors.deepPurple,
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
      body: UserListPage(),
    );
  }
}

// ============================================================
// MODEL
// ============================================================
class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  // Factory: dari Map JSON ke Object User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
    );
  }

  String get fullName => '$firstName $lastName';
}

// ============================================================
// HALAMAN: DAFTAR USER
// ============================================================
class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  // State: loading, error, data
  bool _isLoading = false;
  String? _errorMessage;
  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  // ============ FUNGSI FETCH DATA DARI API ============
  Future<void> _fetchUsers() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // URL API
      final url = Uri.parse('https://reqres.in/api/users?page=2');

      // GET request dengan header (reqres.in butuh x-api-key)
      final response = await http.get(
        url,
        headers: {'x-api-key': 'reqres-free-v1'},
      );

      // Cek status code
      if (response.statusCode == 200) {
        // Parse JSON
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        // Ambil array `data`
        final List<dynamic> dataList = jsonData['data'];

        // Konversi tiap item ke User
        final users = dataList
            .map((item) => User.fromJson(item as Map<String, dynamic>))
            .toList();

        setState(() {
          _users = users;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Gagal memuat data. Status: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      // Tangkap error jaringan
      setState(() {
        _errorMessage = 'Terjadi kesalahan: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar User'),
        backgroundColor: Colors.deepPurple,
      ),
      body: RefreshIndicator(
        onRefresh: _fetchUsers,
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    // State 1: Loading
    if (_isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Memuat data dari server...'),
          ],
        ),
      );
    }

    // State 2: Error
    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 80, color: Colors.red),
              SizedBox(height: 16),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _fetchUsers,
                icon: Icon(Icons.refresh),
                label: Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      );
    }

    // State 3: Kosong
    if (_users.isEmpty) {
      return Center(child: Text('Tidak ada data user'));
    }

    // State 4: Data berhasil dimuat
    return ListView.builder(
      padding: EdgeInsets.all(12),
      itemCount: _users.length,
      itemBuilder: (context, i) {
        final user = _users[i];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.avatar),
              radius: 26,
            ),
            title: Text(
              user.fullName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(user.email),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Buka detail user
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UserDetailPage(userId: user.id),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

// ============================================================
// HALAMAN: DETAIL USER (GET Detail)
// ============================================================
class UserDetailPage extends StatefulWidget {
  final int userId;

  UserDetailPage({required this.userId});

  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  bool _isLoading = false;
  String? _errorMessage;
  User? _user;

  @override
  void initState() {
    super.initState();
    _fetchUserDetail();
  }

  Future<void> _fetchUserDetail() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // URL: GET detail — https://reqres.in/api/users/:id
      final url = Uri.parse('https://reqres.in/api/users/${widget.userId}');

      final response = await http.get(
        url,
        headers: {'x-api-key': 'reqres-free-v1'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        final userData = jsonData['data'];

        setState(() {
          _user = User.fromJson(userData);
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Status: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail User'),
        backgroundColor: Colors.deepPurple,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, size: 60, color: Colors.red),
            SizedBox(height: 12),
            Text(_errorMessage!),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: _fetchUserDetail,
              child: Text('Coba Lagi'),
            ),
          ],
        ),
      );
    }

    if (_user == null) {
      return Center(child: Text('Data tidak ditemukan'));
    }

    final user = _user!;
    return SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(user.avatar),
            radius: 60,
          ),
          SizedBox(height: 24),
          Text(
            user.fullName,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(user.email, style: TextStyle(color: Colors.grey[600])),
          SizedBox(height: 32),
          Card(
            child: ListTile(
              leading: Icon(Icons.badge, color: Colors.deepPurple),
              title: Text('User ID'),
              trailing: Text('${user.id}',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.person, color: Colors.deepPurple),
              title: Text('First Name'),
              trailing: Text(user.firstName),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.person_outline, color: Colors.deepPurple),
              title: Text('Last Name'),
              trailing: Text(user.lastName),
            ),
          ),
        ],
      ),
    );
  }
}
