const COLORS = [
  'red',
  'orange',
  'blue',
  'black',
  'green',
  'purple',
  'skyblue',
  'aqua',
  'blueviolet',
  'coral',
  'darkgreen',
  'darkslategray',
  'darkorange',
  'crimson',
  'chartreuse',
  'chololate',
  'firebrick',
  'fuchsia',
  'deeppink',
  'indigo'
];

var randomColor = function() {
  return COLORS[Math.floor(Math.random() * COLORS.length)];
}

export default randomColor;
