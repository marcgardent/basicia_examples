package runner;

import iron.math.Vec4;
import armory.trait.physics.RigidBody;
import iron.Trait;
import tf.TF;
#if arm_debug
import vdebug.VDebug;
#end

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
		var loc = object.transform.world.getLoc();
		#if arm_debug
		VDebug.time("IA");
		#end
		var obs = TF.tensor([[[loc.x / 100, loc.y / 100]]]);
		var result = this.actor.predict(obs).arraySync()[0];
		//var result = [0.0,0.0];
		#if arm_debug
		VDebug.cost("IA");
		#end

		#if arm_debug
		VDebug.time("Physics");
		#end
		this.action.Apply(result);
		#if arm_debug
		VDebug.cost("Physics");
		#end
	}

	private static function randomToFrom(min:Float, max:Float):Float {
		var l = max - min;
		return Math.random() * l + min;
	}
}
