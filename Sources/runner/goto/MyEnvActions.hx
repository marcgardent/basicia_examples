package runner.goto;

import kha.FastFloat;
import iron.math.Vec4;
import armory.trait.physics.RigidBody;


#if arm_debug
import vdebug.VDebug;
#end

class MyEnvActions  {
	
	private static var MAX_IMPLUSE:kha.FastFloat = 1;

	private final rb:RigidBody;

	public function new(rb:RigidBody) {
		this.rb = rb;
	}

	public function Apply(commands:Array<Float>):Bool {
		var impluse = new Vec4(commands[0], commands[1], 0);
		var length = impluse.length();
		var ok = length <= MAX_IMPLUSE;

		if (ok) {
			this.rb.applyImpulse(impluse);
		}
		return ok;
	}

	public function Reset() {
		this.rb.body.setAngularVelocity(new bullet.Bt.Vector3(0, 0, 0));
		this.rb.body.setLinearVelocity(new bullet.Bt.Vector3(0, 0, 0));
	}
}
