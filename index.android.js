import React from "react";
import { AppRegistry } from "react-native";

AppRegistry.registerComponent("ShareExtension", () => require("./App").default);
AppRegistry.registerComponent(
  "MyShareEx",
  () => require("./share.ios").default
);
