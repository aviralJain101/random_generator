import 'package:flutter/material.dart';
import 'package:random_generator/map_data.dart';
import 'package:random_generator/shared_prefs_service.dart';

class NewMapScreen extends StatefulWidget {
  final MapData mapData;
  const NewMapScreen({super.key, required this.mapData});

  @override
  State<NewMapScreen> createState() => _NewMapScreenState();
}

class _NewMapScreenState extends State<NewMapScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  Map<String, dynamic> newMap = {};

  @override
  void initState() {
    super.initState();
    newMap = widget.mapData.data;
    _nameController.text = widget.mapData.name;
  }

  void _handleSave() async {
    if (_nameController.text.isNotEmpty && newMap.isNotEmpty) {
      final tempMapData = MapData(_nameController.text, newMap);
      if(widget.mapData.name.isNotEmpty){
        await SharedPrefsService.deleteMap(widget.mapData.name);
      }
      await SharedPrefsService.saveMap(tempMapData);
      Navigator.of(context).pop();
    }
  }

  void _addKeyValue() {
    setState(() {
      newMap[_keyController.text] = _valueController.text;
      _keyController.clear();
      _valueController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Map'),
        actions: [
          IconButton(onPressed: _handleSave, icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Map Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _keyController,
              decoration: const InputDecoration(labelText: 'Key'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _valueController,
              decoration: const InputDecoration(labelText: 'Value'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addKeyValue,
              child: const Text('Add Key-Value'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: newMap.length,
                itemBuilder: (context, index) {
                  var key = newMap.keys.toList()[index];
                  return ListTile(
                    title: Text('$key: ${newMap[key]}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}