import 'dart:math';

import 'package:flutter/material.dart';
import 'map_data.dart';

class MapScreen extends StatefulWidget {
  final MapData mapData;

  const MapScreen(this.mapData, {super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String _randomKey = '';

  void _generateRandomKey() {
    if (widget.mapData.data.isEmpty) {
      return; // Handle case of empty map gracefully
    }
    setState(() {
      _randomKey = widget.mapData.data.keys.toList()[Random().nextInt(widget.mapData.data.length)];
    });
  }

  void _showValue() {
    if (_randomKey.isEmpty) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Value'),
        content: Text(widget.mapData.data[_randomKey]!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mapData.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _randomKey.isEmpty ? 'No key generated yet' : 'Random Key: $_randomKey',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateRandomKey,
              child: const Text('Generate Random Key'),
            ),
            const SizedBox(height: 20),
            if (_randomKey.isNotEmpty) // Only show button if a key is generated
              ElevatedButton(
                onPressed: _showValue,
                child: const Text('Show Value'),
              ),
          ],
        ),
      ),
    );
  }
}
