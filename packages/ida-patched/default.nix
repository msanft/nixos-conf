{ python3

, ida-package
, patch
,
}:
ida-package.overrideAttrs (old: {
  name = "${old.pname}-patched";

  nativeBuildInputs = old.nativeBuildInputs ++ [ python3 ];

  postInstall = ''
    pushd $out/opt

    python3 ${patch}

    mv libida32.so.patched libida32.so
    mv libida.so.patched libida.so

    mkdir -p $out/share
    mv idapro.hexlic $out/share
    
    popd
  '';
})
