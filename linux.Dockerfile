FROM lacledeslan/gamesvr-goldsource

HEALTHCHECK NONE

ARG BUILD_NODE=unspecified
ARG GIT_REVISION=unspecified

LABEL architecture="amd64" \
    com.lacledeslan.build-node="$BUILD_NODE" \
    maintainer="Laclede's LAN <contact@lacledeslan.com>" \
    org.opencontainers.image.description="Laclede's LAN Team Fortress Classic Dedicated Freeplay Server" \
    org.opencontainers.image.revision="$GIT_REVISION" \
    org.opencontainers.image.source="https://github.com/LacledesLAN/gamesvr-goldsource-tfc" \
    org.opencontainers.image.vendor="Laclede's LAN"

COPY --chown=GoldSource:root ./amxmod/metamod/metamod.so /app/tfc/addons/metamod/dlls/metamod.so

COPY --chown=GoldSource:root ./amxmod/amxmodx_base /app/tfc/addons/amxmodx

COPY --chown=GoldSource:root ./amxmod/amxmodx_addon_tfc /app/tfc/addons/amxmodx

COPY --chown=GoldSource:root ./amxmod/amxmodx_ll-config /app/tfc/addons/amxmodx

COPY --chown=GoldSource:root ./dist/tfc /app/tfc

COPY --chown=GoldSource:root ./dist/linux/ll-tests /app/ll-tests

# UPDATE USERNAME & ensure permissions
RUN usermod -l TFC GoldSource && \
    chmod +x /app/ll-tests/*.sh && \
    mkdir -p /app/tfc/logs && \
    chmod 775 /app/tfc/logs;

RUN echo 20 > /app/steam_appid.txt;

USER TFC

WORKDIR /app

CMD ["/bin/bash"]

ONBUILD USER root
