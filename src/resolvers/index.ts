import pkg from "lodash";
const { merge } = pkg;

// import resolvers
import { user_resolvers } from "./user_resolver/user.resolver.js";
import { student_resolvers } from "./student_info_resolver/student_info.resolvers.js";

export const resolvers = merge(user_resolvers, student_resolvers);
