import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/components/basic_widgets/custom_textfield.dart';
import 'package:workout_app/components/popups/customizable_dialog.dart';
import 'package:workout_app/data/settings_data.dart';
import 'package:workout_app/data/theme_provider.dart';

import '../models/constants.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  Color selectedColor = Colors.green;
  bool darkMode = true;
  bool notificationsOn = false;
  bool trendTracking = false;
  bool remoteStorage = false;
  bool localStorage = true;
  @override
  void initState() {
    super.initState();
    final settingsData = Provider.of<SettingsData>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    settingsData.initializeSettingsList();
    darkMode = settingsData.getSwitchValues(keyMap[Keys.theme].toString());
    notificationsOn =
        settingsData.getSwitchValues(keyMap[Keys.notifications].toString());
    trendTracking =
        settingsData.getSwitchValues(keyMap[Keys.progressTracking].toString());

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      themeProvider.toggleTheme(darkMode);
    });
  }

  changeDarkMode(bool newThemeValue) {
    setState(() {
      final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
      final settingsData = Provider.of<SettingsData>(context, listen: false);
      settingsData.editSetting(keyMap[Keys.theme].toString(), newThemeValue);
      themeProvider.toggleTheme(newThemeValue);
      darkMode = newThemeValue;
    });
  }

  changeNotifications(bool newNotifications) {
    setState(() {
      notificationsOn = newNotifications;
      Provider.of<SettingsData>(context, listen: false)
          .editSetting(keyMap[Keys.notifications].toString(), newNotifications);
    });
  }

  delete() {
    Navigator.pop(context);
  }

  void deleteStoredData() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(16),
          backgroundColor: Colors.grey[900],
          content: SingleChildScrollView(
            child: Row(
              children: [
                const Text(
                  'Are you sure?',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(width: 12),
                Flexible(
                  fit: FlexFit.loose,
                  child: MaterialButton(
                    onPressed: () => delete(),
                    color: Colors.red.shade300,
                    child: const Text(
                      'Yes',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Flexible(
                  fit: FlexFit.loose,
                  child: MaterialButton(
                    onPressed: () => Navigator.pop(context),
                    color: Colors.green.shade300,
                    child: const Text(
                      'No',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  changeTrendTracking(bool newTrendTracking) {
    setState(() {
      trendTracking = newTrendTracking;
      Provider.of<SettingsData>(context, listen: false).editSetting(
          keyMap[Keys.progressTracking].toString(), newTrendTracking);
    });
  }

  changeRemoteStorage(bool newRemoteStorage) {
    setState(() {
      remoteStorage = newRemoteStorage;
      //Update data later
    });
  }

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final ageController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();

  void save() {
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String age = ageController.text;
    String weight = weightController.text;
    String height = heightController.text;
    var provider = Provider.of<SettingsData>(context, listen: false);
    provider.editSetting(keyMap[Keys.firstName].toString(), firstName);
    provider.editSetting(keyMap[Keys.lastName].toString(), lastName);
    provider.editSetting(keyMap[Keys.age].toString(), age);
    provider.editSetting(keyMap[Keys.weight].toString(), weight);
    provider.editSetting(keyMap[Keys.height].toString(), height);

    Navigator.pop(context);
    firstNameController.clear();
    lastNameController.clear();
    ageController.clear();
    weightController.clear();
  }

  void openAccountDialog() {
    var provider = Provider.of<SettingsData>(context, listen: false);
    if (provider.getRelevantSetting(keyMap[Keys.firstName].toString()) !=
        null) {
      firstNameController.text = provider
          .getRelevantSetting(keyMap[Keys.firstName].toString())!
          .value
          .toString();
    } else {
      firstNameController.text = '';
    }
    if (provider.getRelevantSetting(keyMap[Keys.lastName].toString()) != null) {
      lastNameController.text = provider
          .getRelevantSetting(keyMap[Keys.lastName].toString())!
          .value
          .toString();
    } else {
      lastNameController.text = '';
    }
    if (provider.getRelevantSetting(keyMap[Keys.age].toString()) != null) {
      ageController.text = provider
          .getRelevantSetting(keyMap[Keys.age].toString())!
          .value
          .toString();
    } else {
      ageController.text = '';
    }
    if (provider.getRelevantSetting(keyMap[Keys.weight].toString()) != null) {
      weightController.text = provider
          .getRelevantSetting(keyMap[Keys.weight].toString())!
          .value
          .toString();
    } else {
      weightController.text = '';
    }
    if (provider.getRelevantSetting(keyMap[Keys.height].toString()) != null) {
      heightController.text = provider
          .getRelevantSetting(keyMap[Keys.height].toString())!
          .value
          .toString();
    } else {
      heightController.text = '';
    }

    showDialog(
        context: context,
        builder: (context) {
          return CustomizableDialog(
            customTextFields: [
              CustomTextField(
                  controller: firstNameController,
                  hintText: 'Enter first name',
                  obscureText: false),
              CustomTextField(
                  controller: lastNameController,
                  hintText: 'Enter last name',
                  obscureText: false),
              CustomTextField(
                  controller: ageController,
                  hintText: 'Enter age',
                  obscureText: false),
              CustomTextField(
                controller: heightController,
                hintText: 'Enter height',
                obscureText: false,
              ),
              CustomTextField(
                  controller: weightController,
                  hintText: 'Enter weight',
                  obscureText: false),
            ],
            onSave: save,
            onCancel: () => Navigator.pop(context),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.account_circle),
          ),
          title: Text(
              '${Provider.of<SettingsData>(context).getRelevantSetting(keyMap[Keys.firstName].toString())!.value} '
              '${Provider.of<SettingsData>(context).getRelevantSetting(keyMap[Keys.lastName].toString())!.value}'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () => openAccountDialog(),
              icon: const Icon(Icons.edit_note),
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              const SizedBox(height: 10),
              const Row(
                children: [
                  Icon(
                    Icons.toggle_off,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 10),
                  Text('Preferences',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
                ],
              ),
              const Divider(height: 20, thickness: 1),
              const SizedBox(height: 10),
              buildSwitch(Icons.light_mode, Icons.dark_mode, 'Theme Dark',
                  darkMode, changeDarkMode),
              buildSwitch(Icons.notifications_off, Icons.notifications_active,
                  'Notifications', notificationsOn, changeNotifications),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Icon(
                    Icons.storage,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 10),
                  Text('Data',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
                ],
              ),
              const Divider(height: 20, thickness: 1),
              const SizedBox(height: 10),
              buildSwitch(Icons.trending_flat, Icons.trending_up,
                  'Progress Tracking', trendTracking, changeTrendTracking),
              buildSwitch(Icons.cloud_off, Icons.cloud_upload,
                  'Remote data storage', remoteStorage, changeRemoteStorage),
              Padding(
                padding: const EdgeInsets.all(22),
                child: TextButton(
                  onPressed: () => deleteStoredData(),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor:
                        Provider.of<ThemeProvider>(context).rejectColor,
                    foregroundColor: Colors.red[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Delete Stored Data',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildSwitch(IconData iconOff, IconData iconOn, String title,
      bool value, Function onChangeMethod) {
    IconData currentIcon = value ? iconOn : iconOff;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(currentIcon),
          Text(title,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Provider.of<ThemeProvider>(context).constantText)),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              activeColor: Colors.blue,
              trackColor: Colors.grey,
              value: value,
              onChanged: (bool newValue) {
                onChangeMethod(newValue);
                currentIcon = value ? iconOn : iconOff;
              },
            ),
          )
        ],
      ),
    );
  }

  Padding buildColorOption(String title,
      {bool isPrimary = false,
      bool isSecondary = false,
      bool isSkip = false,
      bool isRest = false,
      isMapBase = false}) {
    Color color;
    if (isPrimary) {
      color = Provider.of<ThemeProvider>(context).primaryColor;
    } else if (isSecondary) {
      color = Provider.of<ThemeProvider>(context).secondaryColor;
    } else if (isSkip) {
      color = Provider.of<ThemeProvider>(context).skipDayColor;
    } else if (isRest) {
      color = Provider.of<ThemeProvider>(context).restDayColor;
    } else if (isMapBase) {
      color = Provider.of<ThemeProvider>(context).heatMapBaseColor;
    } else {
      color = selectedColor;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => pickColor(context,
                isPrimary: isPrimary,
                isSecondary: isSecondary,
                isSkip: isSkip,
                isRest: isRest,
                isMapBase: isMapBase),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
              width: 40,
              height: 40,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Provider.of<ThemeProvider>(context).constantText,
            ),
          ),
          Transform.scale(
            scale: 0.7,
            child: IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () => pickColor(context,
                  isPrimary: isPrimary,
                  isSecondary: isSecondary,
                  isSkip: isSkip,
                  isRest: isRest,
                  isMapBase: isMapBase),
            ),
          ),
        ],
      ),
    );
  }

  void pickColor(BuildContext context,
          {bool isPrimary = false,
          bool isSecondary = false,
          bool isSkip = false,
          bool isRest = false,
          isMapBase = false}) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Pick color'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildColorPicker(
                  isPrimary: isPrimary,
                  isSecondary: isSecondary,
                  isSkip: isSkip,
                  isRest: isRest,
                  isMapBase: isMapBase),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Select',
                  style: TextStyle(
                    fontSize: 20,
                    color: Provider.of<ThemeProvider>(context).getTextColor(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildColorPicker(
      {bool isPrimary = false,
      bool isSecondary = false,
      bool isSkip = false,
      bool isRest = false,
      isMapBase = false}) {
    Color color;
    if (isPrimary) {
      color = Provider.of<ThemeProvider>(context).primaryColor;
    } else if (isSecondary) {
      color = Provider.of<ThemeProvider>(context).secondaryColor;
    } else if (isSkip) {
      color = Provider.of<ThemeProvider>(context).skipDayColor;
    } else if (isRest) {
      color = Provider.of<ThemeProvider>(context).restDayColor;
    } else if (isMapBase) {
      color = Provider.of<ThemeProvider>(context).heatMapBaseColor;
    } else {
      color = selectedColor;
    }

    return ColorPicker(
      pickerColor: color,
      onColorChanged: (newColor) {
        setState(() {
          if (isPrimary) {
            Provider.of<ThemeProvider>(context, listen: false)
                .setPrimaryColor(newColor);
          } else if (isSecondary) {
            Provider.of<ThemeProvider>(context, listen: false)
                .setSecondaryColor(newColor);
          } else if (isSkip) {
            Provider.of<ThemeProvider>(context, listen: false)
                .setSkipColor(newColor);
          } else if (isRest) {
            Provider.of<ThemeProvider>(context, listen: false)
                .setRestColor(newColor);
          } else if (isMapBase) {
            MaterialColor colorToMaterial = getMaterialColor(newColor);
            Provider.of<ThemeProvider>(context, listen: false)
                .setHeatMapBaseColor(colorToMaterial);
          } else {
            selectedColor = newColor;
          }
        });
      },
      enableAlpha: false,
      labelTypes: const [],
    );
  }
}
