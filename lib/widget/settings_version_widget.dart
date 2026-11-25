import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intiface_central/bloc/configuration/intiface_configuration_cubit.dart';
import 'package:intiface_central/bloc/update/update_bloc.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';

class SettingsVersionWidget extends AbstractSettingsSection {
  final IntifaceConfigurationCubit cubit;
  final bool engineIsRunning;

  const SettingsVersionWidget({
    super.key,
    required this.cubit,
    required this.engineIsRunning,
  });

  Widget _buildVersionRow(String label, String version, BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: colorScheme.onSurface)),
          Text(version, style: TextStyle(color: colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Versions and Updates",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            _buildVersionRow("App Version", cubit.currentAppVersion, context),
            _buildVersionRow(
              "Device Config Version",
              cubit.currentDeviceConfigVersion,
              context,
            ),
            const Divider(),
            const Text(
              "This unofficial build adds the Handy stop-at-target setting "
              "(used for game integrations). "
              "Replacing this build with an official Intiface release "
              "removes this setting.",
            ),
            const SizedBox(height: 8),
            Center(
              child: OutlinedButton(
                onPressed: !engineIsRunning
                    ? () => BlocProvider.of<UpdateBloc>(context).add(RunUpdate())
                    : null,
                child: const Text("Check for Device Config Updates"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
