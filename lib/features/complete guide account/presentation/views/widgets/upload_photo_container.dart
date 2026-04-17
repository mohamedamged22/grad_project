import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UploadPhotoContainer extends StatefulWidget {
  final Function(PlatformFile)? onFileSelected;

  const UploadPhotoContainer({super.key, this.onFileSelected});

  @override
  State<UploadPhotoContainer> createState() => _UploadPhotoContainerState();
}

class _UploadPhotoContainerState extends State<UploadPhotoContainer> {
  PlatformFile? selectedFile;

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
        allowMultiple: false,
      );

      if (result != null) {
        PlatformFile file = result.files.first;

        if (file.size > 10 * 1024 * 1024) {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('upload_file_size_error'.tr()),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
          return;
        }

        String extension = file.extension?.toLowerCase() ?? '';
        if (!['jpg', 'jpeg', 'png', 'pdf'].contains(extension)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('upload_file_type_error'.tr()),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
          return;
        }

        setState(() {
          selectedFile = file;
        });

        if (widget.onFileSelected != null) {
          widget.onFileSelected!(file);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('upload_file_success'.tr()),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${'upload_file_error'.tr()}: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = Theme.of(context).cardColor;

    return Container(
      height: 100.h,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: selectedFile != null ? Colors.green : AppColor.primaryColor,
          width: 1.25,
        ),
        borderRadius: BorderRadius.circular(20.r),
        color:
            selectedFile != null
                ? Colors.green.withOpacity(0.05)
                : (isDark ? cardBg : null),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            Icon(
              selectedFile != null ? Icons.check_circle : Icons.cloud_upload,
              color:
                  selectedFile != null ? Colors.green : AppColor.secondaryColor,
              size: 32.w,
            ),

            SizedBox(width: 12.w),

            // النص
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedFile != null
                        ? selectedFile!.name
                        : 'upload_select_photo'.tr(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : AppColor.primaryColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    selectedFile != null
                        ? '${(selectedFile!.size / 1024).toStringAsFixed(2)} KB'
                        : 'upload_file_info'.tr(),
                    style: TextStyle(
                      fontSize: 10.sp,
                      color:
                          isDark
                              ? const Color(0xFF9FB0BD)
                              : Colors.grey.shade600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            SizedBox(width: 8.w),

            GestureDetector(
              onTap: _pickFile,
              child: Container(
                width: 65.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: AppColor.secondaryColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: Text(
                    'upload_button'.tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
