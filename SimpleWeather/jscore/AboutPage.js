'use strict'
import React, { Component } from 'react'
import { View, ScrollView, Image, Text, StyleSheet } from 'react-native'

class AboutPage extends Component {
  constructor (...args) {
    super(...args)
    this.color = this.props.color
  }


  render () {
    let content = (
      <View style={styles.contentContainer}>
        <Text style={{lineHeight: 18}}>至简天气，简单简洁的天气应用。</Text>
        <Text style={styles.contentText}>Author: v2panda</Text>
        <Text style={styles.contentText}>本项目属于开源项目，使用纯React-Native开发。</Text>
        <Text style={styles.contentText}>Github: https://github.com/v2panda/SimpleWeather</Text>
        <Text style={styles.contentText}>若对本项目有什么意见和建议，欢迎邮件至me@v2panda.com </Text>
      </View>
      )
    return (
      <View style={{flex:1,backgroundColor:this.color}}>
        <ScrollView>
          <Image source={require('./images/gank_launcher.png')} style={styles.imgLauncher}/>
          <Text style={styles.versionText}>至简天气</Text>
          <Text style={styles.versionText}>v2.0.0</Text>
          <Text style={styles.aboutText}>关于开发者</Text>
          {content}
        </ScrollView>
      </View>
      )
  }
}

var styles = StyleSheet.create({
  imgLauncher: {
    alignSelf: 'center',
    marginTop: 114,
    width: 90,
    height: 90
  },
  contentContainer: {
    backgroundColor: 'white',
    margin: 8,
    padding: 15,
    borderRadius: 4
  },

  contentText: {
    marginTop: 13,
    lineHeight: 18
  },

  versionText: {
    color: 'white',
    fontSize: 16,
    alignSelf: 'center',
    marginTop: 13
  },

  aboutText: {
    fontSize: 15,
    marginTop: 30,
    marginBottom: 5,
    marginLeft: 8,
    color: 'white'
  }

})

module.exports = AboutPage
