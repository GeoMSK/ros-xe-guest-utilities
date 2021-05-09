FROM ubuntu:20.04

RUN apt-get update && apt-get install xe-guest-utilities
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/sbin/xe-daemon"]
