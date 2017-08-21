#! /usr/bin/perl

while (1) {
    `ssh -p 11113 user101\@localhost \"echo 1\"`;
    sleep(10)
}
