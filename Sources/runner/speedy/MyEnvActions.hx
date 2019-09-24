package runner.runner.speedy;

import iron.object.Object;
import kha.FastFloat;
import iron.math.Vec4;
import armory.trait.physics.RigidBody;
#if arm_debug
import vdebug.VDebug;
#end

class MyEnvActions {
	private static var MAX_IMPLUSE:kha.FastFloat = 1;

	private final rb:RigidBody;
	private final object:Object;

	public function new(object:Object, rb:RigidBody) {
		this.rb = rb;
		this.object = object;
	}

	public function Apply(commands:Array<Float>):Bool {
		var impluse = new Vec4(commands[0], commands[1], 0);
		var length = impluse.length();
		var ok = length <= MAX_IMPLUSE;

		if (ok) {
			this.rb.applyImpulse(impluse);
			
			// lock rotation :
			var a = this.rb.getLinearVelocity();
			var b = new Vec4(a.x, a.y, 0);
			if (b.length() > 0.1) {
				var angle = Math.atan2(a.y, a.x) - Math.PI/2;
				this.object.transform.setRotation(0, 0, angle);
				this.rb.syncTransform();
			}
		}
		return ok;
	}

	public function Reset() {
		this.rb.body.setAngularVelocity(new bullet.Bt.Vector3(0, 0, 0));
		this.rb.body.setLinearVelocity(new bullet.Bt.Vector3(0, 0, 0));
	}
}
