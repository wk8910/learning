#! /usr/bin/perl
use strict;
use warnings;

my $run_pid=-1;
my $control=0;
my $port_id=11113;
while(1){
    my $status=&check;
    print "status: $status\n";
    if(!$status){
        $run_pid=&start();
        print "$run_pid\n";
    }
    sleep(30);
    $control+=30 if($status==1);
    #if($control>=300){
    # `kill $run_pid`;
    # $control=0;
    #}
}

sub start{
    system("ssh -i ~/.ssh/id_dsa -f -N -R $port_id:localhost:22 root\@xx.xx.xx.xx -o ExitOnForwardFailure=yes");
    my $a=`ps -ef | grep '$port_id:localhost:22' | grep -v 'grep'`;
    my @a=split(/\s+/,$a);
    my $pid=$a[1];
    if(!$pid){
        $pid=-1;
    }
    return($pid);
}

sub check{
    my $a=`ps -ef | grep '$port_id:localhost:22' | grep -v 'grep' | wc -l`;
    my @a=split(/\s+/,$a);
    my $result=$a[0];
    return($result);
}
