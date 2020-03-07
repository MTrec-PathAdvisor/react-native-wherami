# React Native Wherami Module Library

## Installation



## Getting started
### add line to package.json as one of the dependencies:

`"react-native-wherami": "git+https://github.com/hymanae/react-native-wherami#develop"`

### then

`$ yarn install`

### Mostly automatic installation, react-native link has been replaced by autolink with RN0.60 or above

`$ react-native link react-native-wherami`


## Usage
```javascript
import Wherami from 'react-native-wherami';

//Check permissions required for Wherami
Wherami.checkSelfPermission();
//Initializing Wherami 
Wherami.initializeSDK();
//Start the engine
Wherami.start();
//Stop the engine
Wherami.stop();
```
Sun  8 Mar 2020 03:02:28 HKT
