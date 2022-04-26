{ mkDerivation, aeson, base, base16-bytestring, binary, bytestring
, containers, data-default, hspec, http2, lib , lifted-base, mtl
, optparse-applicative, random, resource-pool , semigroups, text, time, tls
, x509, x509-store, x509-system
}:
mkDerivation {
  pname = "push-notify-apn";
  version = "0.3.0.1";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    aeson base base16-bytestring binary bytestring containers
    data-default http2 lifted-base mtl random resource-pool semigroups text
    time tls x509 x509-store x509-system
  ];
  executableHaskellDepends = [
    base bytestring optparse-applicative semigroups text
  ];
  testHaskellDepends = [ aeson base hspec ];
  homepage = "https://github.com/memrange/apn#readme";
  description = "Send push notifications to mobile iOS devices";
  license = lib.licenses.bsd3;
}
