package runner;

import armory.trait.physics.RigidBody;
import iron.math.Vec4;
import iron.Trait;

class RandomMoveTrait extends iron.Trait {
	private var rb:RigidBody;

	public function new() {
		super();
		this.notifyOnInit(this.onInit);
		this.notifyOnUpdate(this.onUpdate);
	}

	public function onInit() {
		this.rb = this.object.getTrait(RigidBody);
	}

	public function onUpdate() {
		var v = new Vec4(randomToFrom(-1, 1), randomToFrom(-1, 1), 0);
		this.rb.applyImpulse(v);
	}

	private static function randomToFrom(min:Float, max:Float):Float {
		var l = max - min;
		return Math.random() * l + min;
	}
}
