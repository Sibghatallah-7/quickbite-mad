import 'package:flutter/material.dart';
import '../models/food_item.dart';

class AdminFoodCard extends StatelessWidget {
  final FoodItem foodItem;
  final VoidCallback onEdit;
  final ValueChanged<bool> onToggleAvailability;
  final VoidCallback onDelete;

  const AdminFoodCard({
    super.key,
    required this.foodItem,
    required this.onEdit,
    required this.onToggleAvailability,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAlignment.start,
          children: [
            // Emoji or Image Avatar Container
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withOpacity(0.4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  foodItem.emoji,
                  style: const TextStyle(fontSize: 36),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Item Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          foodItem.name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: foodItem.available
                              ? Colors.green.withOpacity(0.15)
                              : Colors.red.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          foodItem.available ? 'Available' : 'Unavailable',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: foodItem.available ? Colors.green[800] : Colors.red[800],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    foodItem.category,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    foodItem.description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey[700],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rs. ${foodItem.price.toStringAsFixed(0)}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit_outlined, size: 20),
                            color: Colors.blue[700],
                            tooltip: 'Edit',
                            onPressed: onEdit,
                          ),
                          Switch(
                            value: foodItem.available,
                            onChanged: onToggleAvailability,
                            activeColor: theme.colorScheme.primary,
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline, size: 20),
                            color: Colors.red[700],
                            tooltip: 'Delete',
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text('Delete Item'),
                                  content: Text('Are you sure you want to delete "${foodItem.name}"?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(ctx),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(ctx);
                                        onDelete();
                                      },
                                      child: const Text('Delete', style: TextStyle(color: Colors.red)),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
