// lib/acara43.dart
import 'package:flutter/material.dart';
import 'model/post_model.dart';
import 'data/crud_api.dart';

class Acara43 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acara 43: CRUD III (Add & Edit)'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () =>
                Navigator.popUntil(context, (route) => route.isFirst),
          ),
        ],
      ),
      body: AddEditScreen(),
    );
  }
}

class AddEditScreen extends StatefulWidget {
  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  bool _isLoading = false;
  Post?
      _editingPost; // Jika null, berarti mode Tambah. Jika ada isinya, mode Edit.

  // Fungsi untuk menyimpan data (Create / Update)
  Future<void> _simpanData() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    bool success;
    if (_editingPost == null) {
      // Mode Create (POST)
      success =
          await CrudApi.createPost(_titleController.text, _bodyController.text);
    } else {
      // Mode Update (PUT)
      success = await CrudApi.updatePost(
          _editingPost!.id, _titleController.text, _bodyController.text);
    }

    setState(() => _isLoading = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_editingPost == null
              ? 'Data Berhasil Ditambahkan!'
              : 'Data Berhasil Diupdate!'),
          backgroundColor: Colors.green,
        ),
      );
      _resetForm();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Gagal menyimpan data'), backgroundColor: Colors.red),
      );
    }
  }

  // Reset form ke keadaan awal
  void _resetForm() {
    setState(() {
      _editingPost = null;
      _titleController.clear();
      _bodyController.clear();
    });
  }

  // Simulasi memilih data untuk diedit
  void _pilihDataUntukEdit() {
    // Kita buat data dummy seolah-olah diambil dari database
    final dummyPost = Post(
      id: 1,
      title: 'Belajar Flutter',
      body: 'Ini adalah isi dari postingan dummy yang akan diedit.',
    );

    setState(() {
      _editingPost = dummyPost;
      _titleController.text = dummyPost.title;
      _bodyController.text = dummyPost.body;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Info Status Mode
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _editingPost == null
                    ? Colors.teal.shade50
                    : Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _editingPost == null
                    ? 'Mode: TAMBAH DATA BARU (POST)'
                    : 'Mode: EDIT DATA ID ${_editingPost!.id} (PUT)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _editingPost == null
                      ? Colors.teal.shade900
                      : Colors.orange.shade900,
                ),
              ),
            ),
            SizedBox(height: 24),

            // Input Judul
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Judul Postingan',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.title),
              ),
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Judul tidak boleh kosong';
                return null;
              },
            ),
            SizedBox(height: 16),

            // Input Isi
            TextFormField(
              controller: _bodyController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Isi Postingan',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Isi tidak boleh kosong';
                return null;
              },
            ),
            SizedBox(height: 24),

            // Tombol Simpan
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : ElevatedButton.icon(
                    onPressed: _simpanData,
                    icon: Icon(Icons.save),
                    label: Text(_editingPost == null
                        ? 'TAMBAH DATA (POST)'
                        : 'SIMPAN PERUBAHAN (PUT)'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _editingPost == null ? Colors.teal : Colors.orange,
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
            SizedBox(height: 12),

            // Tombol Tambahan untuk Simulasi
            OutlinedButton(
              onPressed: _pilihDataUntukEdit,
              child: Text('Simulasi Pilih Data untuk Diedit'),
            ),
            if (_editingPost != null)
              TextButton(
                onPressed: _resetForm,
                child: Text('Batal Edit (Kembali ke Mode Tambah)',
                    style: TextStyle(color: Colors.red)),
              ),
          ],
        ),
      ),
    );
  }
}
