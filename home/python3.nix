{pkgs, ...}: let
  python-packages = ps:
    with ps; [
      # Common
      build
      wheel

      # Machine learning packages
      numpy
      scipy
      scikit-learn
      scikit-image
      pandas
      matplotlib
      seaborn
      numba
      tqdm
      click
      qgrid
      torch
      torchvision
      opencv4
      imutils
      jupyterlab
      ipywidgets

      # ml-slide-splitter
      pypdf
      pdf2image
      pillow

      # Database
      mysql-connector

      # Testing
      pytest
      autopep8
      pycodestyle

      # eduroam
      dbus-python

      # Hacking
      dnspython

      # Excel
      openpyxl
    ];
in {
  home.packages = with pkgs; [
    poetry
    poppler_utils

    ((python3.withPackages python-packages).override (args: {ignoreCollisions = true;}))
  ];
}
