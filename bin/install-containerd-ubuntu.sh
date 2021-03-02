#!/bin/sh
#########################################################################
#      Copyright (C) 2020        Sebastian Francisco Colomar Bauza      #
#      SPDX-License-Identifier:  GPL-2.0-only                           #
#########################################################################
set -x                                                                  ;
#########################################################################
command=apt                                                             ;
engine=containerd                                                       ;
sleep=10                                                                ;
#########################################################################
sudo ${command} update -y                                               ;
#########################################################################
for package in                                                          \
        ${engine}                                                       \
                                                                        ;
do                                                                      \
        while true                                                      ;
        do                                                              \
                ${command} list                                         \
                        --installed                                     \
                |                                                       \
                grep                                                    \
                        ${package}                                      \
                &&                                                      \
                break                                                   ;
                sudo ${command} install -y                              \
                        ${package}                                      \
                                                                        ;
                sleep ${sleep}                                          ;
        done                                                            ;
done                                                                    ;
#########################################################################
sudo mkdir -p /etc/${engine}						;
sudo mkdir -p /etc/systemd/system/${engine}.service.d                   ;
#########################################################################
${engine} config default | sudo tee /etc/${engine}/config.toml          ;
#########################################################################
sudo systemctl restart ${engine}					;
sudo systemctl enable --now ${engine}					;
#########################################################################
