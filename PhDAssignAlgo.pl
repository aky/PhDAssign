#!/usr/bin/perl

use strict;
use warnings;

# AKY
# PI_1.yadav@thsti.res.in
# PhD assignment Algorithms given three choices by Student and PI

my $n=0;#number of iterations for assigning
my $quota = 2; #max no. of students per PI
my %pi = (
            'PI_1' => ['S1','S2','S3'],
            'PI_2' => ['S4', 'S5', 'S1'],
            'PI_3'=> ['S6','S1','S4'],
            'PI_4'=>['S1','S5','S3'],
            'PI_5' => ['S2','S1','S6']
            );
my %picount;
keys %picount = keys %pi;

my %grad = ( 'S1' => ['PI_1','PI_3','PI_2'],
            'S2'=>['PI_1','PI_5','PI_3'],
            'S3'=>['PI_1','PI_2','PI_4'],
            'S5'=>['PI_2','PI_4','PI_3'],
            'S4'=>['PI_2','PI_1','PI_4'],
            'S6'=>['PI_3','PI_5','PI_1']
            );
my @rank = ('S4','S5','S1','S2','S6','S3'); #ranked students
assign_PI (\%grad,\%pi);

#
#print scalar keys %grad, " \n";
#(%grad,%pi) = assign_PI (\%grad,\%pi);

exit;

sub assign_PI{
    my($gr,$gd)=@_;
    $n++;
    my %pi = %$gd;
    my %grad = %$gr;
    foreach my $stud(@rank)
    {
        print "Searching student\n\t$stud\t";
        print"first preference PI=>\t$grad{$stud}[0]\n";
        print "\n######################################\n";
        print $pi{$grad{$stud}[0]}[0];
        if ($pi{$grad{$stud}[0]}[0] eq $stud)# 1st pref matches for both pi and student
        {
            print "\t\tmatched to\t$grad{$stud}[0]\n###########################################\n\n";
            $picount{$grad{$stud}[0]}++;
            
            
            foreach my $guide (keys %pi)
            {
                my @students = @{$pi{$guide}};
                my @new;
                foreach my $stdnt(@students)
                {
                    push @new, $stdnt if $stdnt ne $stud;
                }
                #if (($picount{$guide}>=$quota)||(scalar @new==0))
                #{
                #    delete $pi{$guide} ;
                #}
                #else
                #{
                #    $pi{$guide}=[@new];
                #}
                print"\t\t\tGUIDE $guide\t\tNEW\t@new\n";
                $pi{$guide}=[@new];
            }
            
            foreach my $stdnt (keys %grad)
            {
                my @guides = @{$grad{$stdnt}};
                my @new;
                foreach my $sup(@guides)
                {
                    #push @new, $sup if (($sup ne $grad{$stud}[0])||($picount{$sup}<$quota));
                    push @new, $sup if $sup ne $grad{$stud}[0];
                }
                print"\t\t\tSTDNT $stdnt\t\tNEW\t@new\n";

                $grad{$stdnt}=[@new];
            }
            delete $grad{$stud};
            #delete $pi{$grad{$stud}[0]}[0];
        }
        else
        {
            print "\tnot matched yet\n\n";
        }
    }
    
    print"Round $n finished\n----------------\n";<>;
    if (scalar keys %grad>0)
    {
        #(%grad,%pi) = assign_PI (\%grad,\%pi);
        assign_PI (\%grad,\%pi);
    }
}

