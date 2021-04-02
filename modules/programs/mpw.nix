{ config, lib, pkgs, ...}:

with lib;

let
  cfg = config.programs.mpw;
in {
  options.programs.mpw = {
    enable = mkEnableOption "Master Password";

    settings = mkOption rec {
      type = with types; attrsOf str;
      apply = mergeAttrs default;

      default = { };
      example = literalExample ''
      {
        MPW_FORMAT = "none";
        MPW_FULLNAME = "someuser";
      }
      '';
      description = ''
        The <literal>mpw</literal> environment variables dictionary.
        </para><para>
        See the "ENVIRONMENT" section of <literal>mpw -h</literal> for
        more information about the available keys.
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.mpw ];
    home.sessionVariables = cfg.settings;
  };
}
