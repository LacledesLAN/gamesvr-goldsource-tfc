# escape=`
FROM lacledeslan/gamesvr-goldsource

HEALTHCHECK NONE

ARG BUILDNODE=unspecified
ARG SOURCE_COMMIT=unspecified

LABEL com.lacledeslan.build-node=$BUILDNODE `
      org.label-schema.schema-version="1.0" `
      org.label-schema.url="https://github.com/LacledesLAN/README.1ST" `
      org.label-schema.vcs-ref=$SOURCE_COMMIT `
      org.label-schema.vendor="Laclede's LAN" `
      org.label-schema.description="LL Team Fortress Classic Dedicated Freeplay Server" `
      org.label-schema.vcs-url="https://github.com/LacledesLAN/gamesvr-goldsource-tfc"

COPY --chown=GoldSource:root ./amxmod/metamod/metamod.so /app/tfc/addons/metamod/dlls/metamod.so

COPY --chown=GoldSource:root ./amxmod/amxmodx_base /app/tfc/addons/amxmodx

COPY --chown=GoldSource:root ./amxmod/amxmodx_addon_tfc /app/tfc/addons/amxmodx

COPY --chown=GoldSource:root ./amxmod/amxmodx_ll-config /app/tfc/addons/amxmodx

COPY --chown=GoldSource:root ./dist/tfc /app/tfc

COPY --chown=GoldSource:root ./dist/linux/ll-tests /app/ll-tests

# UPDATE USERNAME & ensure permissions
RUN usermod -l TFC GoldSource &&`
    chmod +x /app/ll-tests/*.sh &&`
    mkdir -p /app/tfc/logs &&`
    chmod 775 /app/tfc/logs;

RUN echo 20 > /app/steam_appid.txt;

USER TFC

WORKDIR /app

CMD ["/bin/bash"]

ONBUILD USER root
