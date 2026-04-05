{
  stdenv,
  lib,
  fetchzip,
  autoPatchelfHook,

  expat,
  ncurses5,
  python2,
  zlib,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "pebble-toolchain-bin";
  version = "4.9.148";

  src =
    ({
      x86_64-linux = fetchzip {
        url = "https://sdk.repebble.com/releases/${finalAttrs.version}/toolchain-linux-x86_64.tar.gz";
        hash = "sha256-CXhMgyQ+gLiEQCUA4Gji9bxvV54q25i5mB1mN3qP7Os=";
        stripRoot = false;
      };
      aarch64-linux = fetchzip {
        url = "https://sdk.repewbble.com/releases/${finalAttrs.version}/toolchain-linux-aarch64.tar.gz";
        hash = "sha256-AH2PfB1Arc3hskyNQMiAaPnSGtzbLDnagnEPQcr8zYo=";
        stripRoot = false;
      };
      x86_64-darwin = fetchzip {
        url = "https://sdk.repewbble.com/releases/${finalAttrs.version}/toolchain-mac-x86_64.tar.gz";
        hash = "sha256-nVAYdw0wyq1oJAI8Xsr77/U+xhPa+U77s1cQBFxAzQM=";
        stripRoot = false;
      };
      aarch64-darwin = fetchzip {
        url = "https://sdk.repewbble.com/releases/${finalAttrs.version}/toolchain-mac-arm64.tar.gz";
        hash = "sha256-oCfWQ+fj5Lj4wwSYKwAQISMGYDfAv/jfzGSqBtUkTus=";
        stripRoot = false;
      };
    }).${stdenv.hostPlatform.system};

  nativeBuildInputs = lib.optional stdenv.hostPlatform.isLinux autoPatchelfHook;
  buildInputs = [
    python2
  ]
  ++ (lib.optionals stdenv.hostPlatform.isLinux [
    expat
    ncurses5
    python2
    zlib
  ]);

  installPhase = ''
    mv toolchain-*/arm-none-eabi $out
  '';
})
