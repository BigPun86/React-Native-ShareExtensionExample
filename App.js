/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from "react";
import { Platform, StyleSheet, Text, View, Linking, Image } from "react-native";

const instructions = Platform.select({
  ios: "Press Cmd+R to reload,\n" + "Cmd+D or shake for dev menu",
  android:
    "Double tap R on your keyboard to reload,\n" +
    "Shake or press menu button for dev menu"
});

function getFileExtension(filename) {
  var ext = /^.+\.([^.]+)$/.exec(filename);
  return ext == null ? "" : ext[1];
}

type Props = {};
export default class App extends Component<Props> {
  state = { fileUrls: [] };

  componentDidMount() {
    Linking.addEventListener("url", this.handleOpenURL);
  }

  componentWillUnmount() {
    Linking.removeEventListener("url", this.handleOpenURL);
  }

  handleOpenURL = async event => {
    this.error = null;
    this.fileUrls = [];

    const url = event.url;
    const replaceStatement = "shareScheme://?imageUrls="; // TODO: Change imageUrls into fileUrls or dataUrls
    const unresolvedImages = url.replace(replaceStatement, "");
    const data = unresolvedImages.split(";");

    data.forEach(fileURL => {
      if (!fileURL || fileURL === "file://null") {
        this.error = true;
      } else {
        const extension = getFileExtension(fileURL);
        this.fileUrls.push({ path: fileURL, type: extension });
      }
    });

    if (!this.error) this.setState({ fileUrls: this.fileUrls });
  };

  render() {
    let pickedImages = "";
    pickedImages = this.state.fileUrls.map((r, i) => {
      return (
        <Image
          key={i}
          style={styles.pickedImage}
          source={{ uri: this.state.fileUrls[i].path }}
        />
      );
    });

    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          Welcome to React Native Share Extension!
        </Text>
        <Text style={styles.instructions}>
          Choose atleast one image from Gallery and Share it with MyShareEx App
        </Text>
        <Text style={styles.instructions}>{instructions}</Text>
        {pickedImages}
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 30,
    justifyContent: "center",
    alignItems: "center",
    backgroundColor: "#F5FCFF"
  },
  welcome: {
    fontSize: 20,
    textAlign: "center",
    margin: 10
  },
  instructions: {
    textAlign: "center",
    color: "#333333",
    marginBottom: 5
  },
  pickedImage: {
    borderWidth: 1,
    borderColor: "red",
    width: 100,
    height: 100
  }
});
