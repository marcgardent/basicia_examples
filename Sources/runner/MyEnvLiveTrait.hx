package runner;

import tf.TFHelper;
import tf.TF;

class MyEnvLiveTrait extends iron.Trait {
	public function new() {
		super();
		trace("MyEnvLiveTrait::new");
		notifyOnInit(function() {
			trace("MyEnvLiveTrait::OnInit");
			TFHelper.init(function() {
				trace("TFHelper::OnInit");
				TF.loadLayersModel("runner_actor.json").then( function(model:Dynamic){
					trace("loadLayersModel::then");
					var t=  TF.tensor([[[1,5]]]);
					var result = model.predict(t).arraySync();
					var result = model.predict(t).arraySync();
				});
			});
		});

		// notifyOnUpdate(function() {
		// });

		// notifyOnRemove(function() {
		// });
	}
}
