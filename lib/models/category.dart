import 'package:flutter/material.dart';

class Category {
  final int id;
  final String nama_kategori;
  final IconData icon;

  Category({
    required this.id,
    required this.nama_kategori,
    required this.icon,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      nama_kategori: json['nama_kategori'],
      icon: _getCategoryIcon(json['nama_kategori']),
    );
  }

  static IconData _getCategoryIcon(String categoryTitle) {
    switch (categoryTitle.toLowerCase()) {
      case 'novel':
        return Icons.book;
      case 'technology':
        return Icons.computer;
      case 'science':
        return Icons.science;
      case 'history':
        return Icons.history_edu;
      case 'biography':
        return Icons.person;
      case 'fiction':
        return Icons.auto_stories;
      case 'adventure':
        return Icons.explore;
      case 'romance':
        return Icons.favorite;
      case 'mystery':
        return Icons.help_outline;
      case 'mindset':
        return Icons.lightbulb_outline;
      case 'economy':
        return Icons.monetization_on;
      default:
        return Icons.category; // Default icon for unknown categories
    }
  }
}
