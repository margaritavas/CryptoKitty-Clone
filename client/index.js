var web3 = new Web3(Web3.givenProvider);

var instance;
var user;
var contractAddress="0x413721A619954b82510d0eaDA6c97A2dEF98a321";

$(document).ready(function(){
    window.ethereum.enable().then(function(accounts){
        instance = new web3.eth.Contract(abi, contractAddress, {from:accounts[0]});
        user = accounts[0];
      console.log(instance);

    }).then( function(){
      instance.events.Birth().on('data', function(event){
          let owner = event.returnValues.owner;
                  console.log(owner);
                  let newKittenId = event.returnValues.newKittenId;
                  console.log(newKittenId);
                  let mumId = event.returnValues.mumId;
                  console.log(mumId);
                  let dadId = event.returnValues.dadId;
                  console.log(dadId);
                  let genes = event.returnValues.genes;
                  console.log(genes);
                  $("#kittyCreation").css("display", "block");
                  $("#kittyCreation").text("Kitty Id: " + newKittenId 
                                      + " Owner: " + owner 
                                      + " Mum Id: " + mumId 
                                      + " Dad Id: " + dadId 
                                      + " Genes: " + genes );
          }).on('error', console.error);
})
  })


  $('#create_kitty').click(() =>{
    var DNA = getDna();
      instance.methods.createKittyGen0(DNA).send({}, function(error, txHash){
      if (error){
        alert("Cat creation failed!")
      }
      else{
        console.log(txHash)
      }
    })
  });