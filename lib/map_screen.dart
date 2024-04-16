import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'int_text_editing_controller.dart';
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
  Timer? _timer;
  IntTextEditingController _timerSecondsController = IntTextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the timer and start tracking elapsed time
    _timerSecondsController.intValue = 10;
  }

  @override
  void dispose() {
    // Dispose of the timer when the widget is disposed
    _timer?.cancel();
    super.dispose();
  }

  void _generateRandomKey() {
    if (widget.mapData.data.isEmpty) {
      return; // Handle case of empty map gracefully
    }
    setState(() {
      _isShowValue = false;
      _randomKey = widget.mapData.data.keys.toList()[Random().nextInt(widget.mapData.data.length)];
    });
    _refreshTimer(_timerSecondsController.intValue);
  }

  void _refreshTimer(int sec){
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: sec), (timer) {
      _generateRandomKey();
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

  void _updateSettings(){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: const Text('Change Timer Duration'),
          content: TextField(
            keyboardType: TextInputType.number,
            controller: _timerSecondsController,
          ),
          actions: [
            TextButton(
              onPressed: () {
                _refreshTimer(_timerSecondsController.intValue);
                Navigator.pop(context);
              },
              child: const Text('Set'),
            ),
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mapData.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _updateSettings,
          ),
        ],
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
