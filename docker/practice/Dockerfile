FROM alpine

ENV foo=1
ARG bar=2

# Build image 時 echo
RUN echo ${foo} , ${bar}

# Run image 時 echo
CMD echo ${foo} , ${bar}