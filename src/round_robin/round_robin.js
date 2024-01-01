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
		
		for (let i = 0; i < n; i++)
			this.rem_bt[i] = this.bt[i];
    }

    async findavgTime () {
        let processes = this.processes;
		
		let total_wt = 0, total_tat = 0;

		while(1 && !this.done){
			console.log(this.wt);
			console.log(this.tat);
			console.log("\n");
			this.findWaitingTime();
			await setTimeout(1000);
			this.done = true;
			for(var i=0; i<this.rem_bt.length; i++){
				if(this.rem_bt[i] == 0){
					this.tat[i] = this.bt[i] + this.wt[i];
				}else{this.done = false;}
			}
		}


		// for (let i = 0; i < n; i++) {
		// 	total_wt = total_wt + wt[i];
		// 	total_tat = total_tat + tat[i];

		// 	// console.log(`${i + 1} ${bt[i]} ${wt[i]} ${tat[i]}`);
        //     let temp = [i+1, bt[i], wt[i], tat[i]];
        //     this.output_array.push(temp);
		// }
        // return this.output_array;
	}

    findTurnAroundTime () {
		let n = this.processes.length;
		let bt = this.burst_time;
		let wt = this.wt;
		let tat = this.tat;

		for (let i = 0; i < n; i++)
			tat[i] = bt[i] + wt[i];
	}

    findWaitingTime () {
		let n = this.processes.length;
		let quantum = this.quantum;


		let t = this.t; 

		while (1) {
			let done = true;
			for (let i = 0; i < n; i++) {
				if (this.rem_bt[i] > 0) {
					done = false; 

					if (this.rem_bt[i] > quantum) {
						this.t += quantum;
						this.rem_bt[i] -= quantum;
					}

					else {
						this.t = this.t + this.rem_bt[i];
						this.wt[i] = this.t - this.bt[i];

						this.rem_bt[i] = 0;
					}
				}
				
			}
			break;
			//console.log(rem_bt);
			//console.log(wt);
		}
	}
}

let processes = [1,2,3,4];
let burst_time = [5,2,10,2];

let obj = new RoundRobin(processes, burst_time, 2);
console.log(obj.findavgTime());
