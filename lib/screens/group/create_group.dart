import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {}, label: const Text('Done'), icon: const Icon(Iconsax.tick_circle)),
      appBar: AppBar(
        title: const Text('Create Group'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const CircleAvatar(
                      radius: 40,
                    ),
                    Positioned(
                      bottom: -0,
                      right: -0,
                      left: 0,
                      top: 0,
                      child: Center(
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Iconsax.gallery_add),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: CustomTextField(
                        label: 'Group Name',
                        prefixIcon: Iconsax.user,
                        controller: controller,
                        obscureText: false,
                        isPassword: false))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 1,
              color: Colors.grey.shade300,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Members',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const Spacer(),
                Text(
                  '0',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                children: [
                  CheckboxListTile(
                      checkboxShape: const CircleBorder(),
                      title: const Text('Add Members'),
                      value: true,
                      onChanged: (value) {}),
                  CheckboxListTile(
                      checkboxShape: const CircleBorder(),
                      title: const Text('Add Members'),
                      value: false,
                      onChanged: (value) {}),
                  CheckboxListTile(
                      checkboxShape: const CircleBorder(),
                      title: const Text('Add Members'),
                      value: true,
                      onChanged: (value) {}),
                  CheckboxListTile(
                      checkboxShape: const CircleBorder(),
                      title: const Text('Add Members'),
                      value: false,
                      onChanged: (value) {}),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
