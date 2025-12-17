import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weathergeh_app/core/constants/api_constants.dart';
import 'package:weathergeh_app/models/weather.dart';

class CurrentWeatherCard extends StatelessWidget {
  final CurrentWeather weather;
  final bool isNight;
  final bool isDarkMode;

  const CurrentWeatherCard({
    super.key,
    required this.weather,
    this.isNight = false,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final condition = weather.weather.isNotEmpty ? weather.weather.first : null;
    final iconUrl = condition != null
        ? ApiConstants.getIconUrl(condition.icon, size: ApiConstants.iconXLarge)
        : '';

    // Use dark text for light mode, white for dark mode
    final textColor = isDarkMode ? Colors.white : Colors.grey[800]!;
    final secondaryTextColor = isDarkMode ? Colors.white.withOpacity(0.8) : Colors.grey[600]!;
    final tertiaryTextColor = isDarkMode ? Colors.white.withOpacity(0.7) : Colors.grey[500]!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Location
          Text(
            weather.name,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: textColor,
              shadows: isDarkMode ? [const Shadow(color: Colors.black26, blurRadius: 4)] : null,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
          if (weather.sys.country != null)
            Text(
              weather.sys.country!,
              style: TextStyle(
                fontSize: 14,
                color: secondaryTextColor,
              ),
            ),

          const SizedBox(height: 16),

          // Weather icon
          if (iconUrl.isNotEmpty)
            CachedNetworkImage(
              imageUrl: iconUrl,
              width: 120,
              height: 120,
              fit: BoxFit.contain,
              placeholder: (_, __) => const SizedBox(width: 120, height: 120),
              errorWidget: (_, __, ___) => Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: (isDarkMode ? Colors.white : Colors.grey).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(60),
                ),
                child: Icon(
                  Icons.cloud,
                  size: 60,
                  color: textColor,
                ),
              ),
            ),

          // Temperature
          Text(
            '${weather.main.temp.round()}°C',
            style: TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.w200,
              color: textColor,
              height: 1.1,
            ),
          ),

          // Condition
          if (condition != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: isDarkMode 
                    ? Colors.white.withOpacity(0.15) 
                    : Colors.grey[800]!.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                condition.description.toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                  letterSpacing: 1.5,
                ),
              ),
            ),

          const SizedBox(height: 12),

          // Feels like
          Text(
            '${'weather.feels_like'.tr()} ${weather.main.feelsLike.round()}°',
            style: TextStyle(
              fontSize: 14,
              color: tertiaryTextColor,
            ),
          ),

          const SizedBox(height: 16),

          // Min/Max
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: isDarkMode 
                  ? Colors.white.withOpacity(0.1) 
                  : Colors.grey[800]!.withOpacity(0.08),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _TempBadge(
                  icon: Icons.arrow_upward,
                  temp: weather.main.tempMax.round(),
                  label: 'H',
                  color: Colors.orange.shade400,
                  textColor: textColor,
                ),
                Container(
                  width: 1,
                  height: 20,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  color: isDarkMode ? Colors.white.withOpacity(0.3) : Colors.grey.withOpacity(0.3),
                ),
                _TempBadge(
                  icon: Icons.arrow_downward,
                  temp: weather.main.tempMin.round(),
                  label: 'L',
                  color: Colors.blue.shade400,
                  textColor: textColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TempBadge extends StatelessWidget {
  final IconData icon;
  final int temp;
  final String label;
  final Color color;
  final Color textColor;

  const _TempBadge({
    required this.icon,
    required this.temp,
    required this.label,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 4),
        Text(
          '$label: $temp°',
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
