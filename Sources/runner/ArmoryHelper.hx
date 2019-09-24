package runner;

import iron.math.Vec4;
import kha.Color;
import armory.trait.physics.bullet.PhysicsWorld.Hit;

#if arm_debug
import vdebug.VDebug;
#end

class ArmoryHelper {
	public static function RayCastFromTo(source:Vec4, destination:Vec4):Hit {
		var ret = armory.trait.physics.PhysicsWorld.active.rayCast(source, destination);
		if (ret != null) {
			ret = new Hit(ret.rb, ret.pos.clone(), ret.normal.clone());
			#if arm_debug
			VDebug.line(source, ret.pos, Color.Red, 1);
			#end
		} else {
			#if arm_debug
			VDebug.line(source, destination, Color.Green, 1);
			#end
		}
		return ret;
	}

	public static function PolarZAxis(angle:Float, r:Float):Vec4 {
		return new Vec4(Math.cos(angle) * r, Math.sin(angle) * r, 0);
	}
}
