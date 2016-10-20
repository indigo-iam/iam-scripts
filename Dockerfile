FROM centos:centos7

RUN yum -y install epel-release; yum clean all
RUN yum -y install g++ gcc vim jq python-devel python-pip sudo; yum clean all
RUN pip install virtualenv python-openstackclient
RUN adduser --uid 501 iam && usermod -a -G wheel iam

ADD ./*.sh /home/iam/
RUN chmod 777 /home/iam/*.sh
RUN sed -i '251,254d' /usr/lib/python2.7/site-packages/keystoneauth1/identity/v3/oidc.py

USER iam
WORKDIR /home/iam
