import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class GradientButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final Gradient gradient;
  final bool isLoading;  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double fontSize;
  final FontWeight fontWeight;

  const GradientButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.gradient = AppColors.primaryGradient,
    this.isLoading = false,
    this.padding = const EdgeInsets.symmetric(vertical: 18),
    this.borderRadius = 28,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w700,
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final canInteract = widget.onPressed != null && !widget.isLoading;

    // Define a escala baseada no estado, sem mexer no layout interno
    double scale = 1.0;
    if (_isPressed) {
      scale = 0.95; // Encolhe ao clicar
    } else if (_isHovered) {
      scale = 1.03; // Aumenta no hover
    }

    return MouseRegion(
      cursor: canInteract ? SystemMouseCursors.click : MouseCursor.defer,
      onEnter: canInteract ? (_) => setState(() => _isHovered = true) : null,
      onExit: canInteract ? (_) => setState(() => _isHovered = false) : null,
      child: GestureDetector(
        onTapDown: canInteract ? (_) => setState(() => _isPressed = true) : null,
        onTapUp: canInteract ? (_) => setState(() => _isPressed = false) : null,
        onTapCancel: canInteract ? () => setState(() => _isPressed = false) : null,
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              gradient: widget.gradient,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              boxShadow: [
                BoxShadow(
                  color: (_isPressed || _isHovered)
                      ? const Color(0x667B61FF)
                      : const Color(0x3D7B61FF),
                  blurRadius: _isPressed ? 12 : (_isHovered ? 30 : 24),
                  offset: Offset(0, _isPressed ? 6 : 12),
                ),
              ],
            ),
            // ClipRRect para garantir que o overlay de brilho siga o arredondamento original
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              child: Stack(
                alignment: Alignment.center, // Garante alinhamento central
                children: [
                  // Botão original com suas propriedades exatas
                  SizedBox(
                    width: double.infinity, // Garante que ocupe o espaço original
                    child: ElevatedButton(
                      onPressed: widget.isLoading ? null : widget.onPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        disabledBackgroundColor: Colors.transparent,
                        padding: widget.padding, // Padding original
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(widget.borderRadius),
                        ),
                      ),
                      child: widget.isLoading
                          ? const Center(
                        child: SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.4,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      )
                          : Text(
                        widget.label,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: widget.fontSize, // Fonte original
                          fontWeight: widget.fontWeight, // Peso original
                        ),
                      ),
                    ),
                  ),
                  // Overlay apenas para feedback visual de luz, sem alterar o botão
                  if (_isPressed || _isHovered)
                    Positioned.fill(
                      child: IgnorePointer(
                        child: Container(
                          color: _isPressed
                              ? Colors.black.withOpacity(0.08)
                              : Colors.white.withOpacity(0.1),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}