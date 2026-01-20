import 'package:flutter/material.dart';
import '../models/chat_message.dart';  // Assuming this is your existing import

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define colors and styles based on whether it's a user or AI message
    final bool isUser = message.isUserMessage;
    final Color startColor = isUser ? Colors.blue[400]! : Colors.grey[400]!;  // Gradient start
    final Color endColor = isUser ? Colors.blue[600]! : Colors.grey[600]!;    // Gradient end
    final Alignment alignment = isUser ? Alignment.centerRight : Alignment.centerLeft;
    final EdgeInsets margin = isUser
        ? EdgeInsets.only(left: 50, right: 8, top: 4, bottom: 4)  // Push user bubbles right
        : EdgeInsets.only(right: 50, left: 8, top: 4, bottom: 4); // Push AI bubbles left

    return Align(
      alignment: alignment,
      child: Container(
        margin: margin,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Add an avatar icon (robot for AI, user for human)
            if (!isUser) ...[
              CircleAvatar(
                radius: 16,
                backgroundColor: Colors.grey[300],
                child: Icon(Icons.smart_toy, color: Colors.grey[700], size: 18),  // Robot icon for AI
              ),
              SizedBox(width: 8),
            ],
            // The main bubble container
            Flexible(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  // Gradient background for uniqueness
                  gradient: LinearGradient(
                    colors: [startColor, endColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  // Rounded corners with a tail effect (using a custom shape)
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                    bottomLeft: isUser ? Radius.circular(18) : Radius.circular(4),  // Tail on bottom-left for AI
                    bottomRight: isUser ? Radius.circular(4) : Radius.circular(18), // Tail on bottom-right for user
                  ),
                  // Subtle shadow for depth
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                  // Thin border for polish
                  border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Message text with improved styling
                    Text(
                      message.text,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,  // Slightly bolder for readability
                        color: Colors.white,  // White text on gradient for contrast
                      ),
                    ),
                    SizedBox(height: 4),
                    // Timestamp below the text
                    Text(
                      '${message.timestamp.hour}:${message.timestamp.minute.toString().padLeft(2, '0')}',  // e.g., "14:05"
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.7),  // Subtle color
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Add user avatar on the right for user messages
            if (isUser) ...[
              SizedBox(width: 8),
              CircleAvatar(
                radius: 16,
                backgroundColor: Colors.blue[300],
                child: Icon(Icons.person, color: Colors.white, size: 18),  // User icon
              ),
            ],
          ],
        ),
      ),
    );
  }
}