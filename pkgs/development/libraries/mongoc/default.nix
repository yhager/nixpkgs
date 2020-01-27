{ stdenv, fetchzip, perl, pkgconfig, libbson
, openssl, which, zlib, snappy, cmake
}:

stdenv.mkDerivation rec {
  pname = "mongoc";
  version = "1.16.0";

  src = fetchzip {
    url = "https://github.com/mongodb/mongo-c-driver/releases/download/${version}/mongo-c-driver-${version}.tar.gz";
    sha256 = "072xr7lrr4gs0rjxxnlzvsql7n0gi2j2ndv8cbi5ywalfy2bpdgq";
  };

  nativeBuildInputs = [ cmake pkgconfig which perl ];
  buildInputs = [ openssl zlib ];
  propagatedBuildInputs = [ libbson snappy ];
  cmakeFlags = [
    "-DENABLE_AUTOMATIC_INIT_AND_CLEANUP=OFF"
    "-DENABLE_SHM_COUNTERS=OFF"
  ];

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = "The official C client library for MongoDB";
    homepage = https://github.com/mongodb/mongo-c-driver;
    license = licenses.asl20;
    platforms = platforms.all;
  };
}
