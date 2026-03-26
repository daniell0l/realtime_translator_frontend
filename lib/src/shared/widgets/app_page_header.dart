import 'package:flutter/material.dart';
import 'package:realtime_translator_frontend/src/core/theme/app_colors.dart';

class AppPageHeader extends StatelessWidget {
  final double scale;
  final String title;
  final String? subtitle;
  final double? backButtonSize;
  final double? subtitleSpacing;
  final double? titleTextHeight;
  final double? subtitleTextHeight;
  final Widget? trailing;
  final bool centerTitle;
  final VoidCallback onBack;

  const AppPageHeader({
    super.key,
    required this.scale,
    required this.title,
    this.subtitle,
    this.backButtonSize,
    this.subtitleSpacing,
    this.titleTextHeight,
    this.subtitleTextHeight,
    this.trailing,
    this.centerTitle = true,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedBackButtonSize = backButtonSize ?? 40 * scale;
    final resolvedSubtitleSpacing = subtitleSpacing ?? 4 * scale;
    final resolvedTitleTextHeight = titleTextHeight ?? 1.0;
    final resolvedSubtitleTextHeight = subtitleTextHeight ?? 1.0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        16 * scale,
        8 * scale,
        16 * scale,
        8 * scale,
      ),
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x33735AF4),
            blurRadius: 24,
            offset: Offset(0, 14),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: subtitle == null ? 56 * scale : 74 * scale,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  borderRadius: BorderRadius.circular(24 * scale),
                  onTap: onBack,
                  child: Ink(
                    width: resolvedBackButtonSize,
                    height: resolvedBackButtonSize,
                    decoration: const BoxDecoration(
                      color: Colors.white24,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              if (trailing != null)
                Align(alignment: Alignment.centerRight, child: trailing!),
              Padding(
                padding: EdgeInsets.only(
                  left: 56 * scale,
                  right: trailing == null ? 56 * scale : 108 * scale,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: centerTitle
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: centerTitle
                          ? TextAlign.center
                          : TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21 * scale,
                        fontWeight: FontWeight.w800,
                        height: resolvedTitleTextHeight,
                      ),
                    ),
                    if (subtitle != null) ...[
                      SizedBox(height: resolvedSubtitleSpacing),
                      Text(
                        subtitle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: centerTitle
                            ? TextAlign.center
                            : TextAlign.left,
                        style: TextStyle(
                          color: const Color(0xE6FFFFFF),
                          fontSize: 13 * scale,
                          fontWeight: FontWeight.w500,
                          height: resolvedSubtitleTextHeight,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
