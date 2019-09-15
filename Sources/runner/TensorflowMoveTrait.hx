package runner;

import armory.trait.physics.RigidBody;
import iron.Trait;
import tf.TF;

class TensorflowMoveTrait extends iron.Trait {
	private var rb:RigidBody;
	private var action:MyEnvActions;
	private var actor:Dynamic;
	 
	public function new(actor:Dynamic) {
		this.actor = actor;
		super();
		this.notifyOnInit(this.onInit);
		this.notifyOnUpdate(this.onUpdate);
	}

	public function onInit() {
		this.rb = this.object.getTrait(RigidBody);
		this.action = new MyEnvActions(this.rb);
	}

	public function onUpdate() {
		var loc =object.transform.world.getLoc();
		
		var obs = TF.tensor([[[loc.x/100, loc.y/100]]]);
		var result = this.actor.predict(obs).arraySync()[0];
		this.action.Apply(result);
	}

}
