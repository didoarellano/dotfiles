#!/bin/sh

emacsclient --create-frame --eval '(d-configure-floating-org-frame)' & > /dev/null 2>&1
