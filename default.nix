let
 pkgs = import (fetchTarball "https://github.com/rstats-on-nix/nixpkgs/archive/2025-08-19.tar.gz") {};

  system_packages = builtins.attrValues {
    inherit (pkgs) 
      quarto
      pandoc
      ;
  };

  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive)
      scheme-small
      abstract
      enumitem
      footmisc
      nowidow
      orcidlink
      titlesec
      titling
      tocloft
      ;
});
  
in

pkgs.mkShell {
  LOCALE_ARCHIVE = if pkgs.system == "x86_64-linux" then "${pkgs.glibcLocales}/lib/locale/locale-archive" else "";
  LANG = "en_US.UTF-8";
   LC_ALL = "en_US.UTF-8";
   LC_TIME = "en_US.UTF-8";
   LC_MONETARY = "en_US.UTF-8";
   LC_PAPER = "en_US.UTF-8";
   LC_MEASUREMENT = "en_US.UTF-8";

  buildInputs = [ tex system_packages ];
  
}
