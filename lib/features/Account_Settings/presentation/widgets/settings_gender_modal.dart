import 'package:flutter/material.dart';
import 'settings_btn_bottom_sheet.dart';
import '../../data/data_source/api_basic_settings_data.dart';
import '../../../generic_widgets/snackbar.dart';

/// A widget that displays a bottom sheet with options to select the gender.
///
/// It uses a [BottomModalBtn] that when pressed, displays the bottom sheet as well as update
/// after a selected value is recorded.
class SelectGender extends StatefulWidget {
  /// Creates a select gender widget.
  SelectGender({Key? key, required this.basicData}) : super(key: key);

  /// User basic settings data
  final Map<String, dynamic> basicData;

  /// List of available genders.
  final List<String> genders = [
    "Male",
    "Female",
  ];

  @override
  State<SelectGender> createState() => _SelectGenderState();
}

/// [SelectGender] state.
class _SelectGenderState extends State<SelectGender> {
  /// Represents the selected gender.
  String? _selectedGender = "";

  /// Represents the temporary selected gender.
  String? _tempSelectedGender = "";

  /// Holds the fetched data related to user information.
  late Map<String, dynamic> data;

  /// Represents the result of the API update call.
  int result = 1;

  @override
  void initState() {
    super.initState();
    data = widget.basicData;
    _selectedGender = data["gender"] ?? "";
  }

  /// Displays the Gender bottom sheet.
  ///
  /// The option isn't updated until the 'Done' Button is pressed.
  void setGenderModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                // This is the small bar that appears at the top of the bottom sheet
                height: 4,
                width: 50,
                margin: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Gender',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(
                                  Colors.grey.withOpacity(0.5)),
                            ),
                            child: Text(
                              'Done',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 4, 75, 133),
                              ),
                            ),
                            onPressed: () async {
                              var oldGender = _tempSelectedGender;
                              data["gender"] = _tempSelectedGender;
                              var result =
                                  await updateBasicData(updatedData: data);
                              if (result != 0) {
                                setState(() {
                                  _selectedGender = data["gender"];
                                });
                                CustomSnackbar(content: "Gender Saved!")
                                    .show(context);
                              } else {
                                data["gender"] = oldGender;
                                CustomSnackbar(content: "Couldn't Save Gender")
                                    .show(context);
                              }
                              Navigator.pop(context);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        "This information may be used to improve your recommendations and ads.",
                        style: TextStyle(
                          fontSize: 15,
                          color: const Color.fromARGB(255, 109, 109, 109),
                          height: 1.25,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  RadioListTile<String>(
                    dense: true,
                    title: Transform.translate(
                      offset: const Offset(-12, 0),
                      child: Text(
                        widget.genders[0],
                        style: TextStyle(
                          fontSize: 17.5,
                        ),
                      ),
                    ),
                    contentPadding: EdgeInsets.zero,
                    activeColor: MaterialStateColor.resolveWith(
                        (states) => Colors.black),
                    value: widget.genders[0],
                    groupValue: _tempSelectedGender,
                    onChanged: (value) {
                      setModalState(() {
                        _tempSelectedGender = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    dense: true,
                    title: Transform.translate(
                      offset: const Offset(-12, 0),
                      child: Text(
                        widget.genders[1],
                        style: TextStyle(
                          fontSize: 17.5,
                        ),
                      ),
                    ),
                    contentPadding: EdgeInsets.zero,
                    activeColor: MaterialStateColor.resolveWith(
                        (states) => Colors.black),
                    value: widget.genders[1],
                    groupValue: _tempSelectedGender,
                    onChanged: (value) {
                      setModalState(() {
                        _tempSelectedGender = value;
                      });
                    },
                  ),
                ],
              ),
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BottomModalBtn(
        iconData: Icons.person_outline,
        mainText: "Gender",
        selection: _selectedGender,
        onPressed: () {
          _tempSelectedGender = _selectedGender;
          setGenderModal();
        },
      );
    });
  }
}
