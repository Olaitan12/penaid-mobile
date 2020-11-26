import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppDropdown extends StatefulWidget {
  final String value;
  final List<Map<String, String>> listOfMap;
  final List<String> listOfString;
  final String valueKey;
  final String textKey;
  final String placeholder;
  final void Function(dynamic value) onChanged;
  final Widget icon;
  AppDropdown(
      {
      // @required this.list,
      this.value,
      @required this.placeholder,
      @required this.onChanged,
      this.listOfMap,
      this.listOfString,
      this.icon,
      this.textKey,
      this.valueKey});
  _AppDropdown createState() => _AppDropdown();
}

class _AppDropdown extends State<AppDropdown> {
  Widget build(BuildContext context) {
    return widget.icon == null
        ? Align(alignment: Alignment.bottomRight, child: dropDown())
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: widget.icon,
              ),
              dropDown()
            ],
          );
  }

  Widget dropDown() {
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.only(top: 5, bottom: 5),
      width: MediaQuery.of(context).size.width - 139,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        border: Border.all(color: Colors.grey[500]),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(widget.placeholder)),
          isExpanded: true,
          value:
              widget.value != null && widget.value == "" ? null : widget.value,
          items: widget.listOfString != null
              ? widget.listOfString
                  .map<DropdownMenuItem<String>>(
                      (e) => DropdownMenuItem<String>(
                            value: e,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(e),
                            ),
                          ))
                  .toList()
              : widget.listOfMap
                  .map<DropdownMenuItem<String>>(
                      (e) => DropdownMenuItem<String>(
                            value: e[widget.valueKey],
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(e[widget.textKey].toString()),
                            ),
                          ))
                  .toList(),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
