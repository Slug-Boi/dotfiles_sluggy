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
      pycurl
      pycairo
      gurobipy
      
      # Pretty stuff
      halo

      # Database
      #mysql-connector


      # Testing
      pytest
      autopep8
      pycodestyle
    ];
in {
  home.packages = with pkgs; [
    # poetry
    maturin
    uv

    ((python3.withPackages python-packages).override (args: {ignoreCollisions = true;}))
    #manim
  ];
}
