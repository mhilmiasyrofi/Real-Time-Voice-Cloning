FROM pytorch/pytorch

WORKDIR "/workspace"
RUN apt-get clean \
        && apt-get update \
        && apt-get install -y ffmpeg libportaudio2 openssh-server python3-pyqt5 xauth \
        && apt-get -y autoremove \
        && mkdir /var/run/sshd \
        && mkdir /root/.ssh \
        && chmod 700 /root/.ssh \
        && ssh-keygen -A \
        && sed -i "s/^.*PasswordAuthentication.*$/PasswordAuthentication no/" /etc/ssh/sshd_config \
        && sed -i "s/^.*X11Forwarding.*$/X11Forwarding yes/" /etc/ssh/sshd_config \
        && sed -i "s/^.*X11UseLocalhost.*$/X11UseLocalhost no/" /etc/ssh/sshd_config \
        && grep "^X11UseLocalhost" /etc/ssh/sshd_config || echo "X11UseLocalhost no" >> /etc/ssh/sshd_config
ADD requirements.txt /workspace/requirements.txt
RUN pip install -r /workspace/requirements.txt
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCx9vOm8WdcMX6YheFShWCoGUQYUfMpTXaO1WW881QGA9x5mMkxcYT7OeSlymd/o/M1MR3bvuFKMzTgVAVYp3UHZF80qX7OkeCh45xngAqccrILRDTaUKZUHzfV+yoyv3PvaY7QfQ9F+gEvVe76L7B85jWmTbRaJjjA329y+2D2GGmbrQCS3ebavjFSeVofPSq6tvWCbd/u/Pem3AbeVBKiAX9hMlahAJ7ar/OkX+Q9v+TfTuBbxDimiJ/mLD3IpCi8wrfIux/JB2ZLDtmTnfjjUYH9IXNaauZHBKUmxKhaTtzd3Kx5Gn7/3jwu8CdZqxYmPJJL4GDLmoXkk0xMmeaFSrFn7bFP3bntU5hURj55wTmSMDClNEsuuWiYbbUVMALDOZjF37GYsepjQ6l1JZs7fVVqKL96AH9XYjYD1dw6Ncc6s3tPdiYfqOkyxfskFSnDtIAGFsi742lmg4CNrEUAELF0jmwqfs1zoLEcFz5nUxDjynPmQhKBN5nMAHYz/LVgXugh4pKJAXwhY+OLIvFAqlEn2FbkkrICHefGRdbOdScMlRYZ6JCdJrhaQ5tGxjBBW//H7oWHv+Tt8VAFJw63kV+Kk2QkZM4LlSlCZLu6dnHvMZnaBh5fV4xSj/SyijUNAwY7LccFeVblgydzozHZ3x5DPJE6OVw0xwYk+3v3Yw== mhilmiasyrofi@gmail.com" \ 
	>> /root/.ssh/authorized_keys
RUN echo "export PATH=/opt/conda/bin:$PATH" >> /root/.profile
ENTRYPOINT ["sh", "-c", "/usr/sbin/sshd && bash"]
CMD ["bash"]
