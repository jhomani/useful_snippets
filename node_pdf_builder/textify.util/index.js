const convHundreds = (input = 0) =>{
  const dictionary = require('./dictionary.json');

  let scannedOnes = false;
  let scannedTens = false;
  let texted = '';

  if(dictionary[input]) texted = dictionary[input];
  else while(input !== 0) {
    const tens = input % 100; 
    const ones = input % 10; 

    if((tens <= 30 || tens % 10 === 0) && !scannedOnes) {
      input = parseInt(input/100);
      scannedOnes = true;
      scannedTens = true;

      texted = dictionary[tens]; 
    } else {
      let keyNum;

      if(scannedTens && scannedOnes) {
        keyNum = ones * 100;
      } else if(scannedOnes) {
        keyNum = ones * 10;
        scannedTens = true;
      } else {
        keyNum = ones;
        scannedOnes = true; 
      }

      if(keyNum < 10) texted = `y ${dictionary[keyNum]}`; 
      else if(keyNum === 100) texted = `Ciento ${texted}`;
      else texted = `${dictionary[keyNum]} ${texted}`; 

      input = parseInt(input/10);
    }
  }

  return texted;
}

export const textify = (input = 0) => {
  let texted;

  const prefix = input < 0 ? 'Menos ' : '';
  input = Math.abs(parseInt(input)); 

  if(input >= 1000) {
    const separadors = ['', 'Mil', 'Mi', 'Mil', 'Bi', 'Mil', 'Tri'];
    let hundreds;

    while(input !== 0 && separadors.length) {
      hundreds = input % 1000;
      input = parseInt(input / 1000)

      const separador = separadors.shift()
      let converted = convHundreds(hundreds);
      let complement = ''; 

      if(hundreds % 10 === 1 && hundreds % 100 !== 11 && separador !== '')
        converted = converted.slice(0,-1);

      if(separador === 'Mil')
        complement = hundreds === 1 ? 'Mil' : `${converted} Mil`;
      else if(!['', 'Mil'].includes(separador))
        complement = `${converted} ${separador}llones`;
      else
        texted = hundreds !== 0 ? converted : ''; 

      if(complement && texted) 
        texted = `${complement} ${texted}`; 
      else if(complement)
        texted = complement; 
    }

  } else texted = convHundreds(input);

  return prefix + texted;
}
