// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/rectangle_network_image.dart';

class ImagePickerField extends StatefulWidget {
  final String name;
  final double radius;
  final String? initialValue;
  final String? Function(String?)? validator;

  const ImagePickerField({
    super.key,
    required this.name,
    this.radius = 100,
    this.initialValue,
    this.validator,
  });

  @override
  State<ImagePickerField> createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends State<ImagePickerField> {
  final _imagePicker = ImagePicker();
  final _imageCropper = ImageCropper();

  Future<void> _pickImage(FormFieldState<String> field) async {
    try {
      final image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 512,
        maxWidth: 512,
        imageQuality: 50,
      );

      if (image != null) {
        final croppedImage = await _imageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          maxHeight: 512,
          maxWidth: 512,
          uiSettings: [
            WebUiSettings(
              context: context,
              enableZoom: true,
              showZoomer: false,
              boundary:
                  CroppieBoundary(width: 250.r.toInt(), height: 250.r.toInt()),
              viewPort:
                  CroppieViewPort(width: 250.r.toInt(), height: 250.r.toInt()),
            ),
          ],
        );

        if (croppedImage != null) {
          field.didChange(croppedImage.path);
        }
      }
    } on PlatformException catch (e, s) {
      logger.error(e, s);

      if (e.code == 'photo_access_denied') {
        context.showErrorSnackBar('Mohon izinkan akses galeri di pengaturan.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FormBuilderField<String>(
      name: widget.name,
      validator: widget.validator,
      initialValue: widget.initialValue,
      builder: (field) {
        if (field.value != null) {
          return InkWell(
            onTap: () => _pickImage(field),
            child: field.value!.contains('http')
                ? RectangleNetworkImage(
                    url: field.value!,
                    width: widget.radius * 2,
                    height: widget.radius * 2,
                    fit: BoxFit.fitHeight,
                    borderRadius: 10.r,
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.file(
                      File(field.value!),
                      width: widget.radius * 2,
                      height: widget.radius * 2,
                    ),
                  ),
          );
        }

        return Column(
          children: [
            CircleAvatar(
              radius: widget.radius,
              child: IconButton(
                onPressed: () => _pickImage(field),
                icon: const FaIcon(FontAwesomeIcons.image),
                iconSize: widget.radius * 0.8,
              ),
            ),
            if (field.hasError)
              Padding(
                padding: EdgeInsets.only(top: 5.h),
                child: appText.fieldError(
                  field.errorText!,
                  color: theme.colorScheme.error,
                ),
              ),
          ],
        );
      },
    );
  }
}
