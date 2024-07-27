# Changelog

## [0.0.1] - 2024-07-27
### Initial Release
- **Created**: Initial release of the `smart_media_picker_and_viewer` package.
- **Features**:
  - Added `SmartMediaPickerAndViewer` widget for picking and viewing various media types (images, PDFs, etc.).
  - Support for file types including `pdf`, `doc`, `docx`, `xls`, `xlsx`, `png`, `jpg`, and `jpeg`.
  - Customizable upload button with options for color, text style, and icon.
  - Configurable media display settings including size, text style, and icon properties.
- **Customizations**:
  - `isHideUploadButton`: Option to show or hide the upload button.
  - `uploadButtonColor`: Customizable color for the upload button.
  - `uploadButtonTextStyle`: Customizable text style for the upload button.
  - `removeIconColor`: Customizable color for the remove icon.
  - `buttonHeight`, `buttonWidth`, `mediaHeight`, `mediaWidth`: Customizable dimensions for buttons and media items.
  - `maxLinesForName`: Option to control the number of lines for media names.
- **Dependencies**:
  - `file_picker`: ^8.0.6
  - `image_picker`: ^1.1.2
  - `open_file`: ^3.3.2
  - `dotted_border`: ^2.1.0
  - `carousel_slider`: ^4.2.1
  - `flutter_pdfview`: ^1.3.2


