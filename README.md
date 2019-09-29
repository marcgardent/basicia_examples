# basicia_examples
Examples with Keras-RL and Armory3D

## Infos
Installation, usage, customisation : see https://github.com/marcgardent/basicia

## runner.blend : Cat and Mouse Problem

>  Work in progress, but it's run!

> Train and run steps are supported only under NodeJS and Web browsers.

### Cat Agent

the whole pipeline is implemented:

* Provide the environment of reinforcement learning - Scene Armory3d
* Train the NN under Keras
* Export NN model for `tensorflow.js`
* Run the NN model in ` armory3D`  with ` tensorflow.js`

### Mouse Agent

* WIP : Provide the environment of reinforcement learning - Scene 

### Todo

* implement "the cat and the mouse game" and release the game!
* implement genetic algorithms to make a generic training backend.
* catch websocket exception (client and server) : disconnect, timeout
* Backend serve multi NN training
* rename: `goto` -> `Cat` and `speedy` -> `mouse`
* write documentation / tutorial
* Create C/C++ binding of tensorflow

### Know issues

#### Cannot enlarge memory arrays

Very long session :

```
_GROWTH=1  which allows increasing the size at runtime but prevents some optimizations, (3) set Module.TOTAL_MEMORY to a higher value before the program runs, or (4) if you want malloc to return NULL (0) instead of this abort, compile with  -s ABORTING_MALLOC=0 
Log.hx:64
Cannot enlarge memory arrays. Either (1) compile with  -s TOTAL_MEMORY=X  with X higher than the current value 67108864, (2) compile with  -s ALLOW_MEMORY_GROWTH=1  which allows increasing the size at runtime but prevents some optimizations, (3) set Module.TOTAL_MEMORY to a higher value before the program runs, or (4) if you want malloc to return NULL (0) instead of this abort, compile with  -s ABORTING_MALLOC=0 
VM110:334
undefined
SystemImpl.hx:58
```