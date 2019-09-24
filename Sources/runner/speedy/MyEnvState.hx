package runner.runner.speedy;

import iron.math.Vec4;
import armory.trait.physics.bullet.PhysicsWorld.Hit;
import kha.Color;
import armory.trait.physics.RigidBody;
import iron.object.Object;
import basicia.definitions.IState;
#if arm_debug
import vdebug.VDebug;
#end

class MyEnvState implements IState {
	private static var VELOCITY_MAX = 10; // Target
	private static var raycasts:Array<Vec4> = [
		ArmoryHelper.PolarZAxis(Math.PI * 0.1, 5),
		ArmoryHelper.PolarZAxis(Math.PI * 0.9, 5),
		ArmoryHelper.PolarZAxis(Math.PI * 0.2, 6),
		ArmoryHelper.PolarZAxis(Math.PI * 0.8, 6),
		ArmoryHelper.PolarZAxis(Math.PI * 0.3, 7),
		ArmoryHelper.PolarZAxis(Math.PI * 0.7, 7),
		ArmoryHelper.PolarZAxis(Math.PI * 0.4, 8),
		ArmoryHelper.PolarZAxis(Math.PI * 0.6, 8),
		ArmoryHelper.PolarZAxis(Math.PI * 0.5, 9)
	];

	public final observation:Array<Float> = new Array<Float>();
	public final reward:Float;
	public final done:Bool;
	public final info:Map<String, String> = new Map<String, String>();

	public function new(object:Object, rb:RigidBody, progressMade:Float, fairplay:Bool) {

		var velocity_normalized = Math.min(rb.getLinearVelocity().length() / VELOCITY_MAX, 1);
		var progress_normalized = progressMade / 100000;
		var loc = object.transform.world.getLoc();
		var dist = loc.length();
		//var reward_center = dist > 1 ? 1 / dist : 1;
		this.reward = fairplay ? velocity_normalized : 0;
		this.done = !fairplay || progress_normalized >= 1;

		observation.push(velocity_normalized);

		var origin = object.transform.world.getLoc();
		for (v in raycasts) {
			var dest = v.clone().applymat4(object.transform.world);
			var hit = ArmoryHelper.RayCastFromTo(origin, dest);
			if (hit != null) {
				var raymax = v.length();
				var ray = hit.pos.clone().sub(origin).length();
				observation.push(ray / raymax);
			} else {
				observation.push(1);
			}
		}
		
		#if arm_debug
		VDebug.point(loc, Color.Green, 10);
		#end
	}

	#if arm_debug
	public function debug() {
		VDebug.variable("reward", Math.fround(reward * 100) + "u");
		for (r in this.observation) {
			VDebug.variable("obs", Math.fround(r * 100) + "u");
		}
	}
	#end
}
