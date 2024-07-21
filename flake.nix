{ pkgs }: {
	deps = [
   pkgs.cargo
   pkgs.openssh
   pkgs.nano
   pkgs.gh
   pkgs.postgresql
		pkgs.elixir_1_16
        pkgs.elixir_ls
        pkgs.sqlite
        pkgs.inotify-tools
	];
}