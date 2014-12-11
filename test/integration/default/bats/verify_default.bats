@test "iptables is installed" {
  which iptables
}

@test "iptables is started" {
  service iptables status
}

@test "iptables is enabled" {
  chkconfig --list iptables | grep 3:on
}

@test "iptables has an ssh rule" {
  iptables -L | grep dpt:ssh
}

@test "iptables has two drop rules" {
  [ 2 = $(iptables -L | grep DROP | wc -l) ]
}

