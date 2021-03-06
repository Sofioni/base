# This is the base for contrail specific children

FROM omermajeed/contrail-vpp-general-base:v1.0
ARG CONTRAIL_REGISTRY
ARG CONTRAIL_CONTAINER_TAG

ARG BASE_EXTRA_RPMS=""

RUN sed -i 's/notify_only=.*/notify_only=0/' /etc/yum/pluginconf.d/search-disabled-repos.conf

# note: ldconfig looks strange. contrail-lib installs shared libraries but do not call it...
RUN mkdir -p -m 777 /var/crashes && \
    BASE_EXTRA_RPMS=$(echo $BASE_EXTRA_RPMS | tr -d '"' | tr ',' ' ') && \
    if [[ -n "$BASE_EXTRA_RPMS" ]] ; then \
        echo "INFO: contrail-base: install $BASE_EXTRA_RPMS" ; \
        yum install -y $BASE_EXTRA_RPMS ; \
    fi && \
    yum install -y contrail-lib contrail-setup contrail-utils python-contrail && \
    ldconfig

COPY *.sh /
COPY license.txt /licenses/

ENV PS1="\033[1m($(printenv NODE_TYPE)-$(printenv SERVICE_NAME))\033[m\017[$(id -un)@$(hostname -s) $(pwd)]$ "

CMD ["/usr/bin/tail","-f","/dev/null"]

#USER sofioni
MAINTAINER omer.majeed@sofioni.com
LABEL sofioni.tf-vpp.service=base
LABEL sofioni.tf-vpp.container.name=base
LABEL build-date=20190320
LABEL name=base \
      vendor="Sofioni" \
      version="1.0" \
      release="1" \
      summary="base container that vpp-base would use" \
      description="it has basic libraries installed, used by other containers to build on this one"
