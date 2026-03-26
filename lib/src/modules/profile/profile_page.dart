import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:realtime_translator_frontend/src/core/theme/app_colors.dart';
import 'package:realtime_translator_frontend/src/shared/widgets/app_background.dart';
import 'package:realtime_translator_frontend/src/shared/widgets/app_card.dart';
import 'package:realtime_translator_frontend/src/shared/widgets/app_page_header.dart';
import 'package:realtime_translator_frontend/src/shared/widgets/gradient_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const double _designWidth = 380;
  static const String _email = 'maria.santos@email.com';

  final ImagePicker _imagePicker = ImagePicker();
  final TextEditingController _nameEditController = TextEditingController();

  String _displayName = 'Maria Santos';
  bool _editingName = false;
  String? _nameError;
  bool _darkTheme = false;
  bool _notificationsEnabled = true;

  File? _avatarImage;
  File? _bannerImage;
  Color _bannerColor = const Color(0xFFF1EEFF);

  final _recentRooms = const [
    ('Equipe mobile', 'ABC-1234'),
    ('Produto e design', 'QWE-9087'),
    ('Familia', 'ZXC-7741'),
  ];

  @override
  void initState() {
    super.initState();
    _nameEditController.text = _displayName;
  }

  @override
  void dispose() {
    _nameEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final layoutWidth = width > 380 ? 380.0 : width;
    final scale = layoutWidth / _designWidth;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: AppBackground(
        child: Column(
          children: [
            AppPageHeader(
              scale: scale,
              title: 'Perfil',
              onBack: () => Navigator.pop(context),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  24 * scale,
                  24 * scale,
                  24 * scale,
                  32 * scale,
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: layoutWidth,
                    child: Column(
                      children: [
                        _buildProfileCard(scale),
                        SizedBox(height: 24 * scale),
                        _buildSettingsCard(scale),
                        SizedBox(height: 24 * scale),
                        _buildRecentRoomsCard(scale),
                        SizedBox(height: 24 * scale),
                        GradientButton(
                          label: 'Sair',
                          padding: EdgeInsets.symmetric(
                            vertical: 16 * scale,
                          ),
                          borderRadius: 18 * scale,
                          fontSize: 18 * scale,
                          fontWeight: FontWeight.w800,
                          onPressed: () =>
                              Navigator.popUntil(context, (route) => route.isFirst),
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
    );
  }

  Widget _buildProfileCard(double scale) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              Container(
                height: 118 * scale,
                decoration: BoxDecoration(
                  color: _bannerImage == null ? _bannerColor : null,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24 * scale),
                    topRight: Radius.circular(24 * scale),
                  ),
                  image: _bannerImage != null
                      ? DecorationImage(
                          image: FileImage(_bannerImage!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
              ),
              SizedBox(height: 64 * scale),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  24 * scale,
                  0,
                  24 * scale,
                  24 * scale,
                ),
                child: Column(
                  children: [
                    _buildNameEditor(scale),
                    SizedBox(height: 6 * scale),
                    Text(
                      _email,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 15 * scale,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 14 * scale,
            left: 14 * scale,
            child: _SmallEditButton(
              scale: scale,
              onTap: _editBanner,
            ),
          ),
          Positioned(
            top: 56 * scale,
            left: 0,
            right: 0,
            child: Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  GestureDetector(
                    onTap: _pickAvatar,
                    child: Container(
                      width: 88 * scale,
                      height: 88 * scale,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x15000000),
                            blurRadius: 18,
                            offset: Offset(0, 10),
                          ),
                        ],
                        image: _avatarImage != null
                            ? DecorationImage(
                                image: FileImage(_avatarImage!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: _avatarImage == null
                          ? Center(
                              child: Text(
                                _initialsFromName(_displayName),
                                style: TextStyle(
                                  color: AppColors.secondary,
                                  fontSize: 28 * scale,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )
                          : null,
                    ),
                  ),
                  Positioned(
                    right: -2,
                    bottom: 8 * scale,
                    child: Container(
                      width: 12 * scale,
                      height: 12 * scale,
                      decoration: BoxDecoration(
                        color: const Color(0xFF19C37D),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                  Positioned(
                    right: -6,
                    bottom: -2,
                    child: _SmallEditButton(
                      scale: scale,
                      onTap: _pickAvatar,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard(double scale) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Configuracoes',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 17 * scale,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(width: 6 * scale),
              Icon(
                Icons.edit_outlined,
                size: 16 * scale,
                color: AppColors.textSecondary,
              ),
            ],
          ),
          SizedBox(height: 18 * scale),
          _ProfileOptionRow(
            scale: scale,
            icon: Icons.dark_mode_outlined,
            iconColor: AppColors.primary,
            iconBackground: const Color(0xFFE9EDFF),
            title: 'Tema escuro',
            trailing: Switch.adaptive(
              value: _darkTheme,
              onChanged: (value) => setState(() => _darkTheme = value),
            ),
          ),
          SizedBox(height: 14 * scale),
          _ProfileOptionRow(
            scale: scale,
            icon: Icons.notifications_none_rounded,
            iconColor: AppColors.secondary,
            iconBackground: const Color(0xFFF2E9FF),
            title: 'Notificacoes',
            trailing: Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textSecondary,
              size: 22 * scale,
            ),
            onTap: () =>
                setState(() => _notificationsEnabled = !_notificationsEnabled),
          ),
          SizedBox(height: 14 * scale),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18 * scale),
              border: Border.all(color: AppColors.textPrimary, width: 1.2),
            ),
            child: _ProfileOptionRow(
              scale: scale,
              icon: Icons.help_outline_rounded,
              iconColor: AppColors.cyan,
              iconBackground: const Color(0xFFE8F9FF),
              title: 'Ajuda e suporte',
              trailing: Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textSecondary,
                size: 22 * scale,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentRoomsCard(double scale) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Salas recentes',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 17 * scale,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 14 * scale),
          for (var i = 0; i < _recentRooms.length; i++) ...[
            Row(
              children: [
                Container(
                  width: 42 * scale,
                  height: 42 * scale,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9EDFF),
                    borderRadius: BorderRadius.circular(14 * scale),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.chat_bubble_outline_rounded,
                    color: AppColors.primary,
                    size: 20 * scale,
                  ),
                ),
                SizedBox(width: 12 * scale),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _recentRooms[i].$1,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 15 * scale,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 2 * scale),
                      Text(
                        _recentRooms[i].$2,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13 * scale,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (i != _recentRooms.length - 1) SizedBox(height: 14 * scale),
          ],
        ],
      ),
    );
  }

  Widget _buildNameEditor(double scale) {
    if (!_editingName) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              _displayName,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18 * scale,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(width: 8 * scale),
          _SmallEditButton(
            scale: scale,
            onTap: _startEditingName,
          ),
        ],
      );
    }

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _nameEditController,
                autofocus: true,
                maxLength: 16,
                decoration: InputDecoration(
                  counterText: '',
                  hintText: 'Digite seu nome ou nick',
                  errorText: null,
                  filled: true,
                  fillColor: const Color(0xFFF8FAFC),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14 * scale,
                    vertical: 12 * scale,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16 * scale),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16 * scale),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16 * scale),
                    borderSide: const BorderSide(
                      color: AppColors.gradientStart,
                      width: 1.4,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8 * scale),
            _InlineActionButton(
              scale: scale,
              icon: Icons.close_rounded,
              onTap: _cancelEditingName,
            ),
            SizedBox(width: 8 * scale),
            _InlineActionButton(
              scale: scale,
              icon: Icons.check_rounded,
              onTap: _saveEditingName,
              highlighted: true,
            ),
          ],
        ),
        if (_nameError != null) ...[
          SizedBox(height: 6 * scale),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              _nameError!,
              style: TextStyle(
                color: AppColors.danger,
                fontSize: 12 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ],
    );
  }

  void _startEditingName() {
    setState(() {
      _editingName = true;
      _nameError = null;
      _nameEditController.text = _displayName;
    });
  }

  void _cancelEditingName() {
    setState(() {
      _editingName = false;
      _nameError = null;
      _nameEditController.text = _displayName;
    });
  }

  void _saveEditingName() {
    final value = _nameEditController.text.trim();

    if (value.length < 4 || value.length > 16) {
      setState(() {
        _nameError = 'Use entre 4 e 16 caracteres.';
      });
      return;
    }

    setState(() {
      _displayName = value;
      _editingName = false;
      _nameError = null;
    });
  }

  Future<void> _pickAvatar() async {
    final file = await _pickImageFile();
    if (file == null) return;
    setState(() => _avatarImage = file);
  }

  Future<void> _editBanner() async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Personalizar banner',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.image_outlined),
                  title: const Text('Escolher imagem'),
                  onTap: () async {
                    Navigator.pop(context);
                    final file = await _pickImageFile();
                    if (file == null) return;
                    setState(() => _bannerImage = file);
                  },
                ),
                const SizedBox(height: 12),
                const Text(
                  'Escolher cor',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    for (final color in const [
                      Color(0xFFF1EEFF),
                      Color(0xFFE8F9FF),
                      Color(0xFFFFEEF3),
                      Color(0xFFFFF3E8),
                      Color(0xFFEAF8EF),
                    ])
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {
                            _bannerImage = null;
                            _bannerColor = color;
                          });
                        },
                        child: Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.border,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<File?> _pickImageFile() async {
    final pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (pickedFile == null) return null;

    return File(pickedFile.path);
  }

  String _initialsFromName(String value) {
    final parts = value.trim().split(RegExp(r'\s+'));

    if (parts.isEmpty || parts.first.isEmpty) {
      return 'MS';
    }

    if (parts.length == 1) {
      return parts.first.substring(0, parts.first.length >= 2 ? 2 : 1).toUpperCase();
    }

    return '${parts.first[0]}${parts[1][0]}'.toUpperCase();
  }
}

class _SmallEditButton extends StatelessWidget {
  final double scale;
  final VoidCallback onTap;

  const _SmallEditButton({
    required this.scale,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        width: 30 * scale,
        height: 30 * scale,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: Icon(
            Icons.edit_outlined,
            color: AppColors.textPrimary,
            size: 16 * scale,
          ),
        ),
      ),
    );
  }
}

class _InlineActionButton extends StatelessWidget {
  final double scale;
  final IconData icon;
  final VoidCallback onTap;
  final bool highlighted;

  const _InlineActionButton({
    required this.scale,
    required this.icon,
    required this.onTap,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        width: 42 * scale,
        height: 42 * scale,
        decoration: BoxDecoration(
          color: highlighted ? AppColors.gradientStart : Colors.white,
          borderRadius: BorderRadius.circular(14 * scale),
          border: highlighted
              ? null
              : Border.all(color: AppColors.border),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14 * scale),
          child: Icon(
            icon,
            color: highlighted ? Colors.white : AppColors.textPrimary,
            size: 20 * scale,
          ),
        ),
      ),
    );
  }
}

class _ProfileOptionRow extends StatelessWidget {
  final double scale;
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String title;
  final Widget trailing;
  final VoidCallback? onTap;

  const _ProfileOptionRow({
    required this.scale,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.title,
    required this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18 * scale),
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 12 * scale,
          vertical: 10 * scale,
        ),
        child: Row(
          children: [
            Container(
              width: 40 * scale,
              height: 40 * scale,
              decoration: BoxDecoration(
                color: iconBackground,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(
                icon,
                color: iconColor,
                size: 20 * scale,
              ),
            ),
            SizedBox(width: 14 * scale),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16 * scale,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}
