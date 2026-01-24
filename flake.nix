{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, utils }: utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      lua = pkgs.lua53Packages;
      schemas = [
        pkgs.gtk3
        pkgs.gsettings-desktop-schemas
       ];
      getSchemas = schema: pkgs.glib.getSchemaPath schema;
    in
    {
      devShells.default = pkgs.mkShell {
        packages = [
          lua.lua
          lua.lgi
          lua.fennel
          pkgs.fennel-ls
          pkgs.gtk3
          pkgs.lua-language-server
          pkgs.gobject-introspection
          pkgs.glib
          pkgs.pango
          pkgs.harfbuzz
          pkgs.gsettings-desktop-schemas
        ];
        shellHook = ''
          echo "Lua $(lua -v | sed 's/Lua //')"
          # export GI_TYPELIB_PATH="${pkgs.gobject-introspection.out}/lib/girepository-1.0:${pkgs.gtk3.out}/lib/girepository-1.0:${pkgs.glib.out}/lib/girepository-1.0:${pkgs.pango.out}/lib/girepository-1.0:${pkgs.harfbuzz.out}/lib/girepository-1.0"
          export LUA_PATH="${lua.lgi}/share/lua/5.3/?.lua;${lua.lgi}/share/lua/5.3/?/init.lua;$LUA_PATH"
          export LUA_CPATH="${lua.lgi}/lib/lua/5.3/?.so"
          # export GSETTINGS_SCHEMA_DIR="${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/gsettings-desktop-schemas-49.1/glib-2.0/schemas/:$(find ${pkgs.gtk3}/share/gsettings-schemas/ -maxdepth 1 -type d | tail -1)/glib-2.0/schemas/"
          export GSETTINGS_SCHEMA_DIR="${builtins.concatStringsSep ":" (map getSchemas schemas)}"
        '';
      };
    }
  );
}
