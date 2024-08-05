{ fetchPypi, python3Packages }:
python3Packages.buildPythonApplication rec {
  pname = "BetterADBSync";
  version = "1.4.0";
  pyproject = true;
  src = fetchPypi {
    inherit pname version;
    hash = "sha256-z6E8gayItFEpT9GIi7LAZ5xIptNyUH/IBj6mJffmzoI=";
  };
  propagatedBuildInputs = [ python3Packages.setuptools ];
}
