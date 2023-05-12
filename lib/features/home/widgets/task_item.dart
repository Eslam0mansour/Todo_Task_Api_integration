import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {

  const TaskItem({Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey[300],
            child: const Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Task Title',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Task Description',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '01:30 PM',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w300),
              ),
              const SizedBox(
                height: 10,
              ),
              CircleAvatar(
                radius: 15,
                backgroundColor: Colors.grey[300],
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
