FROM daocloud.io/library/centos:latest
MAINTAINER mloves0824 "mloves0824@163.com"
#RUN yum -y groupinstall 'Development Tools' && yum -y install zlib-devel wget fuse-devel git psmisc &&\
#    cd / && git clone https://github.com/baidu/bfs.git &&\
    # sed -i '4a FUSE_PATH=/usr/include/fuse/' /bfs/Makefile &&\
#    cd /bfs && ./build.sh && cd sandbox && ./deploy.sh &&\
#    yum -y groupremove 'Development Tools' && yum clean all &&\
#    cd ../ && rm -rf thirdparty thirdsrc .build .git src

RUN yum -y install zlib-devel wget fuse-devel git psmisc
RUN mkdir -p /root/bfs
ADD chunkserver nameserver bfs_client /root/bfs/
ADD sandbox /root/bfs/sandbox
RUN cd /root/bfs/sandbox && ./deploy.sh
EXPOSE 8827 8828 8829
WORKDIR /root/bfs/sandbox/
CMD ./start_bfs.sh && tail -f /dev/null
