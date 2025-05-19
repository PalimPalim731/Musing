// screens/note_entry_screen.dart - Updated for Format button

import 'package:flutter/material.dart';
import '../config/constants/layout.dart';
import '../widgets/category/category_sidebar.dart';
import '../widgets/note/note_content.dart';
import '../widgets/tag/tag_sidebar.dart';
import '../widgets/bottom_bar/bottom_action_bar.dart';
import '../services/note_service.dart';
import '../models/note.dart';

/// Main screen for note entry and management
class NoteEntryScreen extends StatefulWidget {
  const NoteEntryScreen({super.key});

  @override
  State<NoteEntryScreen> createState() => _NoteEntryScreenState();
}

class _NoteEntryScreenState extends State<NoteEntryScreen> {
  // Active selections with default values
  String _selectedCategory = 'Private';
  String _selectedSize = 'Medium';
  
  // Selected tag IDs
  final List<String> _selectedTagIds = [];
  
  // Note service for data operations
  final NoteService _noteService = NoteService();
  
  // Controller for the note text input
  final TextEditingController _noteController = TextEditingController();
  
  // Focus node to manage keyboard focus
  final FocusNode _noteFocusNode = FocusNode();
  
  @override
  void initState() {
    super.initState();
    // Any initialization code can go here
  }
  
  @override
  void dispose() {
    // Clean up controllers and focus nodes when the widget is disposed
    _noteController.dispose();
    _noteFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get responsive values
    final bool isCompact = MediaQuery.of(context).size.width < AppLayout.tabletBreakpoint;
    final double spacing = AppLayout.getSpacing(context);
    
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                // Main content area
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left spacing
                      SizedBox(width: spacing),

                      // Left sidebar with category buttons
                      CategorySidebar(
                        selectedCategory: _selectedCategory,
                        onCategorySelected: _selectCategory,
                        screenHeight: constraints.maxHeight,
                        isCompact: isCompact,
                      ),

                      // Spacing between sidebar and main content
                      SizedBox(width: spacing),

                      // Main note content area with callbacks for actions
                      Expanded(
                        flex: 8,
                        child: NoteContent(
                          selectedSize: _selectedSize,
                          onSizeSelected: _selectSize,
                          noteController: _noteController,
                          focusNode: _noteFocusNode,
                          onDelete: _handleDeleteNote,
                          onUndo: _handleUndoNote,
                          onFormat: _handleFormatNote, // Changed from onSave to onFormat
                          onCamera: _handleCameraPressed,
                          onMic: _handleMicPressed,
                          onLink: _handleLinkPressed,
                        ),
                      ),

                      // Spacing between main content and tag sidebar
                      SizedBox(width: spacing),

                      // Right sidebar with tags
                      TagSidebar(
                        screenHeight: constraints.maxHeight,
                        isCompact: isCompact,
                        onTagSelected: _handleTagSelected,
                      ),

                      // Right spacing
                      SizedBox(width: spacing),
                    ],
                  ),
                ),

                // Bottom action bar
                BottomActionBar(
                  onSettingsPressed: _handleSettingsPressed,
                  onExplorePressed: _handleExplorePressed,
                  onProfilePressed: _handleProfilePressed,
                  isCompact: isCompact,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // State management methods
  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _selectSize(String size) {
    setState(() {
      _selectedSize = size;
    });
  }
  
  void _handleTagSelected(String tagId, bool isSelected) {
    setState(() {
      if (isSelected) {
        if (!_selectedTagIds.contains(tagId)) {
          _selectedTagIds.add(tagId);
        }
      } else {
        _selectedTagIds.remove(tagId);
      }
    });
    debugPrint('Selected tags: $_selectedTagIds');
  }

  // Handler methods for bottom bar actions
  void _handleSettingsPressed() {
    // TODO: Implement settings navigation
    debugPrint('Settings pressed');
  }

  void _handleExplorePressed() {
    // In a real app, save the note first if needed
    // This is now a separate action since we removed the Save button
    _saveCurrentNote();
    
    // TODO: Navigate to explore screen
    debugPrint('Explore pressed');
  }

  void _handleProfilePressed() {
    // TODO: Implement profile navigation
    debugPrint('Profile pressed');
  }
  
  // Save the current note - now called directly from _handleExplorePressed
  void _saveCurrentNote() {
    final content = _noteController.text;
    if (content.isEmpty) return;
    
    // Call the note service to save the note
    _noteService.addNote(
      content: content,
      category: _selectedCategory,
      size: _selectedSize,
      tagIds: List<String>.from(_selectedTagIds),
    ).then((note) {
      debugPrint('Note saved: ${note.id}');
      
      // Show confirmation to the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Note saved'),
          duration: Duration(seconds: 2),
        ),
      );
      
      // Clear the note input
      _noteController.clear();
      
      // Reset selected tags
      setState(() {
        _selectedTagIds.clear();
      });
    });
  }
  
  // Centralized note action handlers
  void _handleDeleteNote() {
    if (_noteController.text.isEmpty) return;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete note?'),
        content: const Text('Are you sure you want to delete this note?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () {
              _noteController.clear();
              Navigator.of(context).pop();
              
              // Reset selected tags
              setState(() {
                _selectedTagIds.clear();
              });
            },
            child: const Text('DELETE'),
          ),
        ],
      ),
    );
  }
  
  void _handleUndoNote() {
    // In a real implementation, you would track changes
    // and implement an undo stack
    
    // For now just log the action
    debugPrint('Undo pressed');
  }
  
  // New handler for Format button
  void _handleFormatNote() {
    // This is a placeholder for future formatting functionality
    debugPrint('Format pressed - Feature to be implemented later');
    
    // Sample implementation - show a snackbar to indicate the feature is coming
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Text formatting options coming soon!'),
        duration: Duration(seconds: 2),
      ),
    );
    
    // In a real implementation, this might:
    // - Show a formatting toolbar
    // - Display a dialog with formatting options
    // - Toggle between different text styles
  }
  
  void _handleCameraPressed() {
    // In a real implementation, you would:
    // - Request camera permissions if needed
    // - Launch camera interface
    // - Handle the captured image
    
    debugPrint('Camera pressed');
  }
  
  void _handleMicPressed() {
    // In a real implementation, you would:
    // - Request microphone permissions if needed
    // - Start voice recording
    // - Handle the recorded audio
    
    debugPrint('Mic pressed');
  }
  
  void _handleLinkPressed() {
    // In a real implementation, you would:
    // - Show a dialog to enter a URL
    // - Validate and attach the link
    
    debugPrint('Link pressed');
  }
}