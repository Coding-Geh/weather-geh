import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weathergeh_app/models/weather.dart';

class WeatherDetailsCard extends StatelessWidget {
  final CurrentWeather weather;
  final bool isDarkMode;

  const WeatherDetailsCard({
    super.key, 
    required this.weather,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isDarkMode ? Colors.white : Colors.grey[800]!;
    final secondaryTextColor = isDarkMode ? Colors.white.withOpacity(0.6) : Colors.grey[600]!;
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
        children: [
          Row(
            children: [
              Expanded(
                child: _DetailItem(
                  icon: Icons.water_drop,
                  iconColor: Colors.blue.shade400,
                  label: 'weather.humidity'.tr(),
                  value: '${weather.main.humidity}%',
                  textColor: textColor,
                  secondaryTextColor: secondaryTextColor,
                ),
              ),
              Expanded(
                child: _DetailItem(
                  icon: Icons.air,
                  iconColor: Colors.teal.shade400,
                  label: 'weather.wind'.tr(),
                  value: '${weather.wind.speed} m/s',
                  textColor: textColor,
                  secondaryTextColor: secondaryTextColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _DetailItem(
                  icon: Icons.compress,
                  iconColor: Colors.purple.shade400,
                  label: 'weather.pressure'.tr(),
                  value: '${weather.main.pressure} hPa',
                  textColor: textColor,
                  secondaryTextColor: secondaryTextColor,
                ),
              ),
              Expanded(
                child: _DetailItem(
                  icon: Icons.visibility,
                  iconColor: Colors.amber.shade600,
                  label: 'weather.visibility'.tr(),
                  value: '${(weather.visibility / 1000).toStringAsFixed(1)} km',
                  textColor: textColor,
                  secondaryTextColor: secondaryTextColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _DetailItem(
                  icon: Icons.wb_sunny,
                  iconColor: Colors.orange.shade500,
                  label: 'weather.sunrise'.tr(),
                  value: _formatTime(weather.sys.sunrise, weather.timezone ?? 0),
                  textColor: textColor,
                  secondaryTextColor: secondaryTextColor,
                ),
              ),
              Expanded(
                child: _DetailItem(
                  icon: Icons.nightlight_round,
                  iconColor: Colors.indigo.shade400,
                  label: 'weather.sunset'.tr(),
                  value: _formatTime(weather.sys.sunset, weather.timezone ?? 0),
                  textColor: textColor,
                  secondaryTextColor: secondaryTextColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatTime(int timestamp, int timezone) {
    final dt = DateTime.fromMillisecondsSinceEpoch(
      (timestamp + timezone) * 1000,
      isUtc: true,
    );
    return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}

class _DetailItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final Color textColor;
  final Color secondaryTextColor;

  const _DetailItem({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.textColor,
    required this.secondaryTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: secondaryTextColor,
                  fontSize: 11,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                value,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
