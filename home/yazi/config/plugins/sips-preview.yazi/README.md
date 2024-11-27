# sips-preview.yazi
**sips-preview.yazi** is a [Yazi](https://yazi-rs.github.io/) plugin that enables quick previews of images on macOS. It focuses on PSD (Photoshop) files but also supports other image formats listed by `sips --formats`, utilizing the `sips` command-line tool.

## Features
- **Quick Image Previews**: Instantly preview various image formats directly within Yazi.
- **PSD Support**: Seamlessly preview Photoshop (PSD) files without the need for additional software.
- **macOS Integration**: Leverages the native `sips` utility for efficient image processing.

## Requirements
- [Yazi](https://yazi-rs.github.io/) v0.3 or higher.
- Operating System: macOS
- Ensure the `sips` command-line tool is available on your system (pre-installed on macOS).

## Installation
```sh
ya pack -a andreas-timm/sips-preview
```

Restart Yazi to load the plugin.

## Configuration
Add the following preloader configuration to your `yazi.toml` file to enable the plugin for PSD files:
```toml
[plugin]
prepend_preloaders = [
    { mime = "image/vnd.adobe.photoshop", run = "sips-preview" }
]
prepend_previewers = [
    { mime = "image/vnd.adobe.photoshop", run = "sips-preview" },
]
```

## License
This plugin is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## Acknowledgments
Special thanks to the Yazi community for their support and to Apple for providing the `sips` tool.
