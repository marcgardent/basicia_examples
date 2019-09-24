package runner.goto;

import iron.math.Vec4;
import kha.Color;
import armory.trait.physics.RigidBody;
import iron.object.Object;
import basicia.definitions.IState;

#if arm_debug
import vdebug.VDebug;
#end

class MyEnvState implements IState {

	private static var VELOCITY_MAX = 10; // Target


	public final observation:Array<Float> = new Array<Float>();
	public final reward:Float;
	public final done:Bool;
	public final info:Map<String, String> = new Map<String,String>();
	
	public function new(object:Object, rb:RigidBody, fairplay: Bool) {

		var loc =object.transform.world.getLoc();
		var dist = loc.length();
		var reward_center =dist>1 ? 1/dist : 1;
		reward = fairplay ? reward_center : 0;
		done = !fairplay || reward==1;

		observation.push(loc.x/100);
		observation.push(loc.y/100);

		#if arm_debug	
		VDebug.point(loc,Color.Green,10);
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
