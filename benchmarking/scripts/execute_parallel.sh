#!/bin/bash
parallel --progress --jobs=$(nproc) < "./scripts/tmp/$1.jobs"
