FROM pentaho/pdi:8.3
ENV PROJECT_STARTUP_JOB=
ENV KETTLE_LOG_LEVEL=Basic
USER root
COPY --chown=pentaho:pentaho ./resources/ ${PENTAHO_HOME}
RUN apk update; apk add --no-cache wget python groff; rm -rf /var/cache/apk/*
RUN wget https://bootstrap.pypa.io/get-pip.py; python get-pip.py; pip install awscli; rm -f get- pip.py
VOLUME ["/opt/pentaho/project"]
USER pentaho
ENTRYPOINT ["/opt/pentaho/load_and_execute.sh"]