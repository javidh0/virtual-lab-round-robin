import { setTimeout } from "timers/promises";

async function sleep() {
	await setTimeout(4000); // Wait for one second
  }

class RoundRobin{
    constructor(processes, burst_time, quantum){
        this.processes = processes;
        this.bt = burst_time;
        this.quantum = quantum;
        this.output_array = [];
		let n = this.processes.length;
		this.rem_bt = new Array(n).fill(0);
		this.t = 0;
		this.wt = new Array(n).fill(0)
		this.tat = new Array(n).fill(0);
		this.done = false;
		this.temp_flg = true;
		this.i = 0;

		for (let i = 0; i < n; i++)
			this.rem_bt[i] = this.bt[i];
    }

    async findavgTime () {
		
		let total_wt = 0, total_tat = 0;
		console.log(this.wt);
		console.log(this.tat);
		while(1 && !this.done){
			
			console.log("\n");
			this.itter();
			await setTimeout(1000);
			console.log(this.wt);
			console.log(this.tat);
		}
	}

    itter () {
		let n = this.processes.length;
		let quantum = this.quantum;
		
		let i = this.i;
		let rem_bt_prev = this.rem_bt[i];
		if (this.rem_bt[i] > 0) {
			this.temp_flg = false;
			if (this.rem_bt[i] > quantum) {
				this.t += quantum;
				this.rem_bt[i] -= quantum;
			}

			else {
				this.t = this.t + this.rem_bt[i];
				this.wt[i] = this.t - this.bt[i];

				this.rem_bt[i] = 0;
				this.tat[i] = this.bt[i] + this.wt[i];
			}
		}
		this.i++;
		if(this.i+1 > n) {
			this.i = 0;
			this.done = this.temp_flg;
			this.temp_flg = true
		}
		return [
			rem_bt_prev != 0,
			this.t,
			i,
			this.processes,
			this.bt,
			this.rem_bt,
			this.wt,
			this.tat,
			this.done
		]
	}
}

let processes = [1,2,3];
let burst_time = [5,2,10];

let obj = new RoundRobin(processes, burst_time, 2);
while(!obj.done){
	let temp = obj.itter();
	if(temp[0]) console.log(temp.slice(1));
}
