import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../bloc/template_bloc.dart';
import 'new_template_button.dart';

class TemplateList extends StatelessWidget {
  const TemplateList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      child: SizedBox(
        width: 700,
        height: 400,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 32,
          ),
          child: BlocBuilder<TemplateBloc, TemplateState>(
            builder: (context, state) {
              if (state is TemplateLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is TemplateFetched) {
                final namesList = state.templateNames;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        spacing: 15,
                        children: [
                          Spacer(),
                          Text(
                            context.tr('templatesPage.emptyTemplateList'),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Spacer(),
                          if (!isMobile) NewTemplateButton()
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Expanded(
                      child: ListView.builder(
                        itemCount: namesList.length,
                        itemBuilder: (context, index) {
                          final templateName = namesList[index];
                          return ListTile(
                            title: Text(templateName),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }

              return Center(
                child: Text('État inconnu'),
              );
            },
          ),
        ),
      ),
    );
  }
}
