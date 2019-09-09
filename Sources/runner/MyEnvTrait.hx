package runner;

import kha.math.Vector3;
import iron.math.Vec4;
import armory.trait.physics.RigidBody;
import basicia.io.WebSocketClientImpl;
import basicia.definitions.IClient;
import basicia.definitions.IState;

import runner.MyEnvActions;
import runner.MyEnvState;

#if arm_debug
import vdebug.VDebug;
#end

class MyEnvTrait extends basicia.iron.WebSocketEnvTrait {
	
	private var total:Float = 0;
	private var rb:RigidBody; 

	public function new() {
		super();	
	}
 
	public override function step(commands:Array<Float>): IState {

		var action = new MyEnvActions(rb);
		var fairplay = action.Apply(commands);
		
		var velocity = rb.getLinearVelocity().length();
		total += velocity;

		var state = new MyEnvState(this.object, rb, total, fairplay);
		
		#if arm_debug
		VDebug.addVariable("progress made", Math.fround(total / 1000 * 100) + "%");
		VDebug.addMessage("----------------------------");
		state.debug();
		#end

		return state;
	}

	public override function reset():IState {
		total = 0;
		this.rb = this.object.getTrait(RigidBody);
		this.rb.body.setAngularVelocity(new bullet.Bt.Vector3(0, 0, 0));
		this.rb.body.setLinearVelocity(new bullet.Bt.Vector3(0, 0, 0));

		return new MyEnvState(this.object, rb, total, true);
	}
}
