package runner;

import kha.Color;
import armory.trait.physics.RigidBody;
import iron.math.Vec4;
import iron.Trait;
#if arm_debug
import vdebug.VDebug;
#end

class AutoRotateTrait extends iron.Trait {
	private var rb:RigidBody;

	public function new() {
		super();
		this.notifyOnInit(this.onInit);
		this.notifyOnLateUpdate(this.onUpdate);
	}

	public function onInit() {
		this.rb = this.object.getTrait(RigidBody);
	}

	public function onUpdate() {
		var a = this.rb.getLinearVelocity();

		#if arm_debug
		VDebug.line(this.object.transform.world.getLoc(), this.object.transform.world.getLoc().add(a), Color.Blue, 1);
		#end
		var b = new Vec4(a.x, a.y,0);
		if (b.length() > 0.1) {
			var angle = Math.atan2(a.y, a.x);
			this.object.transform.setRotation(0, 0, angle);
			this.rb.syncTransform();
		}
	}
}
