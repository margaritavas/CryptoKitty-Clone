var colors = Object.values(allColors())

var defaultDNA = {
    "headcolor" : 10,
    "mouthColor" : 13,
    "eyesColor" : 96,
    "earsColor" : 10,
    //Cattributes
    "eyesShape" : 1,
    "collarShape" : 1,
    "shapeColor" : 13,
    "collarColor" : 13,
    "animation" :  1,
    "lastNum" :  1
    }

// when page load

$( document ).ready(function() {
  $('#dnabody').html(defaultDNA.headcolor);
  $('#dnamouth').html(defaultDNA.mouthColor);
  $('#dnaeyes').html(defaultDNA.eyesColor);
  $('#dnaears').html(defaultDNA.earsColor);
   $('#dnashape').html(defaultDNA.eyesShape);
   $('#dnacollarShape').html(defaultDNA.collarShape);
   $('#dnashapeColor').html(defaultDNA.shapeColor);
   $('#dnacollarColor').html(defaultDNA.collarColor);
   $('#dnaanimation').html(defaultDNA.animation);
   $('#dnaspecial').html(defaultDNA.lastNum);
  renderCat(defaultDNA)
});


$("#random_kitty").on("click", function(){
  var randomDNA = {
    "headcolor" : Math.floor(Math.random() * 89) + 10,
    "mouthColor" : Math.floor(Math.random() * 89) + 10,
    "eyesColor" : Math.floor(Math.random() * 89) + 10,
    "earsColor" : Math.floor(Math.random() * 89) + 10,
    "eyesShape" : Math.floor(Math.random() * 4) + 1,
    "collarShape" : Math.floor(Math.random() * 5) + 1,
    "shapeColor" : Math.floor(Math.random() * 89) + 10,
    "collarColor" : Math.floor(Math.random() * 89) + 10,
    "animation" : Math.floor(Math.random() * 7) + 1,
    "lastNum" : 1
  }
  $('#dnabody').html(randomDNA.headcolor);
  $('#dnamouth').html(randomDNA.mouthColor);
  $('#dnaeyes').html(randomDNA.eyesColor);
  $('#dnaears').html(randomDNA.earsColor);
   $('#dnashape').html(randomDNA.eyesShape);
   $('#dnacollarShape').html(randomDNA.collarShape);
   $('#dnashapeColor').html(randomDNA.shapeColor);
   $('#dnacollarColor').html(randomDNA.collarColor);
   $('#dnaanimation').html(randomDNA.animation);
   $('#dnaspecial').html(randomDNA.lastNum);
  renderCat(randomDNA);
});

$("#default_kitty").on("click", function(){
  renderCat(defaultDNA)
});

function getDna(){
    var dna = ''
    dna += $('#dnabody').html()
    dna += $('#dnamouth').html()
    dna += $('#dnaeyes').html()
    dna += $('#dnaears').html()
    dna += $('#dnashape').html()
    dna += $('#dnacollarShape').html()
    dna += $('#dnashapeColor').html()
    dna += $('#dnacollarColor').html()
    dna += $('#dnaanimation').html()
    dna += $('#dnaspecial').html()

    return parseInt(dna)
}

function renderCat(dna){
    headcolor(colors[dna.headcolor],dna.headcolor)
    $('#bodycolor').val(dna.headcolor)
    mouthColor(colors[dna.mouthColor], dna.mouthColor)
    $('#mouthcolor').val(dna.mouthColor)
    eyesColor(colors[dna.eyesColor], dna.eyesColor)
    $('#eyescolor').val(dna.eyesColor)
    earsColor(colors[dna.earsColor], dna.earsColor)
    $('#earscolor').val(dna.earsColor)
    eyeVariation(dna.eyesShape)
    $('#eyeshape').val(dna.eyesShape)
    collarVariation(dna.collarShape)
    $('#collarshape').val(dna.collarShape)
    shapeColor(colors[dna.shapeColor], dna.shapeColor)
    $('#shapecolor').val(dna.shapeColor)
    collarColor(colors[dna.collarColor], dna.collarColor)
    $('#collarcolor').val(dna.collarColor)
    animationVariation(dna.animation)
    $('#animation').val(dna.animation)
}

// Changing cat colors
$('#bodycolor').change(()=>{
    var colorVal = $('#bodycolor').val()
    headcolor(colors[colorVal],colorVal)
})

$('#mouthcolor').change(()=>{
  var colorVal = $('#mouthcolor').val()
  mouthColor(colors[colorVal],colorVal)
})

$('#eyescolor').change(()=>{
  var colorVal = $('#eyescolor').val()
  eyesColor(colors[colorVal],colorVal)
})

$('#earscolor').change(()=>{
  var colorVal = $('#earscolor').val()
  earsColor(colors[colorVal],colorVal)
})

$('#eyeshape').change(()=>{
  var shape = parseInt($('#eyeshape').val())
  eyeVariation(shape)
})

$('#collarshape').change(()=>{
  var shape= parseInt($('#collarshape').val())
  collarVariation(shape)
})

$('#shapecolor').change(()=>{
  var colorVal = $('#shapecolor').val()
  shapeColor(colors[colorVal],colorVal)
})

$('#collarcolor').change(()=>{
  var colorVal = $('#collarcolor').val()
  collarColor(colors[colorVal],colorVal)
})

$('#animation').change(()=>{
  var animationVal= parseInt($('#animation').val())
  animationVariation(animationVal)
})