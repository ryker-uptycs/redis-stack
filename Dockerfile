FROM debian:bullseye-slim

RUN apt-get update -qqy
RUN apt-get upgrade -qqy
RUN apt-get install -y libssl-dev libgomp1
ADD ./redis-stack /var/cache/apt/redis-stack/
COPY ./etc/entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh
RUN touch /.dockerenv
RUN dpkg -i /var/cache/apt/redis-stack/*.deb
RUN rm -rf /var/cache/apt

EXPOSE 6379 8001

ENTRYPOINT ["/entrypoint.sh"]