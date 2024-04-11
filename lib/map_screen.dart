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
  bool _isShowValue = false;

  void _generateRandomKey() {
    if (widget.mapData.data.isEmpty) {
      return; // Handle case of empty map gracefully
    }
    setState(() {
      _isShowValue = false;
      _randomKey = widget.mapData.data.keys.toList()[Random().nextInt(widget.mapData.data.length)];
    });
  }

  void _showValue() {
    if (_randomKey.isEmpty) return;
    setState(() {
      _isShowValue = true;
    });
    // showDialog(
    //   context: context,
    //   builder: (context) => AlertDialog(
    //     title: const Text('Value', style: TextStyle(fontSize: 20),),
    //     content: Text(widget.mapData.data[_randomKey]!, style: const TextStyle(fontSize: 40),),
    //   ),
    // );
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
              _randomKey.isEmpty ? 'No key generated yet' : _randomKey,
              style: const TextStyle(fontSize: 40),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _generateRandomKey,
              child: const Text('Generate Random Key'),
            ),
            const SizedBox(height: 40),
            if (_randomKey.isNotEmpty) // Only show button if a key is generated
              ElevatedButton(
                onPressed: _showValue,
                child: const Text('Show Value'),
              ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: Text(
                _isShowValue ? widget.mapData.data[_randomKey]! : '',
                style: const TextStyle(fontSize: 40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
