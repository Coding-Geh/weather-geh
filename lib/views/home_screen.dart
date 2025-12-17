import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weathergeh_app/core/theme/app_theme.dart';
import 'package:weathergeh_app/viewmodels/theme_viewmodel.dart';
import 'package:weathergeh_app/viewmodels/weather_viewmodel.dart';
import 'package:weathergeh_app/views/search_screen.dart';
import 'package:weathergeh_app/views/widgets/current_weather_card.dart';
import 'package:weathergeh_app/views/widgets/daily_forecast_card.dart';
import 'package:weathergeh_app/views/widgets/hourly_forecast_card.dart';
import 'package:weathergeh_app/views/widgets/weather_details_card.dart';
import 'package:weathergeh_app/views/widgets/weather_loading.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(initLocationProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final weatherAsync = ref.watch(currentWeatherProvider);
    final forecastAsync = ref.watch(forecastProvider);
    final dailyForecast = ref.watch(dailyForecastProvider);
    final isNight = ref.watch(isNightProvider);
    final themeMode = ref.watch(themeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;
    final locationError = ref.watch(locationErrorProvider);

    final gradient = weatherAsync.when(
      data: (weather) {
        final condition = weather.weather.isNotEmpty ? weather.weather.first.main : 'Clear';
        return AppTheme.getWeatherGradient(condition, isNight: isNight || isDarkMode);
      },
      loading: () => isDarkMode ? AppTheme.nightGradient : AppTheme.sunnyGradient,
      error: (_, __) => AppTheme.sunnyGradient,
    );

    final textColor = isDarkMode ? Colors.white : Colors.grey[800]!;
    final secondaryTextColor = isDarkMode ? Colors.white.withOpacity(0.6) : Colors.grey[600]!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          'title'.tr(),
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            shadows: isDarkMode ? [const Shadow(color: Colors.black26, blurRadius: 4)] : null,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            color: textColor,
            tooltip: 'Use my location',
            onPressed: () => _useMyLocation(),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            color: textColor,
            onPressed: () => _openSearch(context, ref),
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: textColor),
            color: isDarkMode ? Colors.grey[800] : Colors.white,
            onSelected: (value) {
              switch (value) {
                case 'theme':
                  ref.read(themeProvider.notifier).setTheme(
                    isDarkMode ? ThemeMode.light : ThemeMode.dark,
                  );
                  break;
                case 'language':
                  if (context.locale.languageCode == 'en') {
                    context.setLocale(const Locale('id', 'ID'));
                  } else {
                    context.setLocale(const Locale('en', 'US'));
                  }
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'theme',
                child: Row(
                  children: [
                    Icon(
                      isDarkMode ? Icons.light_mode : Icons.dark_mode,
                      color: isDarkMode ? Colors.white : Colors.grey[800],
                    ),
                    const SizedBox(width: 12),
                    Text(
                      isDarkMode ? 'Light Mode' : 'Dark Mode',
                      style: TextStyle(color: isDarkMode ? Colors.white : Colors.grey[800]),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'language',
                child: Row(
                  children: [
                    Icon(
                      Icons.language,
                      color: isDarkMode ? Colors.white : Colors.grey[800],
                    ),
                    const SizedBox(width: 12),
                    Text(
                      context.locale.languageCode == 'en' ? 'Bahasa Indonesia' : 'English',
                      style: TextStyle(color: isDarkMode ? Colors.white : Colors.grey[800]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: gradient),
        child: SafeArea(
          child: Column(
            children: [
              if (locationError != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: Colors.orange.withOpacity(0.8),
                  child: Row(
                    children: [
                      const Icon(Icons.location_off, color: Colors.white, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Using default location. Tap 📍 to enable GPS',
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white, size: 18),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          ref.read(locationErrorProvider.notifier).state = null;
                        },
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: weatherAsync.when(
                  data: (weather) => RefreshIndicator(
                    color: isDarkMode ? Colors.white : Colors.blue,
                    backgroundColor: isDarkMode ? Colors.blue.shade700 : Colors.white,
                    onRefresh: () async {
                      ref.invalidate(currentWeatherProvider);
                      ref.invalidate(forecastProvider);
                    },
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final isWideScreen = constraints.maxWidth > 600;
                        final maxContentWidth = isWideScreen ? 500.0 : double.infinity;
                        
                        return SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight,
                            ),
                            child: Center(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: maxContentWidth),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isWideScreen ? 24 : 8,
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 16),
                                      CurrentWeatherCard(
                                        weather: weather, 
                                        isNight: isNight,
                                        isDarkMode: isDarkMode,
                                      ),
                                      const SizedBox(height: 24),
                                      WeatherDetailsCard(
                                        weather: weather,
                                        isDarkMode: isDarkMode,
                                      ),
                                      const SizedBox(height: 16),
                                      forecastAsync.when(
                                        data: (forecast) => HourlyForecastCard(
                                          forecast: forecast.list,
                                          isDarkMode: isDarkMode,
                                        ),
                                        loading: () => const SizedBox.shrink(),
                                        error: (_, __) => const SizedBox.shrink(),
                                      ),
                                      const SizedBox(height: 16),
                                      if (dailyForecast.isNotEmpty)
                                        DailyForecastCard(
                                          dailyForecast: dailyForecast,
                                          isDarkMode: isDarkMode,
                                        ),
                                      const SizedBox(height: 24),
                                      Text(
                                        '© ${DateTime.now().year} Coding Geh · ${'footer.rights'.tr()}',
                                        style: TextStyle(
                                          color: secondaryTextColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  loading: () => const WeatherLoading(),
                  error: (e, _) => Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.cloud_off, color: textColor, size: 64),
                          const SizedBox(height: 16),
                          Text(
                            'Error loading weather',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '$e',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: secondaryTextColor,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: () {
                              ref.invalidate(currentWeatherProvider);
                              ref.invalidate(forecastProvider);
                            },
                            icon: const Icon(Icons.refresh),
                            label: const Text('Retry'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDarkMode 
                                  ? Colors.white.withOpacity(0.2)
                                  : Colors.blue.shade600,
                              foregroundColor: isDarkMode ? Colors.white : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _useMyLocation() async {
    final geoService = ref.read(geolocationServiceProvider);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
            ),
            SizedBox(width: 12),
            Text('Getting your location...'),
          ],
        ),
        duration: Duration(seconds: 2),
      ),
    );
    
    final position = await geoService.getCurrentPosition();
    
    if (position != null) {
      ref.read(currentLocationProvider.notifier).state = {
        'city': 'My Location',
        'lat': position.latitude,
        'lon': position.longitude,
      };
      ref.read(locationErrorProvider.notifier).state = null;
      ref.invalidate(currentWeatherProvider);
      ref.invalidate(forecastProvider);
      
      if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('📍 Location updated!'),
            duration: Duration(seconds: 1),
            backgroundColor: Colors.green,
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Location permission denied'),
            action: SnackBarAction(
              label: 'Settings',
              onPressed: () => geoService.openSettings(),
            ),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  void _openSearch(BuildContext context, WidgetRef ref) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SearchScreen()),
    );
  }
}
