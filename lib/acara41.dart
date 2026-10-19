// lib/acara41.dart
import 'package:flutter/material.dart';
import 'model/post_model.dart';
import 'data/crud_api.dart';

class Acara41 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acara 41: CRUD API'),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () =>
                Navigator.popUntil(context, (route) => route.isFirst),
          ),
        ],
      ),
      body: CrudScreen(),
    );
  }
}

class CrudScreen extends StatefulWidget {
  @override
  _CrudScreenState createState() => _CrudScreenState();
}

class _CrudScreenState extends State<CrudScreen> {
  List<Post> _posts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // READ
  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final posts = await CrudApi.getPosts();
      setState(() {
        _posts = posts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  // Dialog untuk Create & Update
  void _showFormDialog({Post? post}) {
    final titleController = TextEditingController(text: post?.title ?? '');
    final bodyController = TextEditingController(text: post?.body ?? '');
    final isEdit = post != null;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEdit ? 'Edit Post' : 'Tambah Post'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Judul'),
            ),
            TextField(
              controller: bodyController,
              decoration: InputDecoration(labelText: 'Isi'),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              final title = titleController.text;
              final body = bodyController.text;
              if (title.isEmpty || body.isEmpty) return;

              Navigator.pop(context); // Tutup dialog

              bool success;
              if (isEdit) {
                success = await CrudApi.updatePost(post.id, title, body);
              } else {
                success = await CrudApi.createPost(title, body);
              }

              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(isEdit
                          ? 'Berhasil diupdate!'
                          : 'Berhasil ditambahkan!'),
                      backgroundColor: Colors.green),
                );
                _loadData(); // Refresh list
              }
            },
            child: Text(isEdit ? 'Simpan' : 'Tambah'),
          ),
        ],
      ),
    );
  }

  // DELETE
  Future<void> _deletePost(int id) async {
    final success = await CrudApi.deletePost(id);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Berhasil dihapus!'), backgroundColor: Colors.red),
      );
      _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                final post = _posts[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(child: Text('${post.id}')),
                    title: Text(post.title,
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                    subtitle: Text(post.body,
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Tombol Edit (UPDATE)
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _showFormDialog(post: post),
                        ),
                        // Tombol Hapus (DELETE)
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deletePost(post.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      // Tombol Tambah (CREATE)
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFormDialog(),
        child: Icon(Icons.add),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }
}
