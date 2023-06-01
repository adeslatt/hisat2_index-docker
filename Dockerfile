# Install the conda environment
FROM continuumio/miniconda3
LABEL description="Base docker image with conda and util libraries"

# specific for this docker details in the environment.yml
ARG ENV_NAME="hisat2"

COPY environment.yml /

# Install procps so that Nextflow can poll CPU usage
RUN apt-get update && \
    apt-get install -y procps && \
    apt-get clean -y && \
    conda env create --quiet --name ${ENV_NAME} --file /environment.yml && \
    conda clean -a

# Add conda installation dir to PATH (instead of doing 'conda activate')
ENV PATH /opt/conda/envs/${ENV_NAME}/bin:$PATH

ARG ENV_NAME="samtools"
ARG VERSION="1.17"

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y install gcc mono-mcs && \
    apt-get -y install libncurses5-dev libncursesw5-dev && \
    apt-get -y install zlib1g zlib1g-dev && \
    apt-get -y install bzip2 libbz2-dev && \
    apt-get -y install liblzma-dev && \
    apt-get -y install libhtscodecs2 && \
    apt-get -y install build-essential && \
    apt-get -y install wget && \
    rm -rf /var/lib/apt/lists/*

# need to get, configure and make samtools to have this docker work
RUN wget https://github.com/samtools/samtools/releases/download/${VERSION}/samtools-${VERSION}.tar.bz2 && \
    bzip2 -d samtools-${VERSION}.tar.bz2 && \
    tar xvf samtools-${VERSION}.tar && \
    cd samtools-${VERSION} && \
    ./configure && \
    make && \
    make install
    