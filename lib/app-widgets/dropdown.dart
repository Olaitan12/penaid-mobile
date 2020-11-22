import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppDropdown extends StatefulWidget {
  dynamic value;
  final List list;
  final String valueKey;
  final String textKey;
  final String placeholder;
  final Function(dynamic value) onChanged;
  final Widget icon;
  AppDropdown(
      {@required this.list,
      @required this.value,
      @required this.placeholder,
      @required this.onChanged,
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
        child: DropdownButton<dynamic>(
          hint: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(widget.placeholder)),
          isExpanded: true,
          value: widget.value,
          items: widget.list
              .map((item) {
                return DropdownMenuItem(
                  value: widget.valueKey == null ? item : item[widget.valueKey],
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: widget.textKey == null
                        ? Text(item)
                        : Text(item[widget.textKey]),
                  ),
                );
              })
              .where((e) => e != null)
              .toList(),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
