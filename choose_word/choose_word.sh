#!/bin/bash
cat $2 | head -$3 | tail -1 | tr '[a-z]' '[A-Z]'
