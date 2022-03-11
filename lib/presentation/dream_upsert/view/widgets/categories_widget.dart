import 'dart:ui';

import 'package:dream_app_bloc/data/dream/dream_themes.dart';
import 'package:dream_app_bloc/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../upsert_dream.dart';

class CategoriesWidget extends StatelessWidget {
  final bool isEditing;
  const CategoriesWidget({Key? key, required this.isEditing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10.0,
        ),
        const Text(
          'Themes:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            shrinkWrap: true,
            itemCount: dreamThemes.length,
            itemBuilder: (context, index) {
              return BlocBuilder<UpsertDreamBloc, UpsertDreamState>(
                builder: (context, state) {
                  final selectedIndex =
                      dreamThemes.indexWhere((e) => e.theme == state.category);
                  return InkWell(
                    onTap: () {
                      context.read<UpsertDreamBloc>().add(UpsertCategoryChanged(
                          category: dreamThemes[index].theme));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 16.0,
                          sigmaY: 16.0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.indigoAccent.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              width: selectedIndex == index ? 2.0 : 1.5,
                              color: selectedIndex == index
                                  ? Colors.black
                                  : Colors.indigoAccent.withOpacity(0.2),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage(
                                  dreamThemes[index].iconPath,
                                ),
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                dreamThemes[index].theme,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.dreams,
                                    fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}
