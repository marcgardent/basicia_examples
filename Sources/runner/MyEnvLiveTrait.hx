package runner;

import tf.TFHelper;
import tf.TF;

class MyEnvLiveTrait extends iron.Trait {
	public function new() {
		super();
		notifyOnInit(this.onInit);
	}

	public function onInit() {

		TFHelper.init(this.onTensorFlowLoaded);
	}

	public function onTensorFlowLoaded() {
		TF.loadLayersModel("runner_actor.json").then(this.onModelLoaded);
	}

	public function onModelLoaded(model:Dynamic) {
		trace("Actor model loaded!");
		
		var pop = MyEnvTrait.getPopulation();
		MyEnvTrait.shufflePopulation(pop);
		for (o in pop) {
			o.addTrait(new TensorflowMoveTrait(model));
		}
	}
}
