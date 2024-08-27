import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class GroupEditScreen extends StatefulWidget {
  const GroupEditScreen({super.key});

  @override
  State<GroupEditScreen> createState() => _GroupEditScreenState();
}

class _GroupEditScreenState extends State<GroupEditScreen> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    
    super.initState();
    controller.text = 'Group Name';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Edit'),
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
                  'Add Members',
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
                      title: const Text('Name'),
                      value: true,
                      onChanged: (value) {}),
                  CheckboxListTile(
                      checkboxShape: const CircleBorder(),
                      title: const Text('Name'),
                      value: false,
                      onChanged: (value) {}),
                  CheckboxListTile(
                      checkboxShape: const CircleBorder(),
                      title: const Text('Name'),
                      value: true,
                      onChanged: (value) {}),
                  CheckboxListTile(
                      checkboxShape: const CircleBorder(),
                      title: const Text('Name'),
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
