// https://js.tensorflow.org/api/0.10.0/
package tf;

#if js

@:native('tf')
extern class TF {
	static function loadLayersModel(modelConfigPath:String):Dynamic;
	static function tensor(values:Array<Dynamic>, ?shape:Array<Int>, ?dtype:Dynamic):Dynamic;
}

#end
