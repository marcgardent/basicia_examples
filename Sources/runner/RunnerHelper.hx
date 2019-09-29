package runner;
 
import iron.object.Object;
import iron.math.Vec4;
import armory.trait.physics.RigidBody;
import iron.Scene;
import StringTools;

class RunnerHelper {
	public static function shufflePopulation(population:Array<Object>) {
		var positions = new Array<Vec4>();
		for (x in 0...10) {
			for (y in 0...10) {
				positions.push(new Vec4(x * 2 - 10, y * 2 - 10, 1));
			}
		}

		for (o in population) {
			var r = o.getTrait(RigidBody);
			if (r != null) {
				var posIndex = Math.floor(Math.random() * positions.length);
				var pos = positions.splice(posIndex, 1)[0];

				r.body.setAngularVelocity(new bullet.Bt.Vector3(0, 0, 0));
				r.body.setLinearVelocity(new bullet.Bt.Vector3(0, 0, 0));
				o.transform.loc = pos;
				o.transform.setRotation(0, 0, 0);
				o.transform.buildMatrix();
				r.syncTransform();
			} else {
				trace("[warning] excepted Rigidbody : " + o.name);
			}
		}
	}

	public static function getPopulation():Array<Object> {
		var population = new Array<Object>();

		for (i in 1...25) {
			trace("Cube", i);

			var num = StringTools.lpad(Std.string(i), "0", 3);
			var obj = Scene.active.getChild("Cube." + num);
			population.push(obj);
		}

		return population;
	}
}
