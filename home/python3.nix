{pkgs, ...}: let
  python-packages = ps:
    with ps; [
      # Common
      build
      wheel

      # Machine learning packages
      numpy

      # ml-slide-splitter
      pypdf
      pdf2image
      pillow
      pytesseract
      
      # Pretty stuff
      halo

      # Database
      mysql-connector

      # Testing
      pytest
      autopep8
      pycodestyle
    ];
in {
  home.packages = with pkgs; [
    poetry
    #poppler_utils

    ((python3.withPackages python-packages).override (args: {ignoreCollisions = true;}))
  ];
}
