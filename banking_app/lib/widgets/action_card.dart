
import 'package:flutter/material.dart';

class ActionCard extends StatelessWidget {

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return Material(

      color: Colors.transparent,

      child: InkWell(

        onTap: onTap,

        borderRadius:
            BorderRadius.circular(24),

        child: Container(

          decoration: BoxDecoration(

            color: Colors.white,

            borderRadius:
                BorderRadius.circular(24),

            boxShadow: [

              BoxShadow(
                color:
                    Colors.black.withOpacity(
                        0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),

child: Column(

  mainAxisSize: MainAxisSize.min,

  mainAxisAlignment:
      MainAxisAlignment.center,

  children: [

    Container(

      padding:
          const EdgeInsets.all(12),

      decoration: BoxDecoration(

        color:
            Colors.blue.withOpacity(0.1),

        shape: BoxShape.circle,
      ),

      child: Icon(
        icon,
        color: Colors.blue,
        size: 30,
      ),
    ),

    const SizedBox(height: 10),

    Text(

      title,

      textAlign: TextAlign.center,

      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    ),
  ],
),
        ),
      ),
    );
  }
}