



import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ChatMessageCard extends StatelessWidget {
  const ChatMessageCard({
    super.key, required this.index, required this.messageItem,
  });
  final Message messageItem;
  
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: index % 2 == 0
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        index % 2 == 0
            ? IconButton(
                onPressed: () {},
                icon: const Icon(Iconsax.message_edit))
            : const SizedBox(),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(index % 2 == 0 ? 16 : 0),
              bottomRight: const Radius.circular(16),
              bottomLeft: const Radius.circular(16),
              topRight:
                  Radius.circular(index % 2 == 0 ? 0 : 16),
            ),
          ),
          color: index % 2 == 0
              ? Theme.of(context).colorScheme.surface
              : Theme.of(context).colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width / 2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    messageItem.msg!,),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '5:30 AM',
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      index % 2 == 0
                          ? const Icon(Iconsax.tick_circle,
                              color: Colors.grey)
                          : const SizedBox(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
