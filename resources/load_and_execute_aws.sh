#!/bin/bash
####################################################################### 
# "PROJECT_S3_LOCATION"
# location of the ZIP file with the Pentaho ETL Jobs and Transformations to use 
#
# "PROJECT_STARTUP_JOB"
# filename of the job to be executed
#
# "LOG_LEVEL"
# values are [Basic / Debug] 
#######################################################################


TMPDIR=/opt/pentaho/project
TMPFILE=${TMPDIR}/project.zip
BASENAME="${0##*/}"

# Standard function to print an error and exit with a failing return code 
error_exit () {
  echo "${BASENAME} - ${1}" >&2
  exit 1 
}

# Create a temporary file and download the zip file
mkdir -p ${TMPDIR}
# retrieve file from aws s3
aws s3 cp "${PROJECT_S3_LOCATION}" - > "${TMPFILE}" || error_exit "Failed to download S3 zip file from ${PROJECT_S3_LOCATION}"

# Create a temporary directory and unpack the zip file
cd "${TMPDIR}" || error_exit "Unable to cd to temporary directory."
unzip -q "${TMPFILE}" || error_exit "Failed to unpack zip file."
kitchen.sh -file=${PROJECT_STARTUP_JOB}