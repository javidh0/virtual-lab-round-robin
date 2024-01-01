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
		// calculating turnaround time by adding
		// bt[i] + wt[i]
		for (let i = 0; i < n; i++)
			tat[i] = bt[i] + wt[i];
	}

    findWaitingTime (processes, n, bt, wt, quantum) {
		// Make a copy of burst times bt[] to store remaining
		// burst times.
		let rem_bt = new Array(n).fill(0);
		for (let i = 0; i < n; i++)
			rem_bt[i] = bt[i];

		let t = 0; // Current time

		// Keep traversing processes in round robin manner
		// until all of them are not done.
		while (1) {
			let done = true;

			// Traverse all processes one by one repeatedly
			for (let i = 0; i < n; i++) {
				// If burst time of a process is greater than 0
				// then only need to process further
				if (rem_bt[i] > 0) {
					done = false; // There is a pending process

					if (rem_bt[i] > quantum) {
						// Increase the value of t i.e. shows
						// how much time a process has been processed
						t += quantum;

						// Decrease the burst_time of current process
						// by quantum
						rem_bt[i] -= quantum;
					}

					// If burst time is smaller than or equal to
					// quantum. Last cycle for this process
					else {
						// Increase the value of t i.e. shows
						// how much time a process has been processed
						t = t + rem_bt[i];

						// Waiting time is current time minus time
						// used by this process
						wt[i] = t - bt[i];

						// As the process gets fully executed
						// make its remaining burst time = 0
						rem_bt[i] = 0;
					}
				}
			}

			// If all processes are done
			if (done == true)
				break;
		}
	}
}

obj = new RoundRobin(processes, burst_time, 2);
console.log(obj.findavgTime());