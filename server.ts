import { ApolloServer } from "@apollo/server";
import { expressMiddleware } from "@apollo/server/express4";
import express from "express";
import http from "http";
import cors from "cors";
import bodyParser from "body-parser";
import { ApolloServerPluginUsageReportingDisabled } from "@apollo/server/plugin/disabled";
import { gql } from "graphql-tag";
import { readFileSync } from "fs";
import { resolvers } from "./src/resolvers/index.js";
import { Context, prisma } from "./src/contexts.js";
import { buildSubgraphSchema } from "@apollo/subgraph";
import { applyMiddleware } from "graphql-middleware";
const typeDefs = gql(readFileSync("./schema.graphql", { encoding: "utf-8" }));
import dotenv from "dotenv";
import { getUserFromToken } from "./src/helpers/getUserInfo.js";
dotenv.config();

const schema = applyMiddleware(
    buildSubgraphSchema({
        typeDefs,
        resolvers,
    })
);

const app = express();
const httpServer = http.createServer(app);

// Set up Apollo Server
const server = new ApolloServer<Context>({
    schema,
    plugins: [ApolloServerPluginUsageReportingDisabled()],
});
await server.start();

app.use(
    cors(),
    bodyParser.json(),
    expressMiddleware(server, {
        context: async ({ req }: any): Promise<Context> => {
            const userInfo = getUserFromToken(req.headers.authorization);
            return {
                prisma,
                userInfo,
            };
        },
    })
);

const port = process.env.PORT;

await new Promise((resolve: any) => httpServer.listen({ port }, resolve));
// eslint-disable-next-line no-console
console.log(`🚀 Server ready at http://localhost:${port}`);
