// widgets/note/note_content.dart - Update for Format button

import 'package:flutter/material.dart';
import '../../config/constants/layout.dart';
import 'size_selector.dart';
import 'note_input_area.dart';

/// Main content area with size selector and note input
class NoteContent extends StatelessWidget {
  final String selectedSize;
  final Function(String) onSizeSelected;
  final TextEditingController noteController;
  final FocusNode? focusNode;
  
  // Action callbacks
  final VoidCallback? onDelete;
  final VoidCallback? onUndo;
  final VoidCallback? onFormat; // Changed from onSave to onFormat
  final VoidCallback? onCamera;
  final VoidCallback? onMic;
  final VoidCallback? onLink;

  const NoteContent({
    super.key,
    required this.selectedSize,
    required this.onSizeSelected,
    required this.noteController,
    this.focusNode,
    this.onDelete,
    this.onUndo,
    this.onFormat, // Changed from onSave to onFormat
    this.onCamera,
    this.onMic,
    this.onLink,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Size selector
        SizeSelector(
          selectedSize: selectedSize,
          onSizeSelected: onSizeSelected,
        ),

        const SizedBox(height: AppLayout.spacingS),

        // Note input area with callbacks passed through
        Expanded(
          child: NoteInputArea(
            controller: noteController,
            focusNode: focusNode,
            onDelete: onDelete,
            onUndo: onUndo,
            onFormat: onFormat, // Changed from onSave to onFormat
            onCamera: onCamera,
            onMic: onMic,
            onLink: onLink,
          ),
        ),

        const SizedBox(height: AppLayout.spacingS),
      ],
    );
  }
}