// ignore_for_file: prefer_const_constructors, use_super_parameters, library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;

class DateConvert extends StatefulWidget {
  const DateConvert({Key? key}) : super(key: key);

  @override
  _DateConvertState createState() => _DateConvertState();
}

class _DateConvertState extends State<DateConvert> {
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;
  final TextEditingController _adController = TextEditingController();
  final TextEditingController _bsController = TextEditingController();
  final TextEditingController _adResultController = TextEditingController();
  final TextEditingController _bsResultController = TextEditingController();

  picker.NepaliDateTime? _convertedBsDate;
  DateTime? _convertedAdDate;

  Future<void> _selectAdDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _convertedAdDate) {
      setState(() {
        _adController.text = picked.toString().substring(0, 10);
        _convertAdToBs(picked);
      });
    }
  }

  Future<void> _selectBsDate(BuildContext context) async {
    final picker.NepaliDateTime? picked = await picker.showMaterialDatePicker(
      context: context,
      initialDate: picker.NepaliDateTime.now(),
      firstDate: picker.NepaliDateTime(2000),
      lastDate: picker.NepaliDateTime.now(),
    );
    if (picked != null && picked != _convertedBsDate) {
      setState(() {
        _bsController.text = picked.toIso8601String().substring(0, 10);
        _convertBsToAd(picked);
      });
    }
  }

  void _convertAdToBs(DateTime adDate) {
    setState(() {
      _convertedBsDate = picker.NepaliDateTime.fromDateTime(adDate);
      _bsResultController.text =
          _convertedBsDate!.toIso8601String().substring(0, 10);
    });
  }

  void _convertBsToAd(picker.NepaliDateTime bsDate) {
    setState(() {
      _convertedAdDate = bsDate.toDateTime();
      _adResultController.text =
          _convertedAdDate!.toIso8601String().substring(0, 10);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Date Converter')),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AD to BS conversion
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: Text(
                'Selcet AD Date',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13 * (screenWidth / 360),
                    color: Colors.grey.shade700),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: Container(
                height: screenHeight * 0.07,
                decoration: BoxDecoration(
                    border: Border.all(width: 0.8),
                    borderRadius: BorderRadius.circular(screenWidth * 0.01)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.04),
                      child: Text(
                        _bsController.text.isEmpty
                            ? 'Select Date *'
                            : _adController.text,
                        style: TextStyle(
                          fontSize: 15 * (screenWidth / 360),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_month),
                      onPressed: () => _selectAdDate(context),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: Text(
                'Converted AD to BS Date',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13 * (screenWidth / 360),
                    color: Colors.grey.shade700),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: TextField(
                controller: _bsResultController,
                readOnly: true,
                enabled: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Divider(height: 40),
            // BS to AD conversion
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: Text(
                'Selcet BS Date',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13 * (screenWidth / 360),
                    color: Colors.grey.shade700),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: Container(
                height: screenHeight * 0.07,
                decoration: BoxDecoration(
                    border: Border.all(width: 0.8),
                    borderRadius: BorderRadius.circular(screenWidth * 0.01)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.04),
                      child: Text(
                        _bsController.text.isEmpty
                            ? 'Select Date *'
                            : _bsController.text,
                        style: TextStyle(
                          fontSize: 15 * (screenWidth / 360),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_month),
                      onPressed: () => _selectBsDate(context),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: Text(
                'Converted BS to AD Date',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13 * (screenWidth / 360),
                    color: Colors.grey.shade700),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: TextField(
                controller: _adResultController,
                readOnly: true,
                enabled: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _adController.dispose();
    _bsController.dispose();
    _adResultController.dispose();
    _bsResultController.dispose();
    super.dispose();
  }
}
