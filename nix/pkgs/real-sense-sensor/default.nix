{ lib
, buildPythonPackage
, pybind11
, easyloggingpp
, librealsensex
}:

buildPythonPackage rec {
  pname = "real-sense-sensor";
  version = "1.0.0";

  src = ./.;

  buildInputs = [
    pybind11
    easyloggingpp
    librealsensex
  ];

  meta = with lib; {
    description = ''
      Customized pybind wrapper for librealsense2
    '';
    homepage = "https://github.com/HorizonRoboticsInternal/librealsense";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
