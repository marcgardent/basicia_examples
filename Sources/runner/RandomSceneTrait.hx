package runner;

import armory.trait.physics.RigidBody;
import iron.object.Object;
import tf.TFHelper;
import tf.TF;
import runner.goto.MyEnvActions;
import runner.goto.MyEnvState;
import runner.goto.TrainSceneTrait;
import runner.RunnerHelper;

class RandomSceneTrait extends iron.Trait {
	var population:Array<Object>;
	var actor:Dynamic;

	public function new() {
		super();
		notifyOnInit(this.onInit);
		notifyOnUpdate(this.onUpdate);
	}

	public function onInit() {
		this.population = RunnerHelper.getPopulation();
		RunnerHelper.shufflePopulation(population);
		for (o in this.population) {
			o.addTrait(new RandomMoveTrait());
			o.addTrait(new AutoRotateTrait());
		}
	}

	public function onUpdate() {
	}
}
