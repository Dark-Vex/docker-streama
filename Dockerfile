FROM ubuntu:16.04
MAINTAINER Daniele De Lorenzi <daniele.delorenzi@fastnetserv.net>

RUN apt update && \
    apt install curl wget openjdk-8-jdk git -y

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git clone -b master https://github.com/dularion/streama.git && \
    cd streama && ./gradlew assemble && mkdir -p /data/streama && \
    mv ./build/libs/streama-*.war /data/streama/streama.war && \
    chmod u+x /data/streama/streama.war && \
    cp docs/sample_application.yml .

# test for image scanner
RUN cat <<EOF > /root/credentials
    AWS_ACCESS_KEY=AKIAIOSFODNN7EXAMPLE
    AWS_SECRET_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
    SUPERKEY
    EOF

EXPOSE 8080

CMD ["./data/streama/streama.war"]
