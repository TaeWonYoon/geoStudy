

function chartFnc(id,ty, list, label, bg, bd) { //차트 공동함수
	var labelsVal = [];
	var dataVal = [];
	 
	for(var i=0; i < list.length; i++) {
		labelsVal.push(list[i].label_val);
		dataVal.push(list[i].data_val);
	}
	
	const ctx = document.getElementById(id).getContext('2d');
	const myChart = new Chart(ctx, {
	    type: ty,
	    data: {
	        labels: labelsVal,
	        datasets: [{
	            label: label,
	            data: dataVal,
	            backgroundColor: [
	                bg
	            ],
	            borderColor: [
	                'rgba(255, 99, 132, 1)',
	                'rgba(54, 162, 235, 1)',
	                'rgba(255, 206, 86, 1)',
	                'rgba(75, 192, 192, 1)',
	                'rgba(153, 102, 255, 1)',
	                'rgba(255, 159, 64, 1)'
	            ],
	            borderWidth: 1
	        }]
	    },
	    options: {
	        scales: {
	            y: {
	                beginAtZero: true
	            }
	        }
	    }
	});
	
	return myChart;
}

function chartFnc2(id,ty, list, label, bg, bd) { //차트 공동함수
	var labelsVal = [];
	var dataVal = [];
	 
	for(var i=0; i < list.length; i++) {
		var sub = list[i].label_val;
		var label_val = ""; 
		label_val = sub.substr(4,2) + "-" + sub.substr(6,2);
		labelsVal.push(label_val);
		dataVal.push(list[i].data_val);
	}
	
	const ctx = document.getElementById(id).getContext('2d');
	const myChart = new Chart(ctx, {
	    type: ty,
	    data: {
	        labels: labelsVal,
	        datasets: [{
	            label: label,
	            data: dataVal,
	            backgroundColor: [
	                bg
	            ],
	            borderColor: [
	                'rgba(255, 99, 132, 1)',
	                'rgba(54, 162, 235, 1)',
	                'rgba(255, 206, 86, 1)',
	                'rgba(75, 192, 192, 1)',
	                'rgba(153, 102, 255, 1)',
	                'rgba(255, 159, 64, 1)'
	            ],
	            borderWidth: 1
	        }]
	    },
	    options: {
	        scales: {
	            y: {
	                beginAtZero: true
	            }
	        }
	    }
	});
	
	return myChart;
}