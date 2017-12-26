#!/usr/bin/env perl

my $root_dir = "./package/gli-pri";

my %update_cmd = (
	'init'          => "git clone --depth 1 '%s' '%s'",
	'init_branch'   => "git clone --depth 1 --branch '%s' '%s' '%s'",
	'init_commit'   => "git clone '%s' '%s' && cd '%s' && git checkout -b '%s' '%s' && cd -",
	'update'	=> "git pull --ff",
	'update_force'	=> "git pull --ff || (git reset --hard HEAD; git pull --ff; exit 1)",
	'revision'	=> "git rev-parse --short HEAD | tr -d '\n'"
);

sub usage() {
	print <<EOF;
Usage: $0 <directory> <url>

	directory:	store directory
	url:		git repo source
EOF
	exit(1);
}

sub update_location($$)
{
	my $name = shift;
	my $url  = shift;
	my $old_url;

	if( open LOC, "< $root_dir/.$name.tmp" )
	{
		chomp($old_url = readline LOC);
		close LOC;
	}

	if( !$old_url || $old_url ne $url )
	{
		if( open LOC, "> $root_dir/.$name.tmp" )
		{
			print LOC $url, "\n";
			close LOC;
		}
		return $old_url ? 1 : 0;
	}

	return 0;
}

sub update_package($$) {
	my $name = shift;
	my $src = shift;
	my $force_relocate = update_location( $name, "$src" );

	my $localpath = "$root_dir/$name";
	my $safepath = $localpath;

	if ( $force_relocate || !-d "$localpath/.git" ) {
		system("rm -rf '$safepath'");
		system(sprintf($update_cmd{'init'}, $src, $safepath)) == 0 or return 1;
	} else {
		system("cd '$safepath'; $update_cmd{'update'}") == 0 or return 1;
	}

	return 0;
}

system(sprintf("mkdir -p %s", $root_dir)) unless -d $root_dir;

usage() unless @ARGV == 2;

exit(update_package($ARGV[0], $ARGV[1]));
