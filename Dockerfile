FROM fuzzers/libfuzzer:12.0

RUN apt-get update
RUN apt install -y build-essential  wget git clang cmake  xz-utils automake autotools-dev  libtool zlib1g zlib1g-dev libssl-dev curl
RUN wget https://github.com/Kitware/CMake/releases/download/v3.20.1/cmake-3.20.1.tar.gz
RUN tar xvfz cmake-3.20.1.tar.gz
WORKDIR /cmake-3.20.1
RUN ./bootstrap
RUN make
RUN make install
WORKDIR /
RUN git clone https://github.com/Dobiasd/FunctionalPlus.git
WORKDIR /FunctionalPlus
RUN cmake -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ .
RUN make
RUN make install
COPY fuzzers/fuzz.cpp .
RUN clang++ -I/usr/local/include -fsanitize=fuzzer,address fuzz.cpp -o /fuzz

ENTRYPOINT []
CMD ["/fuzz"]
