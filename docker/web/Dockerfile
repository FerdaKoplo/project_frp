FROM node:20-slim

RUN corepack enable && corepack prepare pnpm@9.0.0 --activate

WORKDIR /workspace

# Install once using the lockfile; source is mounted at runtime.
COPY pnpm-workspace.yaml package.json ./
COPY app/web/package.json app/web/pnpm-lock.yaml app/web/.npmrc ./app/web/

RUN pnpm install --frozen-lockfile --filter web...

EXPOSE 5173

CMD ["pnpm", "--filter", "web", "exec", "vite", "dev", "--host", "0.0.0.0"]
