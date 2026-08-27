import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/features/account/domain/entities/address.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class AddressCard extends StatefulWidget {
  final Function(Address updatedAddress) onChanged;

  final Address address;

  const AddressCard(this.address, this.onChanged, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddressCardState();
  }
}

class _AddressCardState extends State<AddressCard> {
  bool isClosed = true;
  late String name;
  late String street;
  late String city;
  late String zipCode;
  late String country;
  late String phone;
  @override
  void initState() {
    name = widget.address.name;
    street = widget.address.street;
    city = widget.address.city;
    zipCode = widget.address.zipCode;
    country = widget.address.country;
    phone = widget.address.phone;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AddressCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.address != oldWidget.address) {
      name = widget.address.name;
      street = widget.address.street;
      city = widget.address.city;
      zipCode = widget.address.zipCode;
      country = widget.address.country;
      phone = widget.address.phone;
    }
  }

  void _notifyChanged() {
    widget.onChanged(
      Address(
        name: name,
        street: street,
        city: city,
        country: country,
        phone: phone,
        zipCode: zipCode,
        id: widget.address.id,
        isDefault: widget.address.isDefault,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.backgroundPrimary,
      child: Column(
        spacing: 7.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (widget.address.isDefault)
              ? Container(
                  color: AppColors.primaryLight,
                  child: Text(
                    'DEFAULT',
                    style: Fonts.label().copyWith(
                      color: AppColors.primaryDark,
                    ),
                  ),
                )
              : SizedBox(),
          Row(
            spacing: 10.w,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                margin: EdgeInsets.only(left: 5.w),
                width: 80.w,
                height: 80.h,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.location_on_outlined,
                  size: 40.r,
                ),
              ),
              Expanded(
                child: Column(
                  spacing: 3.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Fonts.titleBold(),
                    ),
                    Text(
                      street,
                      style: Fonts.paragraphRegular(size: 12),
                    ),
                    Text(
                      '$city, $country $zipCode',
                      style: Fonts.paragraphRegular(size: 12),
                    ),
                    Text(
                      phone,
                      style: Fonts.titleBold(size: 12),
                    ),
                  ],
                ),
              ),
              Transform.rotate(
                //there is no identical up arrow so I'll just make my own
                angle: (!isClosed) ? 3.14159 : 0,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      isClosed = !isClosed;
                    });
                  },
                  icon: Icon(
                    Icons.arrow_drop_down_circle_outlined,
                    color: AppColors.primaryDark,
                    size: 30.r,
                  ),
                ),
              ),
            ],
          ),
          (!isClosed)
              ? Divider(
                  thickness: 1.h,
                )
              : SizedBox(),

          (!isClosed)
              ? Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    spacing: 5.h,
                    children: [
                      TextFormField(
                        initialValue: widget.address.name,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.backgroundSecondary,
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: AppColors.textSecondary,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hint: Text(
                            'Name',
                            style: Fonts.paragraphRegular(),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Cannot be empty';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (newValue) {
                          setState(() {
                            name = newValue;
                          });
                          _notifyChanged();
                        },
                        onSaved: (newValue) {
                          name = newValue ?? name;
                          _notifyChanged();
                        },
                      ),
                      TextFormField(
                        initialValue: widget.address.street,

                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.backgroundSecondary,
                          prefixIcon: Icon(
                            Icons.location_on_outlined,
                            color: AppColors.textSecondary,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hint: Text(
                            'Address',
                            style: Fonts.paragraphRegular(),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Cannot be empty';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (newValue) {
                          setState(() {
                            street = newValue;
                          });
                          _notifyChanged();
                        },
                        onSaved: (newValue) {
                          street = newValue ?? street;
                          _notifyChanged();
                        },
                      ),
                      Row(
                        spacing: 10.w,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: TextFormField(
                              initialValue: widget.address.city,

                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.backgroundSecondary,
                                prefixIcon: Icon(
                                  Icons.map_outlined,
                                  color: AppColors.textSecondary,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                hint: Text(
                                  'City',
                                  style: Fonts.paragraphRegular(),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Cannot be empty';
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (newValue) {
                                setState(() {
                                  city = newValue;
                                });
                                _notifyChanged();
                              },
                              onSaved: (newValue) {
                                city = newValue ?? city;
                                _notifyChanged();
                              },
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              initialValue: widget.address.zipCode,

                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.backgroundSecondary,
                                prefixIcon: Icon(
                                  Icons.pin_outlined,
                                  color: AppColors.textSecondary,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                hint: Text(
                                  'Zip code',
                                  style: Fonts.paragraphRegular(),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Cannot be empty';
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (newValue) {
                                setState(() {
                                  zipCode = newValue;
                                });
                                _notifyChanged();
                              },
                              onSaved: (newValue) {
                                zipCode = newValue ?? zipCode;
                                _notifyChanged();
                              },
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            showPhoneCode: false,
                            onSelect: (Country selectedCountry) {
                              setState(() {
                                country = selectedCountry.name;
                              });
                              _notifyChanged();
                            },
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          color: AppColors.backgroundSecondary,
                          padding: EdgeInsets.all(10),
                          height: 56.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                spacing: 12.w,
                                children: [
                                  Icon(
                                    Icons.language,
                                    color: AppColors.textSecondary,
                                  ),
                                  Text(
                                    country,
                                    style: Fonts.paragraphRegular(),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                color: AppColors.textSecondary,
                              ),
                            ],
                          ),
                        ),
                      ),
                      TextFormField(
                        initialValue: widget.address.phone,

                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.backgroundSecondary,
                          prefixIcon: Icon(
                            Icons.phone_outlined,
                            color: AppColors.textSecondary,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hint: Text(
                            'Phone number',
                            style: Fonts.paragraphRegular(),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Cannot be empty';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (newValue) {
                          setState(() {
                            phone = newValue;
                          });
                          _notifyChanged();
                        },
                        onSaved: (newValue) {
                          phone = newValue ?? phone;
                          _notifyChanged();
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Transform.scale(
                              alignment: Alignment.centerLeft,
                              scale: 0.8,
                              child: SwitchListTile(
                                value: widget.address.isDefault,
                                title: Text(
                                  'Make default',
                                  style: Fonts.titleBold(),
                                ),
                                contentPadding: EdgeInsets.all(0),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                thumbColor: WidgetStateProperty.all(
                                  Colors.white,
                                ),
                                trackColor: WidgetStateProperty.all(
                                  (widget.address.isDefault)
                                      ? AppColors.primaryDark
                                      : AppColors.textSecondary,
                                ),
                                dense: true,
                                visualDensity: VisualDensity.compact,
                                trackOutlineColor: WidgetStateColor.transparent,
                                onChanged: (val) {
                                  setState(() {
                                    widget.address.isDefault = val;
                                  });
                                  widget.onChanged(
                                    Address(
                                      name: name,
                                      street: street,
                                      city: city,
                                      country: country,
                                      phone: phone,
                                      zipCode: zipCode,
                                      id: widget.address.id,
                                      isDefault: val,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
