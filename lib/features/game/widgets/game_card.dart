import 'dart:math';
import 'package:flutter/material.dart';
import 'package:peek_a_pair/core/models/card_model.dart'; // Import the model
import 'package:peek_a_pair/utils/color_extensions.dart'; // Import our extension

class GameCard extends StatefulWidget {
  final CardModel card;
  final VoidCallback onTap; // Callback for when the card is tapped

  const GameCard({super.key, required this.card, required this.onTap});

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void didUpdateWidget(covariant GameCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Trigger the animation based on the isFlipped state from the notifier
    if (widget.card.isFlipped) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap, // Use the callback passed from the parent
      child: AnimatedBuilder(
        animation: _animation,
        builder: (BuildContext context, Widget? child) {
          final angle = _animation.value * pi;

          final Widget childToShow = angle < pi / 2
              ? _buildCardSide("back") // The card back
              : Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(pi),
                  child: _buildCardSide("front"), // The card front
                );

          return Transform(
            transform: Matrix4.rotationY(angle),
            alignment: Alignment.center,
            child: childToShow,
          );
        },
      ),
    );
  }

  Widget _buildCardSide(String side) {
    // Show the real card image on the front, or a logo on the back
    Widget content;
    if (side == "front") {
      content = Image.asset(widget.card.imagePath, fit: BoxFit.contain);
    } else {
      content = Image.asset(
        'assets/images/card-back.png',
      ); // You'll need a card back image
    }

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.applyOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: content,
    );
  }
}
