#!/usr/bin/expect
spawn /quota-bypass/login.sh
expect "**"
send "\r"
expect "Logged"
interact
