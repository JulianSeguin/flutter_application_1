import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  @override
  void initState() {
    super.initState();
    fetchQuote();  // récupération de la citation
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder(); // pas d'UI pour l'instant
  }

  // Méthode pour la récupération de la citation
  // Affiche la citation sur la console
  Future<void> fetchQuote() async {
    final url = Uri.parse('https://zenquotes.io/api/random');
    final response = await http.get(url);
    if (response.statusCode == 200) { // 200 = OK
      final quote = response.body;
      print(quote);
    } else {
      print('Échec de récupération de la citation');
    }
  }
}