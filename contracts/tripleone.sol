
pragma solidity >=0.4.22 <0.6.0;

contract tripleone{ 

uint nonTranchedVolume; 
address tokenOwner;

 modifier ownerOnly(){
        require(msg.sender == tokenOwner);
      _; 
    }


   struct Company{
        string _name; // primary key
        string _teamMembers; 
	string _location;
        string _descriptions;
        string _purpose;
        string _solution;
    }

    // this section contains the milestone information
    struct Milestone{
       string _title;
       string _timePeriod;
    }

    struct Budget{
        uint _amount;
        string _item;
    }
    
    struct Customer{
        address customerAddress;
        uint tokens;
	    bool isMarketParticipant; 
    }
    
     Company[] public companies;
    Milestone[] public milestones;
    Budget[] public budgets;
    Customer[] public addresses; 
    Tranche[] public tranches;

    
struct Tranche{
    uint launchDate;
    uint endDate; 
    uint trancheVolume;
    
}

function setTotalTokenValue(uint number) public {
    nonTranchedVolume+=number; 
}
function getTotalTokenVolume() public returns(uint) {
    return nonTranchedVolume;
}

function addTranche(uint launch,uint  end,uint  volume) public returns (uint) {
    tranches.push(Tranche(launch, end, volume));
    nonTranchedVolume -= tranches[tranches.length].trancheVolume;
    
}
function getTranche(uint index, bytes32 tranchedata) public returns (uint){
if(tranchedata == "launchDate"){
    return tranches[index].launchDate;
} else if(tranchedata == "endDate"){
    return tranches[index].endDate;
}  else if(tranchedata == "trancheVolume"){
    return tranches[index].trancheVolume;
}
return 0;
}


function ordersPerCustomer (address customer) public returns (uint orders) {
      uint ordersPerCustomer = 0;
       for (uint x=0; x<addresses.length; x++){
           if (addresses[x].customerAddress == customer){
               ordersPerCustomer+=addresses[x].tokens;
           }
           
       }
       return ordersPerCustomer;
}
function transfer(address customer, address tokenHolder, uint preorders, uint date) public {
    if (tokenHolder!=address(0)){
           for (uint x=0; x<addresses.length; x++){
           if (addresses[x].customerAddress == tokenHolder){
               addresses[x].tokens-=preorders;
         for (uint y=0; y<addresses.length; y++){
           if (addresses[y].customerAddress == customer){
               addresses[y].tokens+=preorders;
           }
           }
           
       }
    }
    
} else {
    if(tranches[tranches.length].launchDate <= date && date <= tranches[tranches.length].endDate){
               for (uint z=0; z<addresses.length; z++){
           if (addresses[z].customerAddress == customer){
               addresses[z].tokens+=preorders;
                nonTranchedVolume-= preorders;
               
           }
           }
        
    }
            
    
}
}
function markTokenSaleBool (bool isForSale, address customer) public returns (bool){
bool result;
if(isForSale == true){
 for (uint z=0; z<addresses.length; z++){
           if (addresses[z].customerAddress == customer){
            addresses[z].isMarketParticipant = true;
	    result = addresses[z].isMarketParticipant;
           }
     } 
    }else {
	 for (uint a=0; a<addresses.length; a++){
           if (addresses[a].customerAddress == customer){
            addresses[a].isMarketParticipant = false;
	    result = addresses[a].isMarketParticipant;
 

     }
    }
}

return result;
    
}


}
