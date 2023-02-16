#!/bin/bash

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;35m'
NC='\033[0m'

success=0
fail=0

yum update -y && yum install wget -y

###########################################################################################################################


##Category 1.2 Initial Setup - Configure Software Updates
echo
echo -e "${BLUE}1.2 Initial Setup - Configure Software Updates${NC}"

# Ensure gpgcheck is globally activated
echo
echo -e "${RED}1.2.2${NC} Ensure gpgcheck is globally activated"
amz_1_2_2="$(egrep -q "^(\s*)gpgcheck\s*=\s*\S+(\s*#.*)?\s*$" /etc/yum.conf && sed -ri "s/^(\s*)gpgcheck\s*=\s*\S+(\s*#.*)?\s*$/\1gpgcheck=1\2/" /etc/yum.conf || echo "gpgcheck=1" >> /etc/yum.conf)"
amz_1_2_2=$?
amz_1_2_2_temp=0
for file in /etc/yum.repos.d/*; do
  amz_1_2_2_temp_2="$(egrep -q "^(\s*)gpgcheck\s*=\s*\S+(\s*#.*)?\s*$" $file && sed -ri "s/^(\s*)gpgcheck\s*=\s*\S+(\s*#.*)?\s*$/\1gpgcheck=1\2/" $file || echo "gpgcheck=1" >> $file)"
  amz_1_2_2_temp_2=$?
  if [[ "$amz_1_2_2_temp_2" -eq 0 ]]; then
    ((amz_1_2_2_temp=amz_1_2_2_temp+1))
  fi
done
amz_1_2_2_temp_2="$( ls -1q /etc/yum.repos.d/* | wc -l)"
if [[ "$amz_1_2_2" -eq 0 ]] && [[ "$amz_1_2_2_temp" -eq "amz_1_2_2_temp_2" ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure gpgcheck is globally activated"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure gpgcheck is globally activated"
  fail=$((fail + 1))
fi

############################################################################################################################

##Category 1.3 Initial Setup - Filesystem Integrity Checking
echo
echo -e "${BLUE}1.3 Initial Setup - Filesystem Integrity Checking${NC}"

# Ensure AIDE is installed
echo
echo -e "${RED}1.3.1${NC} Ensure AIDE is installed"
amz_1_3_1="$(rpm -q aide || yum -y install aide)"
amz_1_3_1=$?
if [[ "$amz_1_3_1" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure AIDE is installed"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure AIDE is installed"
  fail=$((fail + 1))
fi


############################################################################################################################

# Ensure SELinux is installed
echo
echo -e "${RED}1.6.2${NC} Ensure SELinux is installed"
amz_1_6_2="$(rpm -q libselinux || yum -y install libselinux)"
amz_1_6_2=$?
if [[ "$amz_1_6_2" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure SELinux is installed"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure SELinux is installed"
  fail=$((fail + 1))
fi


############################################################################################################################

##Category 1.7 Initial Setup - Warning Banners
echo
echo -e "${BLUE}1.7 Initial Setup - Warning Banners${NC}"

# Ensure message of the day is configured properly
echo
echo -e "${RED}1.7.1.1${NC} Ensure message of the day is configured properly"
amz_1_7_1_1="$(sed -ri 's/(\\v|\\r|\\m|\\s)//g' /etc/motd)"
amz_1_7_1_1=$?
if [[ "$amz_1_7_1_1" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure message of the day is configured properly"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure message of the day is configured properly"
  fail=$((fail + 1))
fi

# Ensure local login warning banner is configured properly
echo
echo -e "${RED}1.7.1.2${NC} Ensure local login warning banner is configured properly"
amz_1_7_1_2="$(echo "Authorized uses only. All activity may be monitored and reported." > /etc/issue)"
amz_1_7_1_2=$?
if [[ "$amz_1_7_1_2" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure local login warning banner is configured properly"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure local login warning banner is configured properly"
  fail=$((fail + 1))
fi

# Ensure remote login warning banner is configured properly
echo
echo -e "${RED}1.7.1.3${NC} Ensure remote login warning banner is configured properly"
amz_1_7_1_3="$(echo "Authorized uses only. All activity may be monitored and reported." > /etc/issue.net)"
amz_1_7_1_3=$?
if [[ "$amz_1_7_1_3" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure remote login warning banner is configured properly"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure remote login warning banner is configured properly"
  fail=$((fail + 1))
fi

# Ensure permissions on /etc/motd are configured
echo
echo -e "${RED}1.7.1.4${NC} Ensure permissions on /etc/motd are configured"
amz_1_7_1_4="$(chmod -t,u+r+w-x-s,g+r-w-x-s,o+r-w-x /etc/motd)"
amz_1_7_1_4=$?
if [[ "$amz_1_7_1_4" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure permissions on /etc/motd are configured"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure permissions on /etc/motd are configured"
  fail=$((fail + 1))
fi

# Ensure permissions on /etc/issue are configured
echo
echo -e "${RED}1.7.1.5${NC} Ensure permissions on /etc/issue are configured"
amz_1_7_1_5="$(chmod -t,u+r+w-x-s,g+r-w-x-s,o+r-w-x /etc/issue)"
amz_1_7_1_5=$?
if [[ "$amz_1_7_1_5" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure permissions on /etc/issue are configured"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure permissions on /etc/issue are configured"
  fail=$((fail + 1))
fi

# Ensure permissions on /etc/issue.net are configured
echo
echo -e "${RED}1.7.1.6${NC} Ensure permissions on /etc/issue.net are configured"
amz_1_7_1_6="$(chmod -t,u+r+w-x-s,g+r-w-x-s,o+r-w-x /etc/issue.net)"
amz_1_7_1_6=$?
if [[ "$amz_1_7_1_6" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure permissions on /etc/issue.net are configured"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure permissions on /etc/issue.net are configured"
  fail=$((fail + 1))
fi

############################################################################################################################


##Category 2.2 Services - Special Purpose Services
echo
echo -e "${BLUE}2.2 Services - Special Purpose Services${NC}"

# Ensure time synchronization is in use
echo
echo -e "${RED}2.2.1.1${NC} Ensure time synchronization is in use"
amz_2_2_1_1="$(rpm -q ntp || rpm -q chrony || yum -y install chrony)"
amz_2_2_1_1=$?
if [[ "$amz_2_2_1_1" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure time synchronization is in use"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure time synchronization is in use"
  fail=$((fail + 1))
fi

# Ensure ntp is configured
echo
echo -e "${RED}2.2.1.2${NC} Ensure ntp is configured"
if rpm -q ntp >/dev/null; then
  amz_2_2_1_1_temp_1="$(egrep -q "^\s*restrict(\s+-4)?\s+default(\s+\S+)*(\s*#.*)?\s*$" /etc/ntp.conf && sed -ri "s/^(\s*)restrict(\s+-4)?\s+default(\s+[^[:space:]#]+)*(\s+#.*)?\s*$/\1restrict\2 default kod nomodify notrap nopeer noquery\4/" /etc/ntp.conf || echo "restrict -4 default kod nomodify notrap nopeer noquery" >> /etc/ntp.conf)"
  amz_2_2_1_1_temp_1=$?
  amz_2_2_1_1_temp_2="$(egrep -q "^\s*restrict\s+-6\s+default(\s+\S+)*(\s*#.*)?\s*$" /etc/ntp.conf && sed -ri "s/^(\s*)restrict\s+-6\s+default(\s+[^[:space:]#]+)*(\s+#.*)?\s*$/\1restrict -6 default kod nomodify notrap nopeer noquery\3/" /etc/ntp.conf || echo "restrict -6 default kod nomodify notrap nopeer noquery" >> /etc/ntp.conf)"
  amz_2_2_1_1_temp_2=$?
  amz_2_2_1_1_temp_3="$(egrep -q "^(\s*)OPTIONS\s*=\s*\"(([^\"]+)?-u\s[^[:space:]\"]+([^\"]+)?|([^\"]+))\"(\s*#.*)?\s*$" /etc/sysconfig/ntpd && sed -ri '/^(\s*)OPTIONS\s*=\s*\"([^\"]*)\"(\s*#.*)?\s*$/ {/^(\s*)OPTIONS\s*=\s*\"[^\"]*-u\s+\S+[^\"]*\"(\s*#.*)?\s*$/! s/^(\s*)OPTIONS\s*=\s*\"([^\"]*)\"(\s*#.*)?\s*$/\1OPTIONS=\"\2 -u ntp:ntp\"\3/ }' /etc/sysconfig/ntpd && sed -ri "s/^(\s*)OPTIONS\s*=\s*\"([^\"]+\s+)?-u\s[^[:space:]\"]+(\s+[^\"]+)?\"(\s*#.*)?\s*$/\1OPTIONS=\"\2\-u ntp:ntp\3\"\4/" /etc/sysconfig/ntpd || echo OPTIONS=\"-u ntp:ntp\" >> /etc/sysconfig/ntpd)"
  amz_2_2_1_1_temp_3=$?
  if [[ "$amz_2_2_1_1_temp_1" -eq 0 ]] && [[ "$amz_2_2_1_1_temp_2" -eq 0 ]] && [[ "$amz_2_2_1_1_temp_3" -eq 0 ]]; then
    echo -e "${GREEN}Remediated:${NC} Ensure ntp is configured"
    success=$((success + 1))
  else
    echo -e "${RED}UnableToRemediate:${NC} Ensure ntp is configured"
    fail=$((fail + 1))
  fi
else
  yum install ntp -y && systemctl enable ntpd
  amz_2_2_1_1_temp_1="$(echo "restrict -4 default kod nomodify notrap nopeer noquery" >> /etc/ntp.conf)"
  amz_2_2_1_1_temp_1=$?
  amz_2_2_1_1_temp_2="$(echo "restrict -6 default kod nomodify notrap nopeer noquery" >> /etc/ntp.conf)"
  amz_2_2_1_1_temp_2=$?
  amz_2_2_1_1_temp_3="$(echo OPTIONS=\"-u ntp:ntp\" >> /etc/sysconfig/ntpd)"
  amz_2_2_1_1_temp_3=$?
  if [[ "$amz_2_2_1_1_temp_1" -eq 0 ]] && [[ "$amz_2_2_1_1_temp_2" -eq 0 ]] && [[ "$amz_2_2_1_1_temp_3" -eq 0 ]]; then
    echo -e "${GREEN}Remediated:${NC} Ensure ntp is configured"
    success=$((success + 1))
  else
    echo -e "${RED}UnableToRemediate:${NC} Ensure ntp is configured"
    fail=$((fail + 1))
  fi
fi

# Ensure X Window System is not installed
echo
echo -e "${RED}2.2.2${NC} Ensure X Window System is not installed"
amz_2_2_2="$(yum -y remove xorg-x11*)"
amz_2_2_2=$?
if [[ "$amz_2_2_2" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure X Window System is not installed"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure X Window System is not installed"
  fail=$((fail + 1))
fi

# Ensure Avahi Server is not enabled
echo
echo -e "${RED}2.2.3${NC} Ensure Avahi Server is not enabled"
amz_2_2_3="$(systemctl disable avahi-daemon.service || yum erase avahi -y)"
amz_2_2_3=$?
if [[ "$amz_2_2_3" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure Avahi Server is not enabled"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure Avahi Server is not enabled"
  fail=$((fail + 1))
fi

# Ensure CUPS is not enabled
echo
echo -e "${RED}2.2.4${NC} Ensure CUPS is not enabled"
amz_2_2_4="$(systemctl disable cups.service  || yum erase cups -y)"
amz_2_2_4=$?
if [[ "$amz_2_2_4" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure CUPS is not enabled"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure CUPS is not enabled"
  fail=$((fail + 1))
fi

# Ensure DHCP Server is not enabled
echo
echo -e "${RED}2.2.5${NC} Ensure DHCP Server is not enabled"
amz_2_2_5="$(systemctl disable dhcpd.service || yum erase dhcpd -y)"
amz_2_2_5=$?
if [[ "$amz_2_2_5" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure DHCP Server is not enabled"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure DHCP Server is not enabled"
  fail=$((fail + 1))
fi

# Ensure LDAP server is not enabled
echo
echo -e "${RED}2.2.6${NC} Ensure LDAP server is not enabled"
amz_2_2_6="$(systemctl disable slapd.service || yum erase slapd -y)"
amz_2_2_6=$?
if [[ "$amz_2_2_6" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure LDAP server is not enabled"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure LDAP server is not enabled"
  fail=$((fail + 1))
fi

# Ensure NFS and RPC are not enabled
echo
echo -e "${RED}2.2.7${NC} Ensure NFS and RPC are not enabled"
amz_2_2_7_temp_1="$(systemctl disable nfs.service || yum erase nfs -y)"
amz_2_2_7_temp_1=$?
amz_2_2_7_temp_2="$(systemctl disable rpcbind.service || yum erase rpcbind -y)"
amz_2_2_7_temp_2=$?
if [[ "$amz_2_2_7_temp_1" -eq 0 ]] && [[ "$amz_2_2_7_temp_2" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure NFS and RPC are not enabled"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure NFS and RPC are not enabled"
  fail=$((fail + 1))
fi

# Ensure DNS Server is not enabled
echo
echo -e "${RED}2.2.8${NC} Ensure DNS Server is not enabled"
amz_2_2_8="$(systemctl disable named.service || yum erase named -y)"
amz_2_2_8=$?
if [[ "$amz_2_2_8" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure DNS Server is not enabled"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure DNS Server is not enabled"
  fail=$((fail + 1))
fi

# Ensure FTP Server is not enabled
echo
echo -e "${RED}2.2.9${NC} Ensure FTP Server is not enabled"
amz_2_2_9="$(systemctl disable vsftpd.service || yum erase vsftpd -y)"
amz_2_2_9=$?
if [[ "$amz_2_2_9" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure FTP Server is not enabled"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure FTP Server is not enabled"
  fail=$((fail + 1))
fi

# Ensure HTTP server is not enabled
echo
echo -e "${RED}2.2.10${NC} Ensure HTTP server is not enabled"
amz_2_2_10="$(systemctl disable httpd.service || yum erase httpd -y)"
amz_2_2_10=$?
if [[ "$amz_2_2_10" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure HTTP server is not enabled"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure HTTP server is not enabled"
  fail=$((fail + 1))
fi

# Ensure IMAP and POP3 server is not enabled
echo
echo -e "${RED}2.2.11${NC} Ensure IMAP and POP3 server is not enabled"
amz_2_2_11="$(systemctl disable dovecot.service || yum erase dovecot -y)"
amz_2_2_11=$?
if [[ "$amz_2_2_11" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure IMAP and POP3 server is not enabled"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure IMAP and POP3 server is not enabled"
  fail=$((fail + 1))
fi

# Ensure Samba is not enabled
echo
echo -e "${RED}2.2.12${NC} Ensure Samba is not enabled"
amz_2_2_12="$(systemctl disable smb.service || yum erase smb -y)"
amz_2_2_12=$?
if [[ "$amz_2_2_12" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure Samba is not enabled"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure Samba is not enabled"
  fail=$((fail + 1))
fi

# Ensure HTTP Proxy Server is not enabled
echo
echo -e "${RED}2.2.13${NC} Ensure HTTP Proxy Server is not enabled"
amz_2_2_13="$(systemctl disable squid.service || yum erase squid -y)"
amz_2_2_13=$?
if [[ "$amz_2_2_13" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure HTTP Proxy Server is not enabled"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure HTTP Proxy Server is not enabled"
  fail=$((fail + 1))
fi

# Ensure SNMP Server is not enabled
echo
echo -e "${RED}2.2.14${NC} Ensure SNMP Server is not enabled"
amz_2_2_14="$(systemctl disable snmpd.service || yum erase snmpd -y)"
amz_2_2_14=$?
if [[ "$amz_2_2_14" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure SNMP Server is not enabled"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure SNMP Server is not enabled"
  fail=$((fail + 1))
fi

# Ensure NIS Server is not enabled
echo
echo -e "${RED}2.2.16${NC} Ensure NIS Server is not enabled"
amz_2_2_16="$(systemctl disable ypserv.service || yum erase ypserv -y)"
amz_2_2_16=$?
if [[ "$amz_2_2_16" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure NIS Server is not enabled"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure NIS Server is not enabled"
  fail=$((fail + 1))
fi

# Ensure rsh server is not enabled
echo
echo -e "${RED}2.2.17${NC} Ensure rsh server is not enabled"
amz_2_2_17="$(systemctl disable rsh.socket.service || yum erase rsh -y)"
amz_2_2_17=$?
systemctl disable rlogin.socket.service
systemctl disable rexec.socket.service
if [[ "$amz_2_2_17" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure rsh server is not enabled"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure rsh server is not enabled"
  fail=$((fail + 1))
fi

# Ensure talk server is not enabled
echo
echo -e "${RED}2.2.18${NC} Ensure talk server is not enabled"
amz_2_2_18="$(systemctl disable ntalk.service || yum erase ntalk -y)"
amz_2_2_18=$?
if [[ "$amz_2_2_18" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure talk server is not enabled"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure talk server is not enabled"
  fail=$((fail + 1))
fi

# Ensure telnet server is not enabled
echo
echo -e "${RED}2.2.19${NC} Ensure telnet server is not enabled"
amz_2_2_19="$(systemctl disable telnet.socket.service || yum erase telnet -y)"
amz_2_2_19=$?
if [[ "$amz_2_2_19" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure telnet server is not enabled"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure telnet server is not enabled"
  fail=$((fail + 1))
fi

# Ensure rsync service is not enabled
echo
echo -e "${RED}2.2.21${NC} Ensure rsync service is not enabled"
amz_2_2_21="$(systemctl disable rsyncd.service || yum erase rsyncd -y)"
amz_2_2_21=$?
if [[ "$amz_2_2_21" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure rsync service is not enabled"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure rsync service is not enabled"
  fail=$((fail + 1))
fi

############################################################################################################################

##Category 3.4 Network Configuration - TCP Wrappers
echo
echo -e "${BLUE}3.4 Network Configuration - TCP Wrappers${NC}"

# Ensure TCP Wrappers is installed
echo
echo -e "${RED}3.4.1${NC} Ensure TCP Wrappers is installed"
amz_3_4_1_temp_1="$(rpm -q tcp_wrappers || yum -y install tcp_wrappers)"
amz_3_4_1_temp_1=$?
amz_3_4_1_temp_2="$(rpm -q tcp_wrappers-libs || yum -y install tcp_wrappers-libs)"
amz_3_4_1_temp_2=$?
if [[ "$amz_3_4_1_temp_1" -eq 0 ]] && [[ "$amz_3_4_1_temp_2" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure TCP Wrappers is installed"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure TCP Wrappers is installed"
  fail=$((fail + 1))
fi

# Ensure /etc/hosts.allow is configured
echo
echo -e "${RED}3.4.2${NC} Ensure /etc/hosts.allow is configured"
amz_3_4_2="$(touch /etc/hosts.allow)"
amz_3_4_2=$?
if [[ "$amz_3_4_2" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure /etc/hosts.allow is configured"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure /etc/hosts.allow is configured"
  fail=$((fail + 1))
fi

# Ensure /etc/hosts.deny is configured
echo
echo -e "${RED}3.4.3${NC} Ensure /etc/hosts.deny is configured"
amz_3_4_3="$(touch /etc/hosts.deny)"
amz_3_4_3=$?
if [[ "$amz_3_4_3" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure /etc/hosts.deny is configured"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure /etc/hosts.deny is configured"
  fail=$((fail + 1))
fi

# Ensure permissions on /etc/hosts.allow are configured
echo
echo -e "${RED}3.4.4${NC} Ensure permissions on /etc/hosts.allow are configured"
amz_3_4_4="$(chmod -t,u+r+w-x-s,g+r-w-x-s,o+r-w-x /etc/hosts.allow)"
amz_3_4_4=$?
if [[ "$amz_3_4_4" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure permissions on /etc/hosts.allow are configured"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure permissions on /etc/hosts.allow are configured"
  fail=$((fail + 1))
fi

# Ensure permissions on /etc/hosts.deny are 644
echo
echo -e "${RED}3.4.5${NC} Ensure permissions on /etc/hosts.deny are configured"
amz_3_4_5="$(chmod -t,u+r+w-x-s,g+r-w-x-s,o+r-w-x /etc/hosts.deny)"
amz_3_4_5=$?
if [[ "$amz_3_4_5" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure permissions on /etc/hosts.deny are configured"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure permissions on /etc/hosts.deny are configured"
  fail=$((fail + 1))
fi

############################################################################################################################

##Category 3.5 Network Configuration - Uncommon Network Protocols
echo
echo -e "${BLUE}3.5 Network Configuration - Uncommon Network Protocols${NC}"

# Ensure DCCP is disabled
echo
echo -e "${RED}3.5.1${NC} Ensure DCCP is disabled"
amz_3_5_1="$(modprobe -n -v dccp | grep "^install /bin/true$" || echo "install dccp /bin/true" >> /etc/modprobe.d/CIS.conf)"
amz_3_5_1=$?
lsmod | egrep "^dccp\s" && rmmod dccp
if [[ "$amz_3_5_1" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure DCCP is disabled"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure DCCP is disabled"
  fail=$((fail + 1))
fi

# Ensure SCTP is disabled
echo
echo -e "${RED}3.5.2${NC} Ensure SCTP is disabled"
amz_3_5_2="$(modprobe -n -v sctp | grep "^install /bin/true$" || echo "install sctp /bin/true" >> /etc/modprobe.d/CIS.conf)"
amz_3_5_2=$?
lsmod | egrep "^sctp\s" && rmmod sctp
if [[ "$amz_3_5_2" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure SCTP is disabled"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure SCTP is disabled"
  fail=$((fail + 1))
fi

# Ensure RDS is disabled
echo
echo -e "${RED}3.5.3${NC} Ensure RDS is disabled"
amz_3_5_3="$(modprobe -n -v rds | grep "^install /bin/true$" || echo "install rds /bin/true" >> /etc/modprobe.d/CIS.conf)"
amz_3_5_3=$?
lsmod | egrep "^rds\s" && rmmod rds
if [[ "$amz_3_5_3" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure RDS is disabled"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure RDS is disabled"
  fail=$((fail + 1))
fi

# Ensure TIPC is disabled
echo
echo -e "${RED}3.5.4${NC} Ensure TIPC is disabled"
amz_3_5_4="$(modprobe -n -v tipc | grep "^install /bin/true$" || echo "install tipc /bin/true" >> /etc/modprobe.d/CIS.conf)"
amz_3_5_4=$?
lsmod | egrep "^tipc\s" && rmmod tipc
if [[ "$amz_3_5_4" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure TIPC is disabled"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure TIPC is disabled"
  fail=$((fail + 1))
fi

############################################################################################################################

##Category 3.6 Network Configuration - Firewall Configuration
echo
echo -e "${BLUE}3.6 Network Configuration - Firewall Configuration${NC}"

# Ensure iptables is installed
echo
echo -e "${RED}3.6.1${NC} Ensure iptables is installed"
amz_3_6_1="$(rpm -q iptables || yum -y install iptables)"
amz_3_6_1=$?
if [[ "$amz_3_6_1" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure iptables is installed"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure iptables is installed"
  fail=$((fail + 1))
fi

############################################################################################################################

echo
echo -e "${RED}4.2.3${NC} Ensure rsyslog or syslog-ng is installed"
amz_4_2_3="$(rpm -q rsyslog || rpm -q syslog-ng || yum -y install rsyslog)"
amz_4_2_3=$?
if [[ "$amz_4_2_3" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure rsyslog or syslog-ng is installed"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure rsyslog or syslog-ng is installed"
  fail=$((fail + 1))
fi

# Ensure permissions on all logfiles are configured
echo
echo -e "${RED}4.2.4${NC} Ensure permissions on all logfiles are configured"
amz_4_2_4="$(chmod -R g-w-x,o-r-w-x /var/log/*)"
amz_4_2_4=$?
if [[ "$amz_4_2_4" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure permissions on all logfiles are configured"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure permissions on all logfiles are configuredd"
  fail=$((fail + 1))
fi

############################################################################################################################

############################################################################################################################

##Category 5.3 Access, Authentication and Authorization - Configure PAM
echo
echo -e "${BLUE}5.3 Access, Authentication and Authorization - Configure PAM${NC}"

# Ensure password creation requirements are configured
echo
echo -e "${RED}5.3.1${NC} Ensure password creation requirements are configured"
amz_5_3_1_temp_1="$(egrep -q "^(\s*)minlen\s*=\s*\S+(\s*#.*)?\s*$" /etc/security/pwquality.conf && sed -ri "s/^(\s*)minlen\s*=\s*\S+(\s*#.*)?\s*$/\minlen=14\2/" /etc/security/pwquality.conf || echo "minlen=14" >> /etc/security/pwquality.conf)"
amz_5_3_1_temp_1=$?
amz_5_3_1_temp_2="$(egrep -q "^(\s*)dcredit\s*=\s*\S+(\s*#.*)?\s*$" /etc/security/pwquality.conf && sed -ri "s/^(\s*)dcredit\s*=\s*\S+(\s*#.*)?\s*$/\dcredit=-1\2/" /etc/security/pwquality.conf || echo "dcredit=-1" >> /etc/security/pwquality.conf)"
amz_5_3_1_temp_2=$?
amz_5_3_1_temp_3="$(egrep -q "^(\s*)ucredit\s*=\s*\S+(\s*#.*)?\s*$" /etc/security/pwquality.conf && sed -ri "s/^(\s*)ucredit\s*=\s*\S+(\s*#.*)?\s*$/\ucredit=-1\2/" /etc/security/pwquality.conf || echo "ucredit=-1" >> /etc/security/pwquality.conf)"
amz_5_3_1_temp_3=$?
amz_5_3_1_temp_4="$(egrep -q "^(\s*)ocredit\s*=\s*\S+(\s*#.*)?\s*$" /etc/security/pwquality.conf && sed -ri "s/^(\s*)ocredit\s*=\s*\S+(\s*#.*)?\s*$/\ocredit=-1\2/" /etc/security/pwquality.conf || echo "ocredit=-1" >> /etc/security/pwquality.conf)"
amz_5_3_1_temp_4=$?
amz_5_3_1_temp_5="$(egrep -q "^(\s*)lcredit\s*=\s*\S+(\s*#.*)?\s*$" /etc/security/pwquality.conf && sed -ri "s/^(\s*)lcredit\s*=\s*\S+(\s*#.*)?\s*$/\lcredit=-1\2/" /etc/security/pwquality.conf || echo "lcredit=-1" >> /etc/security/pwquality.conf)"
amz_5_3_1_temp_5=$?
amz_5_3_1_temp_6="$(echo "password requisite pam_pwquality.so try_first_pass retry=3" >> /etc/pam.d/system-auth)"
amz_5_3_1_temp_6=$?
amz_5_3_1_temp_7="$(echo "password requisite pam_pwquality.so try_first_pass retry=3" >> /etc/pam.d/password-auth)"
amz_5_3_1_temp_7=$?
if [[ "$amz_5_3_1_temp_1" -eq 0 ]] && [[ "$amz_5_3_1_temp_2" -eq 0 ]] && [[ "$amz_5_3_1_temp_3" -eq 0 ]] && [[ "$amz_5_3_1_temp_4" -eq 0 ]] && [[ "$amz_5_3_1_temp_5" -eq 0 ]] && [[ "$amz_5_3_1_temp_6" -eq 0 ]] && [[ "$amz_5_3_1_temp_7" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure password creation requirements are configured"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure password creation requirements are configured"
  fail=$((fail + 1))
fi

# Ensure password reuse is limited
echo
echo -e "${RED}5.3.3${NC} Ensure password reuse is limited"
amz_5_3_3_temp_1="$(egrep -q "^\s*password\s+sufficient\s+pam_unix.so(\s+.*)$" /etc/pam.d/system-auth && sed -ri '/^\s*password\s+sufficient\s+pam_unix.so\s+/ { /^\s*password\s+sufficient\s+pam_unix.so(\s+\S+)*(\s+remember=[0-9]+)(\s+.*)?$/! s/^(\s*password\s+sufficient\s+pam_unix.so\s+)(.*)$/\1remember=5 \2/ }' /etc/pam.d/system-auth && sed -ri 's/(^\s*password\s+sufficient\s+pam_unix.so(\s+\S+)*\s+)remember=[0-9]+(\s+.*)?$/\1remember=5\3/' /etc/pam.d/system-auth || echo Ensure\ password\ reuse\ is\ limited - /etc/pam.d/system-auth not configured.)"
amz_5_3_3_temp_1=$?
amz_5_3_3_temp_2="$(egrep -q "^\s*password\s+sufficient\s+pam_unix.so(\s+.*)$" /etc/pam.d/password-auth && sed -ri '/^\s*password\s+sufficient\s+pam_unix.so\s+/ { /^\s*password\s+sufficient\s+pam_unix.so(\s+\S+)*(\s+remember=[0-9]+)(\s+.*)?$/! s/^(\s*password\s+sufficient\s+pam_unix.so\s+)(.*)$/\1remember=5 \2/ }' /etc/pam.d/password-auth && sed -ri 's/(^\s*password\s+sufficient\s+pam_unix.so(\s+\S+)*\s+)remember=[0-9]+(\s+.*)?$/\1remember=5\3/' /etc/pam.d/password-auth || echo Ensure\ password\ reuse\ is\ limited - /etc/pam.d/password-auth not configured.)"
amz_5_3_3_temp_2=$?
if [[ "$amz_5_3_3_temp_1" -eq 0 ]] && [[ "$amz_5_3_3_temp_2" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure password reuse is limited"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure password reuse is limited"
  fail=$((fail + 1))
fi

# Ensure password hashing algorithm is SHA-512
echo
echo -e "${RED}5.3.4${NC} Ensure password hashing algorithm is SHA-512"
amz_5_3_4_temp_1="$(egrep -q "^\s*password\s+sufficient\s+pam_unix.so\s+" /etc/pam.d/system-auth && sed -ri '/^\s*password\s+sufficient\s+pam_unix.so\s+/ { /^\s*password\s+sufficient\s+pam_unix.so(\s+\S+)*(\s+sha512)(\s+.*)?$/! s/^(\s*password\s+sufficient\s+pam_unix.so\s+)(.*)$/\1sha512 \2/ }' /etc/pam.d/system-auth || echo Ensure\ password\ hashing\ algorithm\ is\ SHA-512 - /etc/pam.d/password-auth not configured.)"
amz_5_3_4_temp_1=$?
amz_5_3_4_temp_2="$(egrep -q "^\s*password\s+sufficient\s+pam_unix.so\s+" /etc/pam.d/password-auth && sed -ri '/^\s*password\s+sufficient\s+pam_unix.so\s+/ { /^\s*password\s+sufficient\s+pam_unix.so(\s+\S+)*(\s+sha512)(\s+.*)?$/! s/^(\s*password\s+sufficient\s+pam_unix.so\s+)(.*)$/\1sha512 \2/ }' /etc/pam.d/password-auth || echo Ensure\ password\ hashing\ algorithm\ is\ SHA-512 - /etc/pam.d/password-auth not configured.)"
amz_5_3_4_temp_2=$?
if [[ "$amz_5_3_4_temp_1" -eq 0 ]] && [[ "$amz_5_3_4_temp_2" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure password hashing algorithm is SHA-512"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure password hashing algorithm is SHA-512"
  fail=$((fail + 1))
fi

############################################################################################################################

##Category 5.4 Access, Authentication and Authorization - User Accounts and Environment
echo
echo -e "${BLUE}5.4 Access, Authentication and Authorization - User Accounts and Environment${NC}"

# Ensure password expiration is 90 days or less
echo
echo -e "${RED}5.4.1.1${NC} Ensure password expiration is 90 days or less"
amz_5_4_1_1="$(egrep -q "^(\s*)PASS_MAX_DAYS\s+\S+(\s*#.*)?\s*$" /etc/login.defs && sed -ri "s/^(\s*)PASS_MAX_DAYS\s+\S+(\s*#.*)?\s*$/\PASS_MAX_DAYS 90\2/" /etc/login.defs || echo "PASS_MAX_DAYS 90" >> /etc/login.defs)"
amz_5_4_1_1=$?
getent passwd | cut -f1 -d ":" | xargs -n1 chage --maxdays 90
if [[ "$amz_5_4_1_1" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure password expiration is 90 days or less"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure password expiration is 90 days or less"
  fail=$((fail + 1))
fi

# Ensure minimum days between password changes is 7 or more
echo
echo -e "${RED}5.4.1.2${NC} Ensure minimum days between password changes is 7 or more"
amz_5_4_1_2="$(egrep -q "^(\s*)PASS_MIN_DAYS\s+\S+(\s*#.*)?\s*$" /etc/login.defs && sed -ri "s/^(\s*)PASS_MIN_DAYS\s+\S+(\s*#.*)?\s*$/\PASS_MIN_DAYS 7\2/" /etc/login.defs || echo "PASS_MIN_DAYS 7" >> /etc/login.defs)"
amz_5_4_1_2=$?
getent passwd | cut -f1 -d ":" | xargs -n1 chage --mindays 7
if [[ "$amz_5_4_1_2" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure minimum days between password changes is 7 or more"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure minimum days between password changes is 7 or more"
  fail=$((fail + 1))
fi

# Ensure password expiration warning days is 7 or more
echo
echo -e "${RED}5.4.1.3${NC} Ensure password expiration warning days is 7 or more"
amz_5_4_1_3="$(egrep -q "^(\s*)PASS_WARN_AGE\s+\S+(\s*#.*)?\s*$" /etc/login.defs && sed -ri "s/^(\s*)PASS_WARN_AGE\s+\S+(\s*#.*)?\s*$/\PASS_WARN_AGE 7\2/" /etc/login.defs || echo "PASS_WARN_AGE 7" >> /etc/login.defs)"
amz_5_4_1_3=$?
getent passwd | cut -f1 -d ":" | xargs -n1 chage --warndays 7
if [[ "$amz_5_4_1_3" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure password expiration warning days is 7 or more"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure password expiration warning days is 7 or more"
  fail=$((fail + 1))
fi

# Ensure inactive password lock is 30 days or less
echo
echo -e "${RED}5.4.1.4${NC} Ensure inactive password lock is 30 days or less"
amz_5_4_1_4="$(useradd -D -f 30)"
amz_5_4_1_4=$?
getent passwd | cut -f1 -d ":" | xargs -n1 chage --inactive 30
if [[ "$amz_5_4_1_4" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure inactive password lock is 30 days or less"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure inactive password lock is 30 days or less"
  fail=$((fail + 1))
fi

# Ensure system accounts are non-login
echo
echo "${RED}5.4.2${NC} Ensure system accounts are non-login"
for user in `awk -F: '($3 < 1000) {print $1 }' /etc/passwd`; do
  if [ $user != "root" ]
  then
    /usr/sbin/usermod -L $user
    if [ $user != "sync" ] && [ $user != "shutdown" ] && [ $user != "halt" ]
    then
      /usr/sbin/usermod -s /sbin/nologin $user
    fi
  fi
done
echo -e "${GREEN}Remediated:${NC} Ensure system accounts are non-login"
success=$((success + 1))

# Ensure default group for the root account is GID 0
echo
echo -e "${RED}5.4.3${NC} Ensure default group for the root account is GID 0"
amz_5_4_3="$(usermod -g 0 root)"
amz_5_4_3=$?
if [[ "$amz_5_4_3" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure default group for the root account is GID 0"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure default group for the root account is GID 0"
  fail=$((fail + 1))
fi

# Ensure default user umask is 027 or more restrictive
echo
echo -e "${RED}5.4.4${NC} Ensure default user umask is 027 or more restrictive"
amz_5_4_4_temp_1="$(egrep -q "^(\s*)umask\s+\S+(\s*#.*)?\s*$" /etc/bashrc && sed -ri "s/^(\s*)umask\s+\S+(\s*#.*)?\s*$/\1umask 077\2/" /etc/bashrc || echo "umask 077" >> /etc/bashrc)"
amz_5_4_4_temp_1=$?
amz_5_4_4_temp_2="$(egrep -q "^(\s*)umask\s+\S+(\s*#.*)?\s*$" /etc/profile && sed -ri "s/^(\s*)umask\s+\S+(\s*#.*)?\s*$/\1umask 077\2/" /etc/profile || echo "umask 077" >> /etc/profile)"
amz_5_4_4_temp_2=$?
if [[ "$amz_5_4_4_temp_1" -eq 0 ]] && [[ "$amz_5_4_4_temp_2" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure default user umask is 027 or more restrictive"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure default user umask is 027 or more restrictive"
  fail=$((fail + 1))
fi

# Ensure access to the su command is restricted
echo
echo -e "${RED}5.6${NC} Ensure access to the su command is restricted"
amz_5_6="$(egrep -q "^\s*auth\s+required\s+pam_wheel.so(\s+.*)?$" /etc/pam.d/su && sed -ri '/^\s*auth\s+required\s+pam_wheel.so(\s+.*)?$/ { /^\s*auth\s+required\s+pam_wheel.so(\s+\S+)*(\s+use_uid)(\s+.*)?$/! s/^(\s*auth\s+required\s+pam_wheel.so)(\s+.*)?$/\1 use_uid\2/ }' /etc/pam.d/su || echo "auth required pam_wheel.so use_uid" >> /etc/pam.d/su)"
amz_5_6=$?
if [[ "$amz_5_6" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure access to the su command is restricted"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure access to the su command is restricted"
  fail=$((fail + 1))
fi

############################################################################################################################

##Category 6.1 System Maintenance - System File Permissions
echo
echo -e "${BLUE}6.1 System Maintenance - System File Permissions${NC}"

# Ensure permissions on /etc/passwd are configured
echo
echo -e "${RED}6.1.2${NC} Ensure permissions on /etc/passwd are configured"
amz_6_1_2="$(chmod -t,u+r+w-x-s,g+r-w-x-s,o+r-w-x /etc/passwd)"
amz_6_1_2=$?
if [[ "$amz_6_1_2" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure permissions on /etc/passwd are configured"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure permissions on /etc/passwd are configured"
  fail=$((fail + 1))
fi

# Ensure permissions on /etc/shadow are configured
echo
echo -e "${RED}6.1.3${NC} Ensure permissions on /etc/shadow are configured"
amz_6_1_3="$(chmod -t,u-x-s,g-w-x-s,o-r-w-x /etc/shadow)"
amz_6_1_3=$?
if [[ "$amz_6_1_3" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure permissions on /etc/shadow are configured"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure permissions on /etc/shadow are configured"
  fail=$((fail + 1))
fi

# Ensure permissions on /etc/group are configured
echo
echo -e "${RED}6.1.4${NC} Ensure permissions on /etc/group are configured"
amz_6_1_4="$(chmod -t,u+r+w-x-s,g+r-w-x-s,o+r-w-x /etc/group)"
amz_6_1_4=$?
if [[ "$amz_6_1_4" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure permissions on /etc/group are configured"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure permissions on /etc/group are configured"
  fail=$((fail + 1))
fi

# Ensure permissions on /etc/gshadow are configured
echo
echo -e "${RED}6.1.5${NC} Ensure permissions on /etc/gshadow are configured"
amz_6_1_5="$(chmod -t,u-x-s,g-w-x-s,o-r-w-x /etc/gshadow)"
amz_6_1_5=$?
if [[ "$amz_6_1_5" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure permissions on /etc/gshadow are configured"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure permissions on /etc/gshadow are configured"
  fail=$((fail + 1))
fi

# Ensure permissions on /etc/passwd- are configured
echo
echo -e "${RED}6.1.6${NC} Ensure permissions on /etc/passwd- are configured"
amz_6_1_6="$(chmod -t,u-x-s,g-r-w-x-s,o-r-w-x /etc/passwd-)"
amz_6_1_6=$?
if [[ "$amz_6_1_6" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure permissions on /etc/passwd- are configured"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure permissions on /etc/passwd- are configured"
  fail=$((fail + 1))
fi

# Ensure permissions on /etc/shadow- are configured
echo
echo -e "${RED}6.1.7${NC} Ensure permissions on /etc/shadow- are configured"
amz_6_1_7="$(chmod -t,u-x-s,g-r-w-x-s,o-r-w-x /etc/shadow-)"
amz_6_1_7=$?
if [[ "$amz_6_1_7" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure permissions on /etc/shadow- are configured"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure permissions on /etc/shadow- are configured"
  fail=$((fail + 1))
fi

# Ensure permissions on /etc/group- are configured
echo
echo -e "${RED}6.1.8${NC} Ensure permissions on /etc/group- are configured"
amz_6_1_8="$(chmod -t,u-x-s,g-r-w-x-s,o-r-w-x /etc/group-)"
amz_6_1_8=$?
if [[ "$amz_6_1_8" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure permissions on /etc/group- are configured"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure permissions on /etc/group- are configured"
  fail=$((fail + 1))
fi

# Ensure permissions on /etc/gshadow- are configured
echo
echo -e "${RED}6.1.9${NC} EEnsure permissions on /etc/gshadow- are configured"
amz_6_1_9="$(chmod -t,u-x-s,g-r-w-x-s,o-r-w-x /etc/gshadow-)"
amz_6_1_9=$?
if [[ "$amz_6_1_9" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure permissions on /etc/gshadow- are configured"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure permissions on /etc/gshadow- are configured"
  fail=$((fail + 1))
fi

############################################################################################################################

##Category 6.2 System Maintenance - User and Group Settings
echo
echo -e "${BLUE}6.2 System Maintenance - User and Group Settings${NC}"

# Ensure no legacy &quot;+&quot; entries exist in /etc/passwd
echo
echo -e "${RED}6.2.2${NC} Ensure no legacy + entries exist in /etc/passwd"
amz_6_2_2="$(sed -ri '/^\+:.*$/ d' /etc/passwd)"
amz_6_2_2=$?
if [[ "$amz_6_2_2" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure no legacy + entries exist in /etc/passwd"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure no legacy + entries exist in /etc/passwd"
  fail=$((fail + 1))
fi

# Ensure no legacy &quot;+&quot; entries exist in /etc/shadow
echo
echo -e "${RED}6.2.3${NC} Ensure no legacy + entries exist in /etc/shadow"
amz_6_2_3="$(sed -ri '/^\+:.*$/ d' /etc/shadow)"
amz_6_2_3=$?
if [[ "$amz_6_2_3" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure no legacy + entries exist in /etc/shadowd"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure no legacy + entries exist in /etc/shadowd"
  fail=$((fail + 1))
fi

# Ensure no legacy &quot;+&quot; entries exist in /etc/group
echo
echo -e "${RED}6.2.4${NC} Ensure no legacy + entries exist in /etc/group"
amz_6_2_4="$(sed -ri '/^\+:.*$/ d' /etc/group)"
amz_6_2_4=$?
if [[ "$amz_6_2_4" -eq 0 ]]; then
  echo -e "${GREEN}Remediated:${NC} Ensure no legacy + entries exist in /etc/group"
  success=$((success + 1))
else
  echo -e "${RED}UnableToRemediate:${NC} Ensure no legacy + entries exist in /etc/group"
  fail=$((fail + 1))
fi

###########################################################################################################################

echo
echo -e "${GREEN}Remediation script for Amazon linux 2 executed successfully!!${NC}"
echo
echo -e "${YELLOW}Summary:${NC}"
echo -e "${YELLOW}Remediation Passed:${NC} $success" 
echo -e "${YELLOW}Remediation Failed:${NC} $fail"

###########################################################################################################################
