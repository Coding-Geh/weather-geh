import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weathergeh_app/core/constants/api_constants.dart';
import 'package:weathergeh_app/models/weather.dart';

class DailyForecastCard extends StatelessWidget {
  final List<List<ForecastItem>> dailyForecast;
  final bool isDarkMode;

  const DailyForecastCard({
    super.key, 
    required this.dailyForecast,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isDarkMode ? Colors.white : Colors.grey[800]!;
    final secondaryTextColor = isDarkMode ? Colors.white.withOpacity(0.7) : Colors.grey[600]!;
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
              Icon(Icons.calendar_today, color: secondaryTextColor, size: 18),
              const SizedBox(width: 8),
              Text(
                'weather.forecast'.tr(),
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...dailyForecast.take(5).map((day) => _DayRow(
            dayItems: day, 
            isDarkMode: isDarkMode,
            textColor: textColor,
          )),
        ],
      ),
    );
  }
}

class _DayRow extends StatelessWidget {
  final List<ForecastItem> dayItems;
  final bool isDarkMode;
  final Color textColor;

  const _DayRow({
    required this.dayItems,
    required this.isDarkMode,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    if (dayItems.isEmpty) return const SizedBox.shrink();

    // Get day's data
    final firstItem = dayItems.first;
    final dt = DateTime.parse(firstItem.dtTxt);
    final dayName = _getDayName(dt);

    // Calculate min/max temp for the day
    final temps = dayItems.map((e) => e.main.temp).toList();
    final minTemp = temps.reduce((a, b) => a < b ? a : b).round();
    final maxTemp = temps.reduce((a, b) => a > b ? a : b).round();

    // Get most common condition
    final condition = firstItem.weather.isNotEmpty ? firstItem.weather.first : null;
    final iconUrl = condition != null
        ? ApiConstants.getIconUrl(condition.icon)
        : '';

    final isToday = dt.day == DateTime.now().day;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: isToday 
            ? (isDarkMode ? Colors.white.withOpacity(0.1) : Colors.blue.withOpacity(0.08))
            : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // Day name
          SizedBox(
            width: 50,
            child: Text(
              dayName,
              style: TextStyle(
                color: textColor,
                fontSize: 13,
                fontWeight: isToday ? FontWeight.w600 : FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Icon
          SizedBox(
            width: 36,
            height: 36,
            child: iconUrl.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: iconUrl,
                    width: 36,
                    height: 36,
                    errorWidget: (_, __, ___) => Icon(
                      Icons.cloud,
                      color: textColor,
                      size: 24,
                    ),
                  )
                : Icon(Icons.cloud, color: textColor, size: 24),
          ),

          const Spacer(),

          // Temp range bar
          _TempBar(min: minTemp, max: maxTemp, textColor: textColor),
        ],
      ),
    );
  }

  String _getDayName(DateTime dt) {
    final now = DateTime.now();
    if (dt.day == now.day) return 'days.today'.tr();
    
    final weekdays = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'];
    return 'days.${weekdays[dt.weekday - 1]}'.tr();
  }
}

class _TempBar extends StatelessWidget {
  final int min;
  final int max;
  final Color textColor;

  const _TempBar({
    required this.min, 
    required this.max,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Min temp
        SizedBox(
          width: 35,
          child: Text(
            '$min°',
            style: TextStyle(
              color: Colors.blue.shade500,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.right,
          ),
        ),
        const SizedBox(width: 8),
        // Gradient bar
        Container(
          width: 60,
          height: 6,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade400,
                Colors.green.shade400,
                Colors.orange.shade400,
              ],
            ),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 8),
        // Max temp
        SizedBox(
          width: 35,
          child: Text(
            '$max°',
            style: TextStyle(
              color: Colors.orange.shade500,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
