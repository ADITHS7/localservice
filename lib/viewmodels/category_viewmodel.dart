// viewmodels/category_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:localservice/services/data_services.dart';

import '../models/service_provider.dart';

class CategoryViewModel extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  String _searchQuery = '';
  String _sortBy = 'rating'; // rating, name, location

  String get searchQuery => _searchQuery;
  String get sortBy => _sortBy;

  List<ServiceProvider> getFilteredServices(String category) {
    List<ServiceProvider> services = DataService.getServicesByCategory(
      category,
    );

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      services =
          services
              .where(
                (service) =>
                    service.name.toLowerCase().contains(
                      _searchQuery.toLowerCase(),
                    ) ||
                    service.description.toLowerCase().contains(
                      _searchQuery.toLowerCase(),
                    ) ||
                    service.location.toLowerCase().contains(
                      _searchQuery.toLowerCase(),
                    ),
              )
              .toList();
    }

    // Apply sorting
    switch (_sortBy) {
      case 'rating':
        services.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'name':
        services.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'location':
        services.sort((a, b) => a.location.compareTo(b.location));
        break;
    }

    return services;
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void updateSortBy(String sortBy) {
    _sortBy = sortBy;
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    searchController.clear();
    notifyListeners();
  }

  void makePhoneCall(String phone) {
    print('Calling $phone...');
  }

  void sendWhatsApp(String phone) {
    print('Opening WhatsApp for $phone...');
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
