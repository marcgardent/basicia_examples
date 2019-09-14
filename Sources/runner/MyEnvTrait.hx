package runner;

import kha.Color;
import iron.object.Object;
import iron.math.Vec4;
import armory.trait.physics.RigidBody;
import basicia.definitions.IState;
import iron.Scene;
import StringTools;
import runner.MyEnvActions;
import runner.MyEnvState;
#if arm_debug
import vdebug.VDebug;
#end
import Std;

class MyEnvTrait extends basicia.iron.WebSocketEnvTrait {
	private var total:Float = 0;
	private var win:Int= 0;
	private var loose:Int= 0;
	private var rb:RigidBody;
	private var population = new Array<Object>();
	private var target:Object;

	public function new() {
		super();
	}

	public override function step(commands:Array<Float>):IState {
		var action = new MyEnvActions(rb);
		var fairplay = action.Apply(commands);

		var velocity = rb.getLinearVelocity().length();
		total += velocity;

		var state = new MyEnvState(this.target, rb, total, fairplay);

		if(state.done){
			if(fairplay){ this.win++; }
			else{ this.loose++;}
		}


		#if arm_debug
		//VDebug.addVariable("progress made", Math.fround(total / 1000 * 100) + "%");
		VDebug.addVariable("Ok", this.win + "#");
		VDebug.addVariable("KO", this.loose + "#");
		VDebug.addMessage("----------------------------");
		state.debug();
		var color = Color.fromFloats(0,state.reward,0);
		VDebug.addDrag(this.target.transform.world.getLoc(),color, 3, "target", 200);
		VDebug.addPoint(new Vec4(0,0,0),Color.White,6);
		#end

		return state;
	}

	public override function reset():IState {
		total = 0;
		var i = 0;

		var positions = new Array<Vec4>();
		for (x in 0...10) {
			for (y in 0...10) {
				positions.push(new Vec4(x*2-10,y*2-10,1));
			}
		}
		
		for (o in this.population) {
			var r = o.getTrait(RigidBody);
			var posIndex = Math.floor(Math.random() * positions.length);
			var pos = positions.splice(posIndex,1)[0];

			r.body.setAngularVelocity(new bullet.Bt.Vector3(0, 0, 0));
			r.body.setLinearVelocity(new bullet.Bt.Vector3(0, 0, 0));
			o.transform.loc =pos;
			o.transform.setRotation(0,0,0);
			o.transform.buildMatrix();
			r.syncTransform();
		}

		
		return new MyEnvState(this.target, rb, total, true);
	}

	public override function init():Void {
		for (i in 1...25) {
			trace("Cube", i);
			
			var num = StringTools.lpad(Std.string(i), "0", 3);
			var obj = Scene.active.getChild("Cube." + num);
			var trait = new RandomMoveTrait();
			obj.addTrait(trait);

			this.population.push(obj);
		}

		this.target = Scene.active.getChild("Cube.000");
		this.population.push(this.target);
	
		this.rb = this.target.getTrait(RigidBody);
	}
}
