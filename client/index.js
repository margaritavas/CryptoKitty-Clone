var web3 = new Web3(Web3.givenProvider);


var instance;
var user;
var contractAddress="0x26fAA1318db55b41D378E4148e349E76d7B94afF";


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

  function createKitty() {
    var dnaStr = getDna();
    let res;
    try {
      res = instance.methods.createKittyGen0(dnaStr).send();
    } catch (error) {
      console.log("Cat creation failed");
    }
  }
//Gen 0 cats for sale
async function contractCatalog() {
  var arrayId = await instance.methods.getAllTokenOnSale().call();
  for (i = 0; i < arrayId.length; i++) {
    if(arrayId[i] != "0"){
      appendKitty(arrayId[i])
    }    
  }
}

//Get kittues of a current address
async function myKitties() {
  var arrayId = await instance.methods.tokensOfOwner(user).call();
  for (i = 0; i < arrayId.length; i++) {
    appendKitty(arrayId[i])
  }
}

//Get kittues for breeding that are not selected
async function breedKitties(gender) {
  var arrayId = await instance.methods.tokensOfOwner(user).call();
  for (i = 0; i < arrayId.length; i++) {
    appendBreed(arrayId[i], gender)
  }
}

//Appending cats to breed selection
async function appendBreed(id, gender) {
  var kitty = await instance.methods.getKitty(id).call()
  breedAppend(kitty[0], id, kitty['generation'], gender)
}

//Appending cats to breed selection
async function breed(dadId, mumId) {
  try {
    await instance.methods.Breeding(dadId, mumId).send()
  } catch (err) {
    log(err)
  }
}

//Appending cats for catalog
async function appendKitty(id) {
  var kitty = await instance.methods.getKitty(id).call()
  appendCat(kitty[0], id, kitty['generation'])
}


  