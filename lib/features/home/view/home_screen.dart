import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';

class ApiScreen extends ConsumerStatefulWidget {
  const ApiScreen({super.key});

  @override
  ConsumerState<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends ConsumerState<ApiScreen> {
  final urlController = TextEditingController();
  String method = "GET";
  String responseText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("LAN API Tool")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // METHOD DROPDOWN
            DropdownButton<String>(
              value: method,
              items: ["GET", "POST"]
                  .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                  .toList(),
              onChanged: (value) {
                setState(() => method = value!);
              },
            ),

            // URL INPUT
            TextField(
              controller: urlController,
              decoration: const InputDecoration(
                labelText: "Enter API URL",
              ),
            ),

            const SizedBox(height: 20),

            // SEND BUTTON
            ElevatedButton(
              onPressed: sendRequest,
              child: const Text("Send"),
            ),

            const SizedBox(height: 20),

            // RESPONSE
            Expanded(
              child: SingleChildScrollView(
                child: Text(responseText),
              ),
            ),
          ],
        ),
      ),
    );
  }

void sendRequest() async {
  final client = ApiClient();

  final result = await client.send(
    url: urlController.text,
    method: method,
  );

  setState(() {
    responseText = result;
  });
}
}