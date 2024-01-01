import { setTimeout } from "timers/promises";

async function sleep() {
	await setTimeout(4000); // Wait for one second
  }

class RoundRobin{
    constructor(processes, burst_time, quantum){
        this.processes = processes;
        this.burst_time = burst_time;
        this.quantum = quantum;
        this.output_array = [];
		let n = this.processes.length;
		this.rem_bt = new Array(n).fill(0);
		this.t = 0;
		this.wt = new Array(n).fill(0)
		this.tat = new Array(n).fill(0);
		
		for (let i = 0; i < n; i++)
			this.rem_bt[i] = this.burst_time[i];
    }

    async findavgTime () {
        let processes = this.processes;
        let n = processes.length;
        let bt = this.burst_time;
        let quantum = this.quantum;

		
		let total_wt = 0, total_tat = 0;

		while(1){
			this.findWaitingTime();
			console.log(this.rem_bt);
			await setTimeout(2000);
		}

		this.findTurnAroundTime();

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
		let bt = this.burst_time;
		let quantum = this.quantum;
		let rem_bt = this.rem_bt;
		let wt = this.wt;

		let t = this.t; 

		while (1) {
			let done = true;
			for (let i = 0; i < n; i++) {
				if (rem_bt[i] > 0) {
					done = false; 

					if (rem_bt[i] > quantum) {
						t += quantum;
						rem_bt[i] -= quantum;
					}

					else {
						t = t + rem_bt[i];
						wt[i] = t - bt[i];

						rem_bt[i] = 0;
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
