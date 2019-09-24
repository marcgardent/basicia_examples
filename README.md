# basicia_examples
Examples with Keras-RL and Armory3D

## Infos
Installation, usage, customisation : see https://github.com/marcgardent/basicia

## runner.blend : Cat and Mouse Problem

>  Work in progress, but it's run!

Implemented :

* Provide the environment of reinforcement learning - Scene Armory3d
* Train the NN under Keras
* Export NN model for `tensorflow.js`
* Run the NN model in ` armory3D`  with ` tensorflow.js`

Train and run steps are supported only under NodeJS and Web browsers.

Todo:

* implement "the cat and the mouse game" and release the game!
* implement genetic algorithms to make a generic training backend.
* catch websocket exception (client and server) : disconnect, timeout
* Backend serve multi NN training
* rename: `goto` -> `Cat` and `speedy` -> `mouse`
* write documentation / tutorial
* Create C/C++ binding of tensorflow
