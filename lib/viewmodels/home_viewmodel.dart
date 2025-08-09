import 'package:flutter/material.dart';
import 'package:localservice/services/data_services.dart';
import '../models/service_category.dart';
import '../models/service_provider.dart';

class HomeViewModel extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  String _searchQuery = '';

  String get searchQuery => _searchQuery;

  List<ServiceCategory> get categories => DataService.categories;
  List<ServiceProvider> get featuredServices =>
      DataService.getFeaturedServices();

  List<ServiceProvider> get searchResults {
    if (_searchQuery.isEmpty) return [];

    return DataService.allServices
        .where(
          (service) =>
              service.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              service.category.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ||
              service.description.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ),
        )
        .toList();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    searchController.clear();
    notifyListeners();
  }

  void makePhoneCall(String phone) {
    // In a real app, you would use url_launcher to make a phone call
    print('Calling $phone...');
  }

  void sendWhatsApp(String phone) {
    // In a real app, you would use url_launcher to open WhatsApp
    print('Opening WhatsApp for $phone...');
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
