'use strict'
import React, { Component } from 'react'
import { View, ScrollView, Image, PickerIOS, Text, StyleSheet } from 'react-native'

var PickerItemIOS = PickerIOS.Item;
var CAR_MAKES_AND_MODELS = {
  amc: {
    name: 'AMC',
    models: ['AMX', 'Concord', 'Eagle', 'Gremlin', 'Matador', 'Pacer'],
  },
  alfa: {
    name: 'Alfa-Romeo',
    models: ['159', '4C', 'Alfasud', 'Brera', 'GTV6', 'Giulia', 'MiTo', 'Spider'],
  },
  aston: {
    name: 'Aston Martin',
    models: ['DB5', 'DB9', 'DBS', 'Rapide', 'Vanquish', 'Vantage'],
  },
  audi: {
    name: 'Audi',
    models: ['90', '4000', '5000', 'A3', 'A4', 'A5', 'A6', 'A7', 'A8', 'Q5', 'Q7'],
  },
  austin: {
    name: 'Austin',
    models: ['America', 'Maestro', 'Maxi', 'Mini', 'Montego', 'Princess'],
  },
  borgward: {
    name: 'Borgward',
    models: ['Hansa', 'Isabella', 'P100'],
  },
  buick: {
    name: 'Buick',
    models: ['Electra', 'LaCrosse', 'LeSabre', 'Park Avenue', 'Regal',
             'Roadmaster', 'Skylark'],
  },
  cadillac: {
    name: 'Cadillac',
    models: ['Catera', 'Cimarron', 'Eldorado', 'Fleetwood', 'Sedan de Ville'],
  },
  chevrolet: {
    name: 'Chevrolet',
    models: ['Astro', 'Aveo', 'Bel Air', 'Captiva', 'Cavalier', 'Chevelle',
             'Corvair', 'Corvette', 'Cruze', 'Nova', 'SS', 'Vega', 'Volt'],
  },
};

class AboutPage extends Component {
  constructor (...args) {
    super(...args)
    this.state = ({
      carMake: 'cadillac',
      modelIndex: 3,
    })
  }


  render () {
    let content = (
      <View style={styles.contentContainer}>
        <Text style={{lineHeight: 18}}>每天一张精选妹纸图、一个精选小视频（视频源地址播放，因为视频来源于包含各大平台。。。着实不好统一播放器。。。
        ），一篇程序猿精选干货。</Text>
        <Text style={styles.contentText}>数据内容来源于代码家的 
          <Text style={{textDecorationLine: 'underline'}}
          onPress={() => {
            this.props.navigator.push({
              component: WebViewPage,
              title: 'Gank.io',
              url: 'http://gank.io'
            })
          }}
          > http://gank.io </Text>
        , PoberWong 完成React－Native的开发，非常感谢Veaer的设计和指点。
        </Text>
        <Text style={styles.contentText}>My Github: 
          <Text style={{textDecorationLine: 'underline'}}
          onPress={() => {
            this.props.navigator.push({
              component: WebViewPage,
              title: 'PoberWong',
              url: 'http://github.com/Bob1993'
            })
          }}
          > http://github.com/Bob1993 </Text>
        </Text>
        <Text style={styles.contentText}>Organization: 北京杰讯云动力科技有限公司</Text>
        <Text style={styles.contentText}>本项目属于公司开源项目，使用纯React-Native开发，如果你觉得这对你学习React-Native有很大的帮助，我不介意适量打赏喔～ 欢迎来访我的Github...  </Text>
        <Text style={styles.contentText}>支付宝: 15566261458 </Text>
      </View>
      )
    return (
      <View style={styles.container}>
      <Text>Please choose a make for your car:</Text>
        <PickerIOS
          selectedValue={this.state.carMake}
          onValueChange={(carMake) => this.setState({carMake, modelIndex: 0})}>
          {Object.keys(CAR_MAKES_AND_MODELS).map((carMake) => (
            <PickerItemIOS
              key={carMake}
              value={carMake}
              label={CAR_MAKES_AND_MODELS[carMake].name}
            />
          ))}
        </PickerIOS>
        <ScrollView>
          <Image source={require('./images/gank_launcher.png')} style={styles.imgLauncher}/>
          <Text style={styles.versionText}>干 客</Text>
          <Text style={styles.versionText}>v1.0.0</Text>
          <Text style={styles.aboutText}>关于开发者</Text>
          {content}
        </ScrollView>
      </View>
      )
  }
}

var styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#252528'
  },
  imgLauncher: {
    alignSelf: 'center',
    marginTop: 114,
    width: 90,
    height: 90
  },

  contentContainer: {
    // height: 300,
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
    color: '#434243'
  }

})

module.exports = AboutPage
