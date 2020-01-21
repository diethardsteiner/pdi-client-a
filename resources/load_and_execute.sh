#!/bin/bash
####################################################################### 
# "PROJECT_STARTUP_JOB"
# path to Kettle job from within volume
#
# "KETTLE_LOG_LEVEL"
# values are [Basic / Debug] 
#######################################################################


BASENAME="${0##*/}"

# Standard function to print an error and exit with a failing return code 
error_exit () {
  echo "${BASENAME} - ${1}" >&2
  exit 1 
}

# retrieve files from volume
# ... done via Dockerfile via specifying a volume ... 

# Run main job
kitchen.sh \
  -file=/opt/pentaho/project/${PROJECT_STARTUP_JOB} \
  -level=${KETTLE_LOG_LEVEL}