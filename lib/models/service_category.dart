import 'dart:ui';

import 'package:flutter/material.dart';

class ServiceCategory {
  final String name;
  final IconData icon;
  final Color color;
  final int serviceCount;

  ServiceCategory({
    required this.name,
    required this.icon,
    required this.color,
    required this.serviceCount,
  });
}
