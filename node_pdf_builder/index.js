const { jsPDF } = require("jspdf"); 

const xpage = 188;
const ypage = 500;
const maxWidth = xpage - 14;

const xmiddle = xpage/2; 

let ypointer = 20;

let textHeight = 13;
let marginTop = 10;

const doc = new jsPDF({
  unit: 'px',
  format: [xpage, ypage],
  hotfixes: ["px_scaling"],
});

doc.addFont("./fonts/Cambria.ttf", "cambria", "normal");
doc.addFont("./fonts/cambriab.ttf", "cambria", "bold");

doc.setFontSize(8.5);
doc.setFont("cambria", "bold");

const inputData = {
  title: 'COLEGIO DE ODONTÓLOGOS DE LA PAZ',
  date: '2022-06-10 16:15',
  user: 'JUAN CARLOS MAMANI FLORES',
}

const footer = 'Aporte voluntario, conserve este recibo mantenga sus cuotas al dia para disfrutar de todos los beneficios que tiene el C.O.L.P.';

let heightTaked = Math.ceil(doc.getTextWidth(inputData.title) / maxWidth) * textHeight; 
ypointer += (heightTaked / 2); 
console.log(ypointer)
doc.text(inputData.title, xmiddle, ypointer, {maxWidth, align: "center"});

marginTop = 15;
ypointer += (heightTaked / 2) + marginTop + (textHeight/2); 
doc.text("APORTES ORDINARIOS", xmiddle, ypointer, {maxWidth, align: "center"});

ypointer += textHeight; 
doc.setFont("cambria", "normal");
doc.text(inputData.date, xmiddle, ypointer, {maxWidth, align: "center"});

marginTop = 25;
ypointer += textHeight + marginTop; 
doc.setFont("cambria", "normal");

doc.setLineWidth(0.1);
doc.setDrawColor(0, 0, 0);

doc.setLineDash();
doc.line(7, ypointer-20, xpage - 7, ypointer-20);

doc.setLineDash([1, 1.5]);
doc.line(7, ypointer, xpage - 7, ypointer);

doc.text('CUOTA 2022 [Ene, Feb, Abr, May, Jun, Jul, Ago, Sep, Oct, Nov, Dic]', 10, ypointer+29, {maxWidth: 115, align: 'justify'});
doc.text('CUOTA 2023 [Ene, Feb, Abr, May]', 10, ypointer+79, {maxWidth: 115, align: 'justify'});

heightTaked = Math.ceil(doc.getTextWidth(footer) / maxWidth) * textHeight; 
ypointer = (ypage-40) - (heightTaked / 2);  
doc.text(footer, xmiddle, ypointer, {maxWidth, align: "center"});

// console.log(doc.getFontList());
// console.log(doc.output('a4.png'));
doc.save("a4.pdf"); 
