FROM registry.stage.redhat.io/ubi8/ubi:8.3

LABEL com.redhat.component="support-tools-container"
LABEL name="rhel8/support-tools"
LABEL version="8.3"
LABEL maintainer="Red Hat, Inc."
LABEL usage="podman container runlabel RUN rhel8/support-tools"

LABEL run="podman run -it --name NAME --privileged --ipc=host --net=host --pid=host -e HOST=/host -e NAME=NAME -e IMAGE=IMAGE -v /run:/run -v /var/log:/var/log -v /etc/machine-id:/etc/machine-id -v /etc/localtime:/etc/localtime -v /:/host IMAGE"

#labels for container catalog
LABEL summary="A set of tools to analyze the host system."
LABEL description="The Red Hat Enterprise Linux Support Tools image contains tools to analyze the host system including sosreport and sos-collector"
LABEL io.k8s.description="The Red Hat Enterprise Linux Support Tools image contains tools to analyze the host system including sosreport and sos-collector"
LABEL io.k8s.display-name="Red Hat Enterprise Linux Support Tools"
LABEL io.openshift.tags="sosreport, support"
LABEL io.openshift.expose-services=""


RUN INSTALL_PKGS="sos sos-collector redhat-support-tool vim-minimal tcpdump mtr strace telnet" && \
    yum -y install $INSTALL_PKGS && \
    rpm -V --nosize --nofiledigest --nomtime $INSTALL_PKGS && \
    yum clean all && \
    rm -rf /usr/local/man

CMD ["/usr/bin/bash"]
