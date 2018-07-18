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

type Props = {};
export default class App extends Component<Props> {
  state_old = { imageUrl: null };
  state ={ imageUrls: [] }
  componentDidMount() {
    Linking.addEventListener("url", this.handleOpenURL);
  }

  componentWillUnmount() {
    Linking.removeEventListener("url", this.handleOpenURL);
  }

  handleOpenURL = async event => {
    const url = event.url;
    const imageUrl = url.replace("shareScheme://?imageUrls=", "");
    var imgeUrls = imageUrl.split(";");
    //this.setState({ imageUrl });
    this.state.imageUrls = [];
    imgeUrls.forEach(url => {
      this.state.imageUrls.push(url);
    });
    this.setState({ imageUrls: this.state.imageUrls })
  };

  render() {
    var pickedImages = ""
    pickedImages = this.state.imageUrls.map((r, i) => {
      return <Image key={ i } style={styles.pickedImage}
                  source={{ uri: this.state.imageUrls[i] }}
              />
    })
    var textUrls = ""
    if (0>1){
      // only for debug 
      textUrls = this.state.imageUrls.map((r, i) => {
        return <Text  key={ i } style={styles.welcome}>  { r }</Text>
     })
    }
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>Welcome to React Native!</Text>
        <Text style={styles.instructions}>To get started, edit App.js</Text>
        <Text style={styles.instructions}>{instructions}</Text>
        {this.state_old.imageUrl && (
          <Image
            style={{
              borderWidth: 1,
              borderColor: "red",
              width: 100,
              height: 100
            }}
            source={{ uri: this.state.imageUrl }}
          />
        )}
         { pickedImages } 
         { textUrls } 
         
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
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
  pickedImage:{
    borderWidth: 1,
    borderColor: "red",
    width: 100,
    height: 100
  }
});
