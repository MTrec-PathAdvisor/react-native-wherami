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
Thu Mar 26 11:45:15 HKT 2020
Thu Mar 26 11:46:13 HKT 2020
