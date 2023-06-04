import pkg from "lodash";
const { merge } = pkg;

// import resolvers
import { user_resolvers } from "./user_resolver/user.resolver.js";

export const resolvers = merge(user_resolvers);
