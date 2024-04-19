{pkgs , libs, config , lib,  ... } :
let
  sshuttleServiceScriptDefault   = pkgs.writeScript     "sshuttle"     ''
#!/usr/bin/env -S  python
## REQUIRES MINIMUM PY VERSION 2.7
from __future__ import print_function

import os
import sys
# import json
import signal
import time
import socket
import subprocess
from subprocess import CalledProcessError
import logging
import logging.handlers

log = logging.getLogger(__name__)
log.setLevel(logging.DEBUG)
handler = logging.handlers.SysLogHandler(address = '/dev/log')
formatter = logging.Formatter('%(module)s.%(funcName)s: %(message)s')
handler.setFormatter(formatter)
log.addHandler(handler)

#conf = "/home/platoali/.config/sshuttle/config.json"
ssh_user = "${cfg.user}"  ## username thats used for SSH connection
#pid_file =  "$ { pid_file}"
rhost = "${cfg.host}"
netrange = "${cfg.netrange}"
def precheck():
    if len(sys.argv) < 2:
        print("need to pass argument: start | stop | restart | status | toggle")
        sys.exit()
    
    if sys.argv[1] in ["help", "-h", "--help", "h"]:
        print("sshuttle.py start | stop | restart | status | toggle")
        sys.exit()

    if not sys.argv[1] in ["start", "stop", "restart", "status","toggle"]:
        print("usage: sshuttle.py start | stop | restart | status")
        sys.exit()
    
    # if not os.path.exists(conf):
    #     print("no sshuttle config file present, exiting.")
    #     sys.exit()
    
    # check if sshuttle is installed
    #try:
    #  subprocess.check_output(["which", "sshuttle"]).strip()
    #except CalledProcessError:
    #   print("sshuttle is not installed on this host")
    #    sys.exit()
        
def start():

    # with open(conf) as jsondata:
    #     data = json.load(jsondata)
    
    # keys = sorted(data.keys())

    # for rhost in data.keys():
    #     if ":" in rhost:
    #         relay = rhost.split(":")[1]
    #     else:
    #         relay = rhost
    #     netrange = ""

    #     # if single network, turn into List
    #     if not type(data[rhost]) is list:
    #         networks = data[rhost].split()
    #     else:
    #         networks = data[rhost]
      # for network in networks:
        
      #       # check if CIDR format
      #  # if "/" in network:
      #       netrange = netrange + " " + network
      #   else:
      #       netrange = netrange + " " + socket.gethostbyname(network)
      #       netrange = netrange.strip()
                
        # build rpath
    rpath = "-r {0}@{1} {2}     --dns --no-latency-control".format(ssh_user, rhost, netrange)
    try:
            print("starting sshuttle..")
            log.info("starting sshuttle for networks: %s via %s" % (netrange, rhost))
            subprocess.Popen("sshuttle  {}".format(rpath), shell=True) 
    except CalledProcessError as err:
            log.error("error running sshuttle: %s" % str(err))
            
        # sleep to give connection time to establish SSH handshake, in case other connections use this conn as a hop
    time.sleep(3)

def get_pid():
    search = "ps -ef | grep '${cfg.host}' | grep -v grep | awk {'print $2'}"
    pids = []
    for line in os.popen(search):
        fields = line.split()
        pids.append(fields[0])
    return pids

def stop():
    pids = get_pid()
    for pid in pids:
        print("stopping sshuttle PID %s " % pid)
        log.info("stopping sshuttle")
        os.kill(int(pid), signal.SIGTERM)

def status():
    pids = get_pid()
    if pids:
        print("sshuttle")
    else:
        print("No sshuttle")

def toggle ():
    pids = get_pid()
    if pids:
        stop()
    else:
        start()
        
if __name__ == "__main__":

    precheck()

    cmd = sys.argv[1].lower()

    if cmd == "start":
        start()

    if cmd == "stop":
        stop()
    
    if cmd == "restart":
        print("restarting sshuttle..")
        stop()
        start()
        
    if cmd == "status":
        status()

    if cmd == "toggle":
        print("toggling sshuttle..")
        toggle()
'' ;
  cfg = config.sshuttle-service ;
in
{
  options.sshuttle-service  = {
    enable  = lib.mkEnableOption "enable sshuttle service " ;
    host = lib.mkOption {
      default  = "sahar:14000";
      description = "remote host to connect";
    };
    netrange = lib.mkOption  {
      default = "0/0";
      description = "network range that should go through tunnel";
    };
    user = lib.mkOption {
      default = "platoali" ;
      description = "username under whcih sshuttle should run. ";
    };
    sshuttleServiceScript = lib.mkOption  {
      default = sshuttleServiceScriptDefault ;
      description = "script that start and restart the service " ;
    };
  };
  config = lib.mkIf cfg.enable  {
    security.sudo = {
      enable = true;
      extraConfig = ''
Cmnd_Alias SSHUTTLEBDF = /usr/bin/env PYTHONPATH=${pkgs.sshuttle}/lib/python3.11/site-packages ${pkgs.sshuttle}/bin/.sshuttle-wrapped  --method auto --firewall

%wheel ALL=NOPASSWD: SSHUTTLEBFD
platoali  ALL=NOPASSWD: SSHUTTLEBDF
'';
  };
    systemd.user.services.sshuttle  = {
     enable = true  ;
     description                 = "sshuttle service vpn";
     after= ["network.target"];
     wantedBy = ["multi-user.target"];
     path = [ "/run/wrappers"     pkgs.python3   pkgs.sshuttle  pkgs.procps pkgs.gawk];

     serviceConfig = {
       ExecStart ="${cfg.sshuttleServiceScript}  start";
       ExecStop =" ${cfg.sshuttleServiceScript}  stop";
       Type = "forking";
     };
   };
  };
}
