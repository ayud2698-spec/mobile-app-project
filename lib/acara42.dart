// lib/acara42.dart
import 'package:flutter/material.dart';
import 'model/post_model.dart';
import 'data/crud_api.dart';

class Acara42 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acara 42: CRUD II (Detail)'),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () =>
                Navigator.popUntil(context, (route) => route.isFirst),
          ),
        ],
      ),
      body: DetailScreen(),
    );
  }
}

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final _idController = TextEditingController();
  Post? _post;
  bool _isLoading = false;
  String? _error;

  Future<void> _fetchDetail() async {
    final idString = _idController.text.trim();
    if (idString.isEmpty) return;

    final id = int.tryParse(idString);
    if (id == null) {
      setState(() => _error = 'ID harus berupa angka');
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
      _post = null;
    });

    try {
      final result = await CrudApi.getPostDetail(id);
      setState(() {
        _post = result;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString().replaceAll('Exception: ', '');
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Penjelasan Konsep URL Server
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Di Laravel, URL API biasanya diubah menjadi IP lokal, misal: http://192.168.1.10:8000/api/posts/\n\n'
              'Di aplikasi ini, kita menggunakan API publik: https://jsonplaceholder.typicode.com/posts/',
              style: TextStyle(fontSize: 12, color: Colors.indigo.shade900),
            ),
          ),
          SizedBox(height: 20),

          // Input ID
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _idController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Masukkan ID Post (1-100)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: _fetchDetail,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('Cari'),
              ),
            ],
          ),
          SizedBox(height: 24),

          // Tampilan Hasil
          if (_isLoading)
            Center(child: CircularProgressIndicator())
          else if (_error != null)
            Center(
              child: Text(_error!,
                  style: TextStyle(color: Colors.red, fontSize: 16)),
            )
          else if (_post != null)
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Chip(
                      label: Text('ID: ${_post!.id}'),
                      backgroundColor: Colors.indigo.shade100,
                    ),
                    SizedBox(height: 12),
                    Text(
                      _post!.title.toUpperCase(),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                    SizedBox(height: 8),
                    Text(
                      _post!.body,
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ],
                ),
              ),
            )
          else
            Center(
              child: Text(
                'Silakan masukkan ID dan klik Cari.',
                style: TextStyle(color: Colors.grey),
              ),
            ),
        ],
      ),
    );
  }
}
