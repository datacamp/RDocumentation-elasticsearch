FROM logstash:2.3

RUN curl -o /tmp/aws-env-linux-amd64 -L https://github.com/datacamp/aws-env/releases/download/v0.1-session-fix/aws-env-linux-amd64 && \
    chmod +x /tmp/aws-env-linux-amd64 && \
    mv /tmp/aws-env-linux-amd64 /bin/aws-env

RUN logstash-plugin install --version 3.0.2 logstash-input-jdbc
RUN logstash-plugin install logstash-filter-json_encode

RUN rm -f /usr/share/logstash/pipeline/logstash.conf

ADD pipeline/ /usr/share/logstash/pipeline/
ADD config/ /usr/share/logstash/config/
RUN mkdir -p /usr/share/logstash/jdbc

# Connector/J 5.1.49 is the final 5.1 release and supports explicit TLS
# protocol selection. The legacy 5.1.40 driver only offers TLSv1/TLSv1.1
# by default, which is incompatible with current RDS configuration.
RUN set -eux; \
    curl --fail --location --proto '=https' --tlsv1.2 \
      https://repo1.maven.org/maven2/mysql/mysql-connector-java/5.1.49/mysql-connector-java-5.1.49.jar \
      --output /usr/share/logstash/jdbc/mysql-connector-java-5.1.49-bin.jar; \
    echo '5bba9ff50e5e637a0996a730619dee19ccae274883a4d28c890d945252bb0e12  /usr/share/logstash/jdbc/mysql-connector-java-5.1.49-bin.jar' | sha256sum -c -

# The runtime database is an AWS RDS instance. Build a Java truststore from
# AWS's public RDS CA bundle so Connector/J can verify the server certificate.
RUN set -eux; \
    curl --fail --location --proto '=https' --tlsv1.2 \
      https://truststore.pki.rds.amazonaws.com/us-west-1/us-west-1-bundle.pem \
      --output /tmp/rds-global-bundle.pem; \
    echo '9ba000312920fc8033d9d59b9b6ba8b18fbed8dc989fb6bdfeab3e8df9c67a7f  /tmp/rds-global-bundle.pem' | sha256sum -c -; \
    awk 'BEGIN { certificate = 0 } /-----BEGIN CERTIFICATE-----/ { certificate++; file = sprintf("/tmp/rds-ca-%03d.pem", certificate) } file { print > file } /-----END CERTIFICATE-----/ { close(file); file = "" }' /tmp/rds-global-bundle.pem; \
    for cert in /tmp/rds-ca-*.pem; do \
      alias_name=$$(basename "$$cert" .pem); \
      keytool -importcert -noprompt -trustcacerts \
        -alias "$$alias_name" -file "$$cert" \
        -keystore /usr/share/logstash/jdbc/rds-global-bundle.jks \
        -storetype JKS -storepass changeit; \
    done; \
    rm -f /tmp/rds-global-bundle.pem /tmp/rds-ca-*.pem
