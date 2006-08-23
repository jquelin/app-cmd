package App::Cmd::Command::help;

=head1 NAME

App::Cmd::Command::help - provide general help for an app or a subcommand.

=head1 VERSION

 $Id: /mirror/rjbs/app-cmd/trunk/lib/App/Cmd/Command/commands.pm 27059 2006-06-12T03:50:29.417621Z rjbs  $

=head1 DESCRIPTION

This command plugin implements a "help" command.  This command will either list
all of an App::Cmd's commands and their abstracts, or display the usage screen
for a subcommand.

=cut

use strict;
use warnings;

use base qw(App::Cmd::Command);

sub command_names { qw/help --help -h ?/ }

sub run {
  my ($self, $opts, $args) = @_;

  if ( !@$args ) {
    $self->app->execute_command( $self->app->prepare_command("commands") );
    exit;
  } else {
    my ( $cmd, $opt, $args) = $self->app->prepare_command(@$args);
    warn $cmd->usage->text;
    exit;
  }
}

sub sort_commands {
  my ( $self, @commands ) = @_;

  my $float = qr/^(?:help|commands)$/;

  sort {
    -1*$a =~ $float
    || $b =~ $float
    || $a cmp $b;
  } @commands;
}

1;
