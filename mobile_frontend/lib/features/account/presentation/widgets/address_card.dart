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
              : const SizedBox(),
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
                      widget.address.name,
                      style: Fonts.titleBold(),
                    ),
                    Text(
                      widget.address.street,
                      style: Fonts.paragraphRegular(size: 12),
                    ),
                    Text(
                      '${widget.address.city}, ${widget.address.country} ${widget.address.zipCode}',
                      style: Fonts.paragraphRegular(size: 12),
                    ),
                    Text(
                      widget.address.phone,
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
              : const SizedBox(),
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
                          border: const OutlineInputBorder(
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
                          widget.onChanged(
                            widget.address.copyWith(name: newValue),
                          );
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
                          border: const OutlineInputBorder(
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
                          widget.onChanged(
                            widget.address.copyWith(street: newValue),
                          );
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
                                border: const OutlineInputBorder(
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
                                widget.onChanged(
                                  widget.address.copyWith(city: newValue),
                                );
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
                                border: const OutlineInputBorder(
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
                                widget.onChanged(
                                  widget.address.copyWith(zipCode: newValue),
                                );
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
                              widget.onChanged(
                                widget.address.copyWith(
                                  country: selectedCountry.name,
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          color: AppColors.backgroundSecondary,
                          padding: const EdgeInsets.all(10),
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
                                    widget.address.country,
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
                          border: const OutlineInputBorder(
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
                          widget.onChanged(
                            widget.address.copyWith(phone: newValue),
                          );
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
                                contentPadding: EdgeInsets.zero,
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
                                trackOutlineColor:
                                    WidgetStateColor.transparent,
                                onChanged: (val) {
                                  widget.onChanged(
                                    widget.address.copyWith(isDefault: val),
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
              : const SizedBox(),
        ],
      ),
    );
  }
}
