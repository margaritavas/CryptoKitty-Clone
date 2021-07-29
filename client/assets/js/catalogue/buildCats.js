
// CSS properties to build each cat depending on the DNA


var colors = Object.values(allColors())

function headColor(color,code) {
    $('.cat_head, .body').css('background', '#' + color)  //This changes the color of the cat
    $('#headcode').html('code: '+code) //This updates text of the badge next to the slider
    $('#dnabody').html(code) //This updates the body color part of the DNA that is displayed below the cat
}

function mouthColor(color,code) {
    $('.cat_mouth-contour, .belly').css('background', '#' + color)  //This changes the color of the cat
    $('#bellycode').html('code: '+code) //This updates text of the badge next to the slider
    $('#dnamouth').html(code) //This updates the body color part of the DNA that is displayed below the cat
}

function eyesColor(color,code) {
    $('.eye').css('background', '#' + color)  //This changes the color of the cat
    $('#eyescode').html('code: '+code) //This updates text of the badge next to the slider
    $('#dnaeyes').html(code) //This updates the body color part of the DNA that is displayed below the cat
}

function earsColor(color,code) {
    $('.ear, .foot').css('background', '#' + color)  //This changes the color of the cat
    $('#earscode').html('code: '+code) //This updates text of the badge next to the slider
    $('#dnaears').html(code) //This updates the body color part of the DNA that is displayed below the cat
}

function shapeColor(color,code) {
    $('.collar_shape').css('background', '#' + color)  //This changes the color of the cat
    $('#shapecode').html('code: '+code) //This updates text of the badge next to the slider
    $('#dnashapeColor').html(code) //This updates the body color part of the DNA that is displayed below the cat
}

function shapeColor(color,code) {
    $('.collar_shape').css('background', '#' + color)  //This changes the color of the cat
    $('#shapecode').html('code: '+code) //This updates text of the badge next to the slider
    $('#dnashapeColor').html(code) //This updates the body color part of the DNA that is displayed below the cat
}

function collarColor(color,code) {
    $('.collar').css('background', '#' + color)  //This changes the color of the cat
    $('#collarcode').html('code: '+code) //This updates text of the badge next to the slider
    $('#dnacollarColor').html(code) //This updates the body color part of the DNA that is displayed below the cat
}
//###################################################
//Functions below will be used later on in the project
//###################################################
function eyeVariation(num) {
    $('#dnashape').html(num)
    switch (num) {
        case 1:
            normalEyes()
            $('#eyeName').html('Basic')
            break
        case 2:
            eyesType1()
            $('#eyeName').html('Chill')
            break
        case 3:
            eyesType2()
            $('#eyeName').html('Scared')
            break
        case 4:
            eyesType3()
            $('#eyeName').html('Looks up')
            break
    }
}

function normalEyes() {
    $('.eye').css('border', 'none')
    
}

function eyesType1() {
    normalEyes()
      $('.eye').css('border-top', '8px solid')
      $('.inner_eye_big').css('width', '7px')
      $('.inner_eye_big').css('left', '15px')
      /*$('.inner_eye_small').css('display', 'none')
      $('.inner_eye_smallest').css('display', 'none')*/
      $('.pupils').css('width', '28px')
      $('.pupils').css('left', '6px')
}

 function eyesType2() {
    normalEyes()
     $('.pupils').css('width', '14px')
     $('.pupils').css('left', '16px')
     $('.pupils').css('top', '6px')
     $('.inner_eye_big').css('width', '3px')
     $('.inner_eye_big').css('left', '6px')
     $('.inner_eye_small').css('left', '6px')
     $('.inner_eye_smallest').css('left', '1px')
}

 function eyesType3() {
    normalEyes() 
     $('.pupils').css('width', '24px')
     $('.pupils').css('left','14px' )
     $('.pupils').css('top', '0px')
     $('.inner_eye_big').css('width', '7px')
     $('.inner_eye_big').css('left', '15px')
     $('.inner_eye_small').css('left', '14px')
     $('.inner_eye_smallest').css('left', '6px')
     $('.inner_eye_smallest').css('top', '26px')
     
}

function collarVariation(num) {
    $('#dnacollarShape').html(num)
    switch (num) {
        case 1:
            $('#shapeName').html('Circle')
            normalCollar()
            break
        case 2:
            
            $('#shapeName').html('Rectangle')
            collarShape1()
            break
        case 3:
            
            $('#shapeName').html('Diamond')
            collarShape2()
            break
         case 4:
            
            $('#shapeName').html('Oval')
            collarShape3()
            break
        case 5:
            
            $('#shapeName').html('None')
            collarShape4()
            break
            
    }
}
function normalCollar() {
    $('.collar_shape').css('display', 'block')
    $('.collar_shape').css('border-radius', '50%')
    $('.collar_shape').css('width', '25px')
    $('.collar_shape').css('height', '25px')
    $('.collar_shape').css('left', '28px')
    $('.collar_shape').css('top', '6px')
    $('.collar_shape').css('transform', 'rotate(-5deg)')
    $('.collar_shape').css('border', 'none')
    
}

     function collarShape1() {
        normalCollar()
         $('.collar_shape').css('border-radius', '0px')
         $('.collar_shape').css('width', '30px')
         $('.collar_shape').css('left', '30px')
         $('.collar_shape').css('top', '6px')
         $('.collar_shape').css('transform', 'rotate(-1deg)')
    }

     function collarShape2() {
        normalCollar()
         $('.collar_shape').css('border-radius', '0px')
         $('.collar_shape').css('width', '20px')
         $('.collar_shape').css('height', '20px')
         $('.collar_shape').css('left', '32px')
         $('.collar_shape').css('top', '11px')
         $('.collar_shape').css('transform', 'rotate(45deg)')
    }

     function collarShape3() {
        normalCollar()
         $('.collar_shape').css('border-radius', '100px/ 50px')
         $('.collar_shape').css('width', '29px')
         $('.collar_shape').css('height', '14px')
         $('.collar_shape').css('left', '30px')
         $('.collar_shape').css('top', '14px')
         $('.collar_shape').css('transform', 'rotate(90deg)')
    }
    
    function collarShape4() {
        normalCollar()
        $('.collar_shape').css('display', 'none')        
   }
     
   function animationVariation(num) {
    $('#dnaanimation').html(num)
    switch (num) {
        case 1:
            animationType1()
            $('#animationName').html('Head move')
            break
        case 2:
            animationType2()
            $('#animationName').html('Ears move')
            break
        case 3:
            animationType3()
            $('#animationName').html('Big eyes')
            break
        case 4:
            animationType4()
            $('#animationName').html('Feet move')
            break
        case 5:
            animationType5()
            $('#animationName').html('Jiggly belly')
            break
        case 6:
        animationType6()
        $('#animationName').html('Tail wiggle')
        break
        case 7:
            animationType7()
            $('#animationName').html('No animation')
            break
    }}


    function animationType1(){
        $(".cat_head").addClass("movingHead");
    }

    function animationType2(){
        removeAnimation()
        $(".ears").addClass("movingEars");
    }

    function animationType3(){
        removeAnimation()
        $(".eyes").addClass("movingEyes");
    }

    function animationType4(){
        removeAnimation()
        $(".foot").addClass("movingFeet");
    }

    function animationType5(){
        removeAnimation()
        $(".belly").addClass("movingBelly");
    }

    function animationType6(){
        removeAnimation()
        $(".tail").addClass("movingTail");
    }

    function animationType7(){
        removeAnimation()
    }
    function removeAnimation(){
        $(".cat_head").removeClass("movingHead")
        $(".ears").removeClass("movingEars")
        $(".eyes").removeClass("movingEyes")
        $(".foot").removeClass("movingFeet")
        $(".belly").removeClass("movingBelly")
        $(".tail").removeClass("movingTail")
    }