{ lib, stdenv, fetchurl, perl, openldap, pam, db, cyrus_sasl, libcap
, expat, libxml2, openssl, pkg-config, systemd
}:

stdenv.mkDerivation rec {
  pname = "squid";
  version = "5.7";

  src = fetchurl {
    url = "http://www.squid-cache.org/Versions/v5/${pname}-${version}.tar.xz";
    hash = "sha256-awdTqrpMnE79Mz5nEkyuz3rWzC04WB8Z0vAyH1t+zYE=";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [
    perl openldap db cyrus_sasl expat libxml2 openssl
  ] ++ lib.optionals stdenv.isLinux [ libcap pam systemd ];

  enableParallelBuilding = true;

  configureFlags = [
    "--enable-ipv6"
    "--disable-strict-error-checking"
    "--disable-arch-native"
    "--with-openssl"
    "--enable-ssl-crtd"
    "--enable-storeio=ufs,aufs,diskd,rock"
    "--enable-removal-policies=lru,heap"
    "--enable-delay-pools"
    "--enable-x-accelerator-vary"
    "--enable-htcp"
  ] ++ lib.optional (stdenv.isLinux && !stdenv.hostPlatform.isMusl)
    "--enable-linux-netfilter";

  meta = with lib; {
    description = "A caching proxy for the Web supporting HTTP, HTTPS, FTP, and more";
    homepage = "http://www.squid-cache.org";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ raskin ];
  };
}
