#!/bin/sh
cd dest
rsync --rsh=ssh -r -vv --progress * shlomif@shell.berlios.de:/home/groups/haifux/htdocs/lec_man/

