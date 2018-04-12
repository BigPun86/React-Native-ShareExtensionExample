/**
 * Sample React Native Share Extension
 * @flow
 */

import React, { Component } from "react";
import Modal from "react-native-modalbox";
import ShareExtension from "react-native-share-extension";

import { Text, View, TouchableOpacity } from "react-native";

const groupID = "group.share.extension";

export default class Share extends Component {
  constructor(props, context) {
    super(props, context);
    this.state = {
      isOpen: true,
      type: "",
      value: ""
    };
  }

  async componentDidMount() {
    try {
      const { type, value } = await ShareExtension.data(groupID);
      this.setState({
        type,
        value
      });
    } catch (e) {
      console.log("errrr", e);
    }
  }

  onClose = () => ShareExtension.close(groupID);

  closing = () => this.setState({ isOpen: false });

  shareWithApp = () => {
    const imageUrl = this.state.value;
    const deepLinkingUrl = `shareExtensionApp://shareImage/${imageUrl}`;
    ShareExtension.openURL(deepLinkingUrl);
    ShareExtension.close(groupID);
  };

  render() {
    return (
      <Modal
        backdrop={false}
        style={{ backgroundColor: "transparent" }}
        position="center"
        isOpen={this.state.isOpen}
        onClosed={this.onClose}
      >
        <View
          style={{ alignItems: "center", justifyContent: "center", flex: 1 }}
        >
          <View
            style={{
              borderColor: "green",
              borderWidth: 1,
              backgroundColor: "white",
              height: 200,
              width: 300
            }}
          >
            <TouchableOpacity onPress={this.shareWithApp}>
              <Text>Close</Text>
              <Text>type: {this.state.type}</Text>
              <Text>value: {this.state.value}</Text>
            </TouchableOpacity>
          </View>
        </View>
      </Modal>
    );
  }
}
