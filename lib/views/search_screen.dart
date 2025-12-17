import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weathergeh_app/viewmodels/weather_viewmodel.dart';

class SearchScreen extends HookConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final debounceTimer = useRef<Timer?>(null);
    final searchResults = ref.watch(searchResultsProvider);

    void onSearchChanged(String query) {
      debounceTimer.value?.cancel();
      debounceTimer.value = Timer(const Duration(milliseconds: 500), () {
        ref.read(searchQueryProvider.notifier).state = query;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('search.hint'.tr()),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade700, Colors.blue.shade900],
          ),
        ),
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: searchController,
                onChanged: onSearchChanged,
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: 'search.hint'.tr(),
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                  prefixIcon: Icon(Icons.search, color: Colors.white.withOpacity(0.7)),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: Colors.white.withOpacity(0.7)),
                          onPressed: () {
                            searchController.clear();
                            ref.read(searchQueryProvider.notifier).state = '';
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.white, width: 1),
                  ),
                ),
              ),
            ),

            // Results
            Expanded(
              child: searchResults.when(
                data: (locations) {
                  if (locations.isEmpty) {
                    final query = ref.watch(searchQueryProvider);
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            query.isEmpty ? Icons.search : Icons.location_off,
                            size: 64,
                            color: Colors.white.withOpacity(0.5),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            query.isEmpty ? 'search.hint'.tr() : 'search.no_results'.tr(),
                            style: TextStyle(color: Colors.white.withOpacity(0.7)),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: locations.length,
                    itemBuilder: (context, index) {
                      final location = locations[index];
                      return Card(
                        color: Colors.white.withOpacity(0.1),
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: const Icon(Icons.location_city, color: Colors.white),
                          title: Text(
                            location.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            '${location.state ?? ''} ${location.country}',
                            style: TextStyle(color: Colors.white.withOpacity(0.7)),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios, 
                            color: Colors.white, 
                            size: 16,
                          ),
                          onTap: () {
                            // Update location and go back
                            ref.read(currentLocationProvider.notifier).state = {
                              'city': location.name,
                              'lat': location.lat,
                              'lon': location.lon,
                            };
                            ref.invalidate(currentWeatherProvider);
                            ref.invalidate(forecastProvider);
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
                error: (e, _) => Center(
                  child: Text(
                    'Error: $e',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
