package runner.goto;

import armory.trait.physics.RigidBody;
import iron.object.Object;
import tf.TFHelper;
import tf.TF;
import runner.goto.MyEnvActions;

import runner.RunnerHelper;
#if arm_debug
import vdebug.VDebug;
#end

class LiveSceneTrait extends iron.Trait {
	var population:Array<Object>;
	var actor:Dynamic;

	public function new() {
		super();
		notifyOnInit(this.onInit);
	}

	public function onInit() {
		TFHelper.init(this.onTensorFlowLoaded);
	}

	public function onTensorFlowLoaded() {
		TF.loadLayersModel("runner_goto_actor.json").then(this.onModelLoaded);
	}

	public function onModelLoaded(model:Dynamic) {
		trace("Actor model loaded!");
		this.actor = model;
		this.population = RunnerHelper.getPopulation();
		/*
		for (o in this.population) {
			//o.addTrait(new AutoRotateTrait());
		}
		*/
		RunnerHelper.shufflePopulation(population);

		notifyOnUpdate(this.onUpdate);
	}

	public function onUpdate() {
		var obs = new Array();

		for (o in population) {
			var loc = o.transform.world.getLoc();
			var a = [[loc.x / 100, loc.y / 100]];
			obs.push(a);
		}

		var obs = TF.tensor(obs);
		#if arm_debug
		VDebug.time("IA");
		#end
		var results = this.actor.predict(obs).arraySync();
		#if arm_debug
		VDebug.cost("IA");
		#end

		var i = 0;
		for (o in population) {
			var rb = o.getTrait(RigidBody);
			var action = new MyEnvActions(rb);
			action.Apply(results[i]);
			i++;
		}
	}
}
