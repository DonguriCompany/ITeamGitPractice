function date() {

	let today = new Date();

	let year = today.getFullYear();
	let month = today.getMonth() + 1;
	let date = today.getDate();
	
	const msg = year + '/' + month + '/' + date ;
	document.getElementById('date').innerHTML = msg;
}
document.addEventListener('DOMContentLoaded', date);

function time() {

	let time = new Date();

	let hour = time.getHours(); 
	let min = String(time.getMinutes()).padStart(2,'0');
	let seconds = String(time.getSeconds()).padStart(2,'0');

    const msg = hour+':'+min+':'+seconds;
	document.getElementById('time').innerHTML = msg;
}
setInterval(time,1000);
