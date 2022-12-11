const fs = require('fs');
const faker = require('faker');

faker.locale = 'es';

const alumnSize = 50;

let insertion = `
INSERT INTO "Alumno"("nom", "sexo", "direc", "fec_nac") VALUES`

const gender = ['female', 'male']

for(let i=1; i <= alumnSize; i++) {
  let ramd = faker.datatype.number(1); 
  let sep = ','

  const address = faker.address.streetName();
  const name = `${faker.name.firstName(gender[ramd])} ${faker.name.lastName()}`;
  const birthday = faker.date.between(
    '1990-01-01T00:00:00.000Z',
    '2005-01-01T00:00:00.000Z'
  ).toLocaleDateString();

  if(i === alumnSize) sep = ';\n';

  insertion += `
    ('${name}', '${gender[ramd]}', '${address}', '${birthday}')${sep}`
}

fs.writeFileSync('./fill-datas.sql', insertion)


// Materias
const matSize = 10;

insertion = `
INSERT INTO "Materia"("nom", "descrip", "nivel", "creditos", "area", "sigla_car") VALUES`

for(let i=1; i <= matSize; i++) {
  let sep = ','

  const name = faker.name.jobType();
  const descrip = faker.name.jobTitle();
  const nivel = faker.datatype.number({ min: 1, max: 9 }); 
  const credits = faker.datatype.number({ min: 1, max: 200 }); 
  const area =  faker.name.jobArea()
  const sigla_car = faker.datatype.number({ min: 1, max: 6 }); 

  if(i === matSize) sep = ';\n';

  insertion += `
    ('${name}', '${descrip}', ${nivel}, '${credits}', '${area}', ${sigla_car})${sep}`
}

fs.appendFileSync('./fill-datas.sql', insertion)



const calfSize = 200;

insertion = `
INSERT INTO "Nota"("ci", "sigla", "gestion", "calif") VALUES`

const ges = [
  'I-2010',
  'II-2010',
  'I-2011',
  'II-2011',
  'I-2012',
  'II-2012',
  'I-2013',
  'II-2013',
  'I-2014',
  'II-2014',
  'I-2015',
  'II-2015',
  'I-2016',
  'II-2016',
  'I-2017',
  'II-2017',
  'I-2018',
  'II-2018',
  'I-2019',
  'II-2019',
  'I-2020',
  'II-2020',
];

for(let i=1; i <= calfSize; i++) {
  let ramd3 = faker.datatype.number(ges.length -1); 

  let sep = ','

  let ci = faker.datatype.number({ min: 1, max: alumnSize }); 
  let sigla = faker.datatype.number({ min: 1, max: matSize }); 
  const gest = ges[ramd3]; 
  const calf = faker.datatype.number(100); 

  if(i === calfSize) sep = ';\n';

  insertion += `
    (${ci}, ${sigla}, '${gest}', ${calf})${sep}`
}

fs.appendFileSync('./fill-datas.sql', insertion)