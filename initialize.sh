#!/bin/bash
# Initialize things for building micropython

# Get the standard repo if not already here
if [ -d /opt/micropython/micropython ]; then
	echo "micropython repo apparently already here"
else
	echo "cloning official micropython repo to depth 1"
	(cd /opt/micropython; git clone --depth 1 https://github.com/micropython/micropython.git)
fi

# Make the deploy scripts to run on the host of this container, for hardware access
# Mac Docker doesn't have access to USB becasue the linux VM it uses does not
echo -n "Making deploy scripts ..."
DEPLOY_="/opt/micropython/micropython/ports/stm32/deploy"
cd `dirname ${DEPLOY_}`

# FIXME: use a foreach loop
D_="${DEPLOY_}_v10.sh"
echo -n " ${D_}"
echo '#!/bin/sh' > ${D_}
echo '# make -n BOARD=PYBV10 deploy | tail -2' >> ${D_}
make -n BOARD=PYBV10 deploy | tail -2 >> ${D_}
chmod a+x ${D_}

D_="${DEPLOY_}_v11.sh"
echo -n " ${D_}"
echo '#!/bin/sh' > ${D_}
echo '# make -n BOARD=PYBV11 deploy | tail -2' >> ${D_}
make -n BOARD=PYBV11 deploy | tail -2 >> ${D_}
chmod a+x ${D_}

echo -e '\n\n\n'
echo "To make the stm32 ports, do:"
echo "$ makeall.sh"
echo
echo "Note:"
echo "Docker on a Mac does not have access to the host USB. Consequently,"
echo "to deploy from a Mac host, you will need to have libusb and pyusb, e.g. by doing:"
echo "$ brew install libusb"
echo "$ python3 -m pip install pyusb"
echo "Then you can do e.g."
echo "$ ${D_}"
echo "after putting the pyboard in bootloader mode, which can be done from the REPL:"
echo ">>> pyb.bootloader()"
echo "or maybe"
echo ">>> machine.bootloader()"
echo "or via the "
