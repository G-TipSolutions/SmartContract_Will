pragma solidity >=0.6.10 <0.9.0;

contract Will {
    address owner;
    uint fortune;
    bool deceased;

    constructor() payable public {
        owner = msg.sender; // msg sender: represents address that is being called
        fortune = msg.value; // msg value: tells us how much ether is being sent
        deceased = false;
    }
    // CREATE MODIFIER SO THE ONLY PERSON WHO CAN CALL THE CONTRACT IS THE OWNER
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    // create modefier so that we only allocate funds if friend's gramps deceased
    modifier mustBeDeceased {
        require(deceased = true);
        _;
    }
    //store family wallets in an array
    address payable[] familyWallets;

    // key store value: mapping iteration iterating - looping through - when we map through we iterate through key
    mapping(address => uint) inheritance;

    // set inheritance for each address
    function setInheritance(address payable wallet, uint amount) public {
    // map through and add wallets to familyWallets
    familyWallets.push(wallet);
    inheritance[wallet] = amount;
    }

    //Pay each family member based on their wallet address
    function payout() private mustBeDeceased {
        //for loop  you can loop through things
        for(uint i=0; i<familyWallets.length; i++) {
            familyWallets[i].transfer(inheritance[familyWallets[i]]);
            //transfering the funds from contract address to receiver address
        }
    } 
    function hasDeceased() public onlyOwner {
        deceased = true;
        payout();
    }
}
