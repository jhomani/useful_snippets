const getAbbreviation = (text = '') => {
	let abbr = '';
	
	for(let i=0; i < text.length; i++) {
		if(text[i].match(/[A-Z]/))
			abbr += text[i] + '.'; 
	}

	return abbr;
}

console.log(getAbbreviation(''));
