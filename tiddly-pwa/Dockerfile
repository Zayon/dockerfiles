FROM denoland/deno:alpine-1.36.1

ENV DB_PATH=/var/db/tiddly/pwa.db

WORKDIR /app

RUN apk add --no-cache tini && \
	wget https://codeberg.org/valpackett/tiddlypwa/archive/0.1.3.tar.gz -O - | tar -xz && \
	mv -t /app \
		tiddlypwa/server/app.ts \
		tiddlypwa/server/run.ts \
		tiddlypwa/server/pages.ts \
		tiddlypwa/server/sqlite.ts \
		tiddlypwa/server/hash-admin-password.ts \
		tiddlypwa/server/data.d.ts && \
	rm -rf tiddlypwa

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/sbin/tini", "--", "/docker-entrypoint.sh"]

CMD ["/bin/deno", "run", \
     "--unstable", \
     "--allow-env", \
     "--allow-read=/var/db/tiddly", \
     "--allow-write=/var/db/tiddly", \
     "--allow-net=:8000", \
     "/app/run.ts"]
