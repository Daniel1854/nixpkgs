{ lib
, buildPythonPackage
, fetchPypi
, pytest
, cocotb
}:

buildPythonPackage rec {
  pname = "cocotb-test";
  version = "0.2.2";

  src = fetchPypi {
    inherit pname version;
    sha256 = "c5c4fe2fb81eb15bfc830c6c58d6e8b8192d3a03132b143f17efbe6c056e3bc7";
  };

  buildInputs = [ pytest cocotb ];

  meta = with lib; {
    description = "Unit testing for cocotb";
    homepage = "https://github.com/cocotb/cocotb-test";
    license = licenses.bsd2;
    maintainers = with maintainers; [ daniel1854 ];
  };
}
