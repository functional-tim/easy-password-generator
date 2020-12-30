{ mkDerivation, base, bytestring, cmdargs, raaz, stdenv, text }:
mkDerivation {
  pname = "easy-password-generator";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ base bytestring cmdargs raaz text ];
  executableHaskellDepends = [ base bytestring cmdargs raaz text ];
  homepage = "https://github.com/CrazyMind102/easy-password-generator#readme";
  license = stdenv.lib.licenses.bsd3;
}
