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
		this.completed = [];

		for (let i = 0; i < n; i++)
			this.rem_bt[i] = this.bt[i];
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
				this.completed.push(processes[i]);
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
			this.completed
		]
	}
	next(){
		if(obj.done) return [];
		let temp = this.itter();
		if(temp[0]) return temp.slice(1);
		else return this.next();
	}
}

let processes = [1,2,3];
let burst_time = [5,2,10];

let obj = new RoundRobin(processes, burst_time, 2);

while(!obj.done){
	console.log(obj.next());
}
