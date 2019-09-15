package runner;

import armory.trait.physics.RigidBody;
import iron.object.Object;
import tf.TFHelper;
import tf.TF;

/**
 * MyEnvLiveTrait Alternative 
 */
class MyEnvLiveBatchTrait extends iron.Trait {
	var population : Array<Object>;
	var actor :Dynamic;

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
		this.actor = model;
		this.population = MyEnvTrait.getPopulation();

		MyEnvTrait.shufflePopulation(population);
		for (o in population) {
			o.addTrait(new TensorflowMoveTrait(model));
		}

		notifyOnUpdate(this.onUpdate);
	}

	public function onUpdate(){
		var obs = new Array();
		for (o in population) {
			var loc = o.transform.world.getLoc();
			var a = [[loc.x/100, loc.y/100]];
			obs.push(a);
		}

		var obs = TF.tensor(obs);
		var results = this.actor.predict(obs).arraySync();
		var i = 0;
		for(o in population){
			var rb = o.getTrait(RigidBody);
			var action = new MyEnvActions(rb);
			action.Apply(results[i]);
			i++;
		}
	}

 
}
