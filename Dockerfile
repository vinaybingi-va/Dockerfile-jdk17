
FROM quay.vapo.va.gov/vapo_tst_images/ubi8

RUN yum install -y nano wget && yum clean all

RUN yum install -y java-17-openjdk-devel

# Maven installation
RUN wget https://dlcdn.apache.org/maven/maven-3/3.8.8/binaries/apache-maven-3.8.8-bin.tar.gz --no-check-certificate && \
    mkdir -p /usr/local/maven

RUN tar -zxvf apache-maven-3.8.8-bin.tar.gz --strip-components 1 -C /usr/local/maven
ENV PATH=$PATH:/usr/local/maven/bin

RUN mkdir app
RUN chmod -R 777 /app

WORKDIR /app

RUN mvn archetype:generate -B -DarchetypeGroupId=org.apache.maven.archetypes -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.1 -DgroupId=com.company -DartifactId=project -Dversion=1.0-SNAPSHOT -Dpackage=com.company.project

WORKDIR /app/project

RUN mvn package

CMD tail -f /dev/null
