FROM alpine as build

RUN apk add g++ make

WORKDIR /usr/src

ADD https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7cENtOXlicTFaRUE /usr/src/mecab-0.996.tar.gz
ADD https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7MWVlSDBCSXZMTXM /usr/src/mecab-ipadic-2.7.0-20070801.tar.gz

RUN tar zxfv mecab-0.996.tar.gz \
 && tar zxfv mecab-ipadic-2.7.0-20070801.tar.gz

WORKDIR /usr/src/mecab-0.996

RUN ./configure --with-charset=utf8 --enable-utf8-only
RUN make -j4
RUN make check
RUN make install

WORKDIR /usr/src/mecab-ipadic-2.7.0-20070801
RUN ./configure --with-charset=utf8 --enable-utf8-only
RUN make -j4
RUN make install

WORKDIR /root

FROM alpine

RUN apk add --no-cache \
    libstdc++

COPY --from=build /usr/local/bin /usr/local/bin
COPY --from=build /usr/local/etc /usr/local/etc
COPY --from=build /usr/local/lib /usr/local/lib
COPY --from=build /usr/local/libexec /usr/local/libexec

