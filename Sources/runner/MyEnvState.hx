package runner;


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
		new Vec4(1, 0, 0),
		new Vec4(-1, 0, 0),
		new Vec4(0, -1, 0),
		new Vec4(0, 1, 0),
		new Vec4(1, 1, 0),
		new Vec4(-1, -1, 0),
		new Vec4(-1, 1, 0),
		new Vec4(1, -1, 0)
	];

	public final observation:Array<Float> = new Array<Float>();
	public final reward:Float;
	public final done:Bool;
	public final info:Map<String, String> = new Map<String,String>();
	
	public function new(object:Object, rb:RigidBody, progressMade:Float, fairplay: Bool) {
		//this.done = !fairplay || progressMade > 1000;
		var reward_velocity = Math.min(rb.getLinearVelocity().length() / VELOCITY_MAX, 1);
		var reward_progress = progressMade/1000;
		var loc =object.transform.world.getLoc();
		var dist = loc.length();
		var reward_center =dist>1 ? 1/dist : 1;
		reward = fairplay ? reward_center : 0;
		done = !fairplay || reward==1;
		
		/*
		var origin = object.transform.world.getLoc();
		for (v in raycasts) {
			var dest = v.clone().applymat4(object.transform.world);
			var hit = RayCastFromTo(origin, dest);
			if (hit != null) {
				var raymax = v.length();
				var ray = hit.pos.clone().sub(origin).length();
				observation.push(ray / raymax);
			} else {
				observation.push(1);
			}
		}
		*/

		observation.push(loc.x/100);
		observation.push(loc.y/100);

		#if arm_debug	
		VDebug.addPoint(loc,Color.Green,10);
		#end
	}

	#if arm_debug
	public function debug() {
		
		VDebug.addVariable("reward", Math.fround(reward * 100) + "u");
		for (r in this.observation) {
			VDebug.addVariable("rays", Math.fround(r * 100) + "u");
		}
		
	}
	#end

	function RayCastFromTo(source:Vec4, destination:Vec4):Hit {
		var ret = armory.trait.physics.PhysicsWorld.active.rayCast(source, destination);
		if (ret != null) {
			ret = new Hit(ret.rb, ret.pos.clone(), ret.normal.clone()); // TODO PR, Fix! avoid clone
			#if arm_debug
			VDebug.addLine(source, ret.pos, Color.Red, 1);
			#end
		} else {
			#if arm_debug
			VDebug.addLine(source, destination, Color.Green, 1);
			#end
		}
		return ret;
	} 
}
