FROM centos:7.7.1908

LABEL MAINTAINER=zhouzb

ADD jdk-8u251-linux-x64.tar.gz /usr/local/
ADD apache-tomcat-8.5.54.tar.gz /usr/local/

# 覆盖相关文件
COPY server.xml /usr/local/apache-tomcat-8.5.54/conf/

ENV JAVA_HOME /usr/local/jdk1.8.0_251
ENV JRE_HOME $JAVA_HOME/jre
ENV CLASSPATH $CLASSPATH:$JAVA_HOME/lib;$JRE_HOME/lib
ENV LD_LIBRARY_PATH $JAVA_HOME
ENV CATALINA_HOME /usr/local/apache-tomcat-8.5.54
ENV PATH $PATH:$JAVA_HOME/bin:$CATALINA_HOME/lib:$CATALINA_HOME/bin

ENV TZ="Asia/Shanghai"
ENV JAVA_OPTS="\
-server \
-Xms3g \
-Xmx3g \
-Xmn512m \
-Xss512K \
-Dfile.encoding=UTF-8 \
-verbose:gc \
-XX:+UseConcMarkSweepGC \
-XX:MaxTenuringThreshold=10 \
-XX:+ExplicitGCInvokesConcurrent \
-XX:GCTimeRatio=19 \
-XX:+UseParNewGC \
-XX:+UseCMSCompactAtFullCollection \
-XX:CMSFullGCsBeforeCompaction=10 \
-XX:+CMSClassUnloadingEnabled \
-XX:+CMSParallelRemarkEnabled \
-XX:CMSInitiatingOccupancyFraction=50 \
-Xnoclassgc \
-XX:SoftRefLRUPolicyMSPerMB=0"

EXPOSE 8080

# 容器启动时运行tomcat
CMD /usr/local/apache-tomcat-8.5.50/bin/catalina.sh run