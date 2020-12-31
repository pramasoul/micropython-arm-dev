#!/bin/bash
cd /opt/micropython/micropython/mpy-cross
make -j 4
cd /opt/micropython/micropython/ports/stm32
make -j 4 submodules
make -j 4 BOARD=PYBV10
make -j 4 BOARD=PYBV11
