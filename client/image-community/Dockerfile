FROM rkrahl/opensuse:15.5

RUN zypper --non-interactive addrepo https://download.opensuse.org/repositories/home:/Rotkraut:/Data/15.5/home:Rotkraut:Data.repo && \
    zypper --non-interactive --gpg-auto-import-keys refresh home_Rotkraut_Data && \
    zypper --non-interactive install \
	less \
	mariadb-client \
	python-icat-examples \
	python-icat-man \
	python311 \
	python311-PyYAML \
	python311-icat \
	python311-lxml && \
    ln -sf ../usr/share/zoneinfo/Europe/Berlin /etc/localtime

RUN groupadd -r -g 801 icat && \
    useradd -c "User" -d /home/user -g users -G icat user && \
    mkdir -p /home/user/.config/icat /home/user/bin && \
    chmod -R go-rwx /home/user/.config
COPY bashrc /home/user/.bashrc
COPY icatsh /home/user/bin
RUN chown -R user:users /home/user

USER user
WORKDIR /home/user
ENV LC_ALL en_US.UTF-8

CMD ["bash"]
