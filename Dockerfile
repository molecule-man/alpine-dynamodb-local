FROM anapsix/alpine-java:jre7

WORKDIR /dynamodb-local

RUN apk add --update-cache curl && \
    curl -Lo dynamodb_local_latest.tar.gz http://dynamodb-local.s3-website-us-west-2.amazonaws.com/dynamodb_local_latest.tar.gz && \
    tar -xzf dynamodb_local_latest.tar.gz && \
    rm dynamodb_local_latest.tar.gz && \
    apk del curl

RUN mkdir /data

EXPOSE 8000

ENTRYPOINT ["java", "-Djava.library.path=./DynamoDBLocal_lib", "-jar", "DynamoDBLocal.jar"]
CMD ["-sharedDb", "-dbPath", "/data"]
