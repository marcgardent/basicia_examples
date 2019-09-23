package tf;

#if js

class TFHelper {
	public static function init(done:Void->Void) {
		trace("TFHelper::init");
		kha.Assets.loadBlobFromPath("tf.js", function(b:kha.Blob) {
			untyped __js__("(1, eval)({0})", b.toString());
			trace("loadBlobFromPath::done");
			done();
		});
	}
}

#end
