import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/service_category.dart';
import '../viewmodels/category_viewmodel.dart';
import '../widgets/service_card.dart';

class CategoryView extends StatelessWidget {
  final ServiceCategory category;

  const CategoryView({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CategoryViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(category.name),
          actions: [
            Consumer<CategoryViewModel>(
              builder: (context, viewModel, child) {
                return PopupMenuButton<String>(
                  icon: const Icon(Icons.sort),
                  onSelected: viewModel.updateSortBy,
                  itemBuilder:
                      (context) => [
                        PopupMenuItem(
                          value: 'rating',
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color:
                                    viewModel.sortBy == 'rating'
                                        ? Colors.blue
                                        : Colors.grey,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Sort by Rating',
                                style: TextStyle(
                                  color:
                                      viewModel.sortBy == 'rating'
                                          ? Colors.blue
                                          : Colors.black,
                                  fontWeight:
                                      viewModel.sortBy == 'rating'
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'name',
                          child: Row(
                            children: [
                              Icon(
                                Icons.sort_by_alpha,
                                color:
                                    viewModel.sortBy == 'name'
                                        ? Colors.blue
                                        : Colors.grey,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Sort by Name',
                                style: TextStyle(
                                  color:
                                      viewModel.sortBy == 'name'
                                          ? Colors.blue
                                          : Colors.black,
                                  fontWeight:
                                      viewModel.sortBy == 'name'
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'location',
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color:
                                    viewModel.sortBy == 'location'
                                        ? Colors.blue
                                        : Colors.grey,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Sort by Location',
                                style: TextStyle(
                                  color:
                                      viewModel.sortBy == 'location'
                                          ? Colors.blue
                                          : Colors.black,
                                  fontWeight:
                                      viewModel.sortBy == 'location'
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                );
              },
            ),
          ],
        ),
        body: Consumer<CategoryViewModel>(
          builder: (context, viewModel, child) {
            final services = viewModel.getFilteredServices(category.name);

            return Column(
              children: [
                // Category Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: category.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Icon(category.icon, color: category.color, size: 48),
                      const SizedBox(height: 12),
                      Text(
                        category.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${services.length} services available',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),
                ),

                // Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: viewModel.searchController,
                      onChanged: viewModel.updateSearchQuery,
                      decoration: InputDecoration(
                        hintText: 'Search in ${category.name}...',
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        suffixIcon:
                            viewModel.searchQuery.isNotEmpty
                                ? IconButton(
                                  icon: const Icon(
                                    Icons.clear,
                                    color: Colors.grey,
                                  ),
                                  onPressed: viewModel.clearSearch,
                                )
                                : null,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Services List
                Expanded(
                  child:
                      services.isEmpty
                          ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 64,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  viewModel.searchQuery.isNotEmpty
                                      ? 'No services found for "${viewModel.searchQuery}"'
                                      : 'No services available',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                if (viewModel.searchQuery.isNotEmpty) ...[
                                  const SizedBox(height: 8),
                                  TextButton(
                                    onPressed: viewModel.clearSearch,
                                    child: const Text('Clear search'),
                                  ),
                                ],
                              ],
                            ),
                          )
                          : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: services.length,
                            itemBuilder: (context, index) {
                              final service = services[index];
                              return ServiceCard(
                                service: service,
                                onCall:
                                    () =>
                                        viewModel.makePhoneCall(service.phone),
                                onChat:
                                    () => viewModel.sendWhatsApp(service.phone),
                              );
                            },
                          ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
