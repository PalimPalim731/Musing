// widgets/tag/tag_sidebar.dart

import 'package:flutter/material.dart';
import '../../config/constants/layout.dart';
import '../../models/tag.dart';
import 'tag_item.dart';

/// Right sidebar with tags
class TagSidebar extends StatelessWidget {
  final double screenHeight;
  final bool isCompact;
  final Function(String, bool)? onTagSelected;

  const TagSidebar({
    super.key,
    required this.screenHeight,
    this.isCompact = false,
    this.onTagSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the exact offsets to align with note content area
    final topOffset = AppLayout.spacingS + AppLayout.selectorHeight + AppLayout.spacingS;
    final bottomOffset = AppLayout.spacingS;
    final sidebarWidth = AppLayout.getSidebarWidth(context, isCompact: isCompact);

    // Sample tag data - in a real app this would come from a data source
    final List<TagData> tags = [
      TagData(id: '1', label: 'Work'),
      TagData(id: '2', label: 'Ideas'),
      TagData(id: '3', label: 'Tasks'),
      TagData(id: '4', label: 'Personal'),
      TagData(id: '5', label: 'Travel'),
    ];

    return Container(
      width: sidebarWidth,
      margin: EdgeInsets.only(
        right: isCompact ? AppLayout.spacingS * 0.5 : AppLayout.spacingS,
      ),
      // Use LayoutBuilder to get the exact height constraints
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate available height after accounting for top and bottom offsets
          final availableHeight = constraints.maxHeight - topOffset - bottomOffset;

          // Calculate tag height and spacing for even distribution
          final totalItems = tags.length;
          final totalSpacers = totalItems - 1; // number of spaces between tags

          // Distribute available height between tags and spacers
          final tagHeight = availableHeight / (totalItems + totalSpacers * 0.5);
          final spacerHeight = tagHeight * 0.5; // spacers are half the height of tags

          return Container(
            padding: EdgeInsets.only(top: topOffset, bottom: bottomOffset),
            child: Column(
              children: List.generate(totalItems * 2 - 1, (index) {
                // Even indices are tags, odd indices are spacers
                if (index.isEven) {
                  final tagIndex = index ~/ 2;
                  return TagItem(
                    height: tagHeight,
                    tag: tags[tagIndex],
                    onTap: () => _handleTagTap(tags[tagIndex]),
                    isCompact: isCompact,
                  );
                } else {
                  return SizedBox(height: spacerHeight);
                }
              }),
            ),
          );
        },
      ),
    );
  }
  
  void _handleTagTap(TagData tag) {
    // In a real app, this would toggle the selection state of the tag
    // and update the UI accordingly
    onTagSelected?.call(tag.id, !tag.isSelected);
  }
}