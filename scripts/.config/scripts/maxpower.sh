#!/bin/sh

echo 1 | sudo tee /sys/module/processor/parameters/ignore_ppc
echo 1 | sudo tee /sys/devices/system/cpu/cpufreq/boost
