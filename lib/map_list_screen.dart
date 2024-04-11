import 'package:flutter/material.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:random_generator/map_data.dart';
import 'package:random_generator/sample_data.dart';
import 'package:random_generator/shared_prefs_service.dart';


import 'map_screen.dart';
import 'new_map_screen.dart';

class MapListScreen extends StatefulWidget {
  const MapListScreen({super.key});

  @override
  State<MapListScreen> createState() => _MapListScreenState();
}

class _MapListScreenState extends State<MapListScreen> {
  List<MapData> _maps = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMaps();
  }

  Future<void> _loadMaps() async {
    await _loadSampleData();
    _maps = await SharedPrefsService.getMaps();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _loadSampleData() async {
    bool firstRun = await IsFirstRun.isFirstRun();
    if(firstRun){
      List<MapData> sampleData = SampleData.getSampleData();
      for (var mapData in sampleData) {
        await SharedPrefsService.saveMap(mapData);
      }
    }
  }

  _navigateToNewMapScreen(MapData mapData) async{
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewMapScreen(mapData: mapData),
      ),
    );
    _loadMaps();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map List'),
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _maps.length,
        itemBuilder: (context, index) {
          final mapData = _maps[index];
          return Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) async {
              String name = mapData.name;
              await SharedPrefsService.deleteMap(name);
              setState(() {
                _maps.removeAt(index);
              });
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('$name dismissed')));
            },
            background: Container(color: Colors.red),
            child: ListTile(
              title: Text(mapData.name),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapScreen(mapData),
                  ),
                );
              },
              trailing: IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () => _navigateToNewMapScreen(mapData),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToNewMapScreen(MapData("", {})),
        child: const Icon(Icons.add)
      ),
    );
  }
}