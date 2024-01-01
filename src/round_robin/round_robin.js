class RoundRobin{
    constructor(processes, burst_time, quantum){
        this.processes = processes;
        this.burst_time = burst_time;
        this.quantum = quantum;
        this.output_array = [];
    }

    findavgTime () {
        let processes = this.processes;
        let n = processes.length;
        let bt = this.burst_time;
        let quantum = this.quantum;

		let wt = new Array(n).fill(0), tat = new Array(n).fill(0);
		let total_wt = 0, total_tat = 0;

		findWaitingTime(processes, n, bt, wt, quantum);

		findTurnAroundTime(processes, n, bt, wt, tat);

		for (let i = 0; i < n; i++) {
			total_wt = total_wt + wt[i];
			total_tat = total_tat + tat[i];

			// console.log(`${i + 1} ${bt[i]} ${wt[i]} ${tat[i]}`);
            let temp = [i+1, bt[i], wt[i], tat[i]];
            this.output_array.push(temp);
		}

		// console.log(`Average waiting time = ${total_wt / n}`);
		// console.log(`Average turn around time = ${total_tat / n}`);
        return this.output_array;
	}

    findTurnAroundTime (processes, n, bt, wt, tat) {
		for (let i = 0; i < n; i++)
			tat[i] = bt[i] + wt[i];
	}

    findWaitingTime (processes, n, bt, wt, quantum) {
		let rem_bt = new Array(n).fill(0);
		for (let i = 0; i < n; i++)
			rem_bt[i] = bt[i];

		let t = 0; 

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

			if (done == true)
				break;
		}
	}
}

obj = new RoundRobin(processes, burst_time, 2);
console.log(obj.findavgTime());