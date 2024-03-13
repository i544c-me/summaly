ARG NODE_VERSION=20.11.1-buster-slim

FROM node:${NODE_VERSION}

COPY . /workspace
WORKDIR /workspace

RUN apt-get update && \
		apt-get install -y --no-install-recommends tini && \
	  corepack enable
RUN pnpm i --frozen-lockfile --aggregate-output && \
	  pnpm run build

EXPOSE 3000
ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["pnpm", "run", "serve"]
