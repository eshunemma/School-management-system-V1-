import pkg from "lodash";
const { merge } = pkg;

// import resolvers
import { user_resolvers } from "./user_resolver/user.resolver.js";
import { student_resolvers } from "./student_info_resolver/student_info.resolvers.js";
import { staff_resolvers } from "./staff_resolver/staff.resolver.js";
import { class_resolvers } from "./class_resolver/class.resolvers.js";
import { department_resolvers } from "./department_resolver/department.resolvers.js";

export const resolvers = merge(user_resolvers, student_resolvers, staff_resolvers, class_resolvers, department_resolvers);

