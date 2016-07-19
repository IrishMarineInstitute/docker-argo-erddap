FROM tomcat:8-jre8
MAINTAINER fullergalway
RUN rm -rf /usr/local/tomcat/webapps/ROOT /usr/local/tomcat/webapps/examples /usr/local/tomcat/webapps/docs
RUN wget -O /usr/local/tomcat/webapps/erddap.war https://coastwatch.pfeg.noaa.gov/erddap/download/erddap1.73.war
RUN wget -O /tmp/fonts.zip "http://coastwatch.pfeg.noaa.gov/erddap/download/BitstreamVeraSans.zip"
RUN unzip -d /usr/share/fonts /tmp/fonts.zip
RUN wget -O /tmp/content.zip http://coastwatch.pfeg.noaa.gov/erddap/download/erddapContent.zip
RUN unzip -d /usr/local/tomcat /tmp/content.zip
RUN mkdir -p /tmp/erddap && chmod 777 /tmp/erddap
RUN mkdir -p /usr/local/tomcat/webapps/ROOT && mkdir -p /usr/local/tomcat/content
RUN apt-get update
RUN apt-get install -y python-pip build-essential git python-dev netcat
RUN echo v 1 > /dev/null # change this line for a fresh argoCollector
RUN git clone https://github.com/IrishMarineInstitute/argoCollector.git /app
RUN pip install -r /app/requirements-no-scipy-or-kafka.txt
COPY index.jsp /usr/local/tomcat/webapps/ROOT/
COPY content /usr/local/tomcat/content/
RUN mkdir -p /home/yourName/erddap
COPY argo.json /app/argo.json
COPY update_floats /usr/local/bin/
COPY update_flag_key /usr/local/bin/
COPY add_float /usr/local/bin/
COPY del_float /usr/local/bin/
COPY baseUrl /usr/local/bin
RUN update_floats
