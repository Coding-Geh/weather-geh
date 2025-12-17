import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weathergeh_app/core/constants/api_constants.dart';
import 'package:weathergeh_app/models/weather.dart';

class HourlyForecastCard extends StatelessWidget {
  final List<ForecastItem> forecast;
  final bool isDarkMode;

  const HourlyForecastCard({
    super.key, 
    required this.forecast,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isDarkMode ? Colors.white : Colors.grey[800]!;
    final secondaryTextColor = isDarkMode ? Colors.white.withOpacity(0.8) : Colors.grey[600]!;
    final cardColor = isDarkMode 
        ? Colors.white.withOpacity(0.15) 
        : Colors.grey[800]!.withOpacity(0.08);
    final borderColor = isDarkMode 
        ? Colors.white.withOpacity(0.2) 
        : Colors.grey.withOpacity(0.2);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.access_time, color: secondaryTextColor, size: 18),
              const SizedBox(width: 8),
              Text(
                'weather.hourly'.tr(),
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: forecast.take(8).length,
              itemBuilder: (context, index) {
                final item = forecast[index];
                final condition = item.weather.isNotEmpty ? item.weather.first : null;
                final iconUrl = condition != null
                    ? ApiConstants.getIconUrl(condition.icon)
                    : '';

                // Parse time
                final dt = DateTime.parse(item.dtTxt);
                final hour = '${dt.hour.toString().padLeft(2, '0')}:00';

                return Container(
                  width: 60,
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: index == 0
                        ? (isDarkMode ? Colors.white.withOpacity(0.2) : Colors.blue.withOpacity(0.1))
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        index == 0 ? 'Now' : hour,
                        style: TextStyle(
                          color: secondaryTextColor,
                          fontSize: 11,
                          fontWeight: index == 0 ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                      if (iconUrl.isNotEmpty)
                        CachedNetworkImage(
                          imageUrl: iconUrl,
                          width: 32,
                          height: 32,
                          errorWidget: (_, __, ___) => Icon(
                            Icons.cloud,
                            color: textColor,
                            size: 24,
                          ),
                        )
                      else
                        Icon(Icons.cloud, color: textColor, size: 24),
                      Text(
                        '${item.main.temp.round()}°',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
