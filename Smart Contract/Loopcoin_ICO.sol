//Loopcoin ICO

//Version of the compiler
pragma solidity ^0.4.11;

contract loopcoin_ico{
    
     //Introduing maximum no of loopcoins available for sale 
    uint public max_loopcoins = 1000000;
    
     //Introducing the usd to loopcoins  conversion private
    uint public usd_to_loopcoin = 1000;
    
     //Introducing the total number of Loopcoins that have been bought by the investors
    uint public total_loopcoins_bought = 0;
     
     //Mapping from the investor address to its equity in Loopcoins and usd_to_loopcoin
    mapping(address => uint) equity_loopcoins;
    mapping(address => uint) equity_usd;
     
     //checking if an investor can buy Loopcoins
    modifier can_buy_loopcoins(uint usd_invested){
         require(usd_invested*usd_to_loopcoin + total_loopcoins_bought<=max_loopcoins);
         _;
    }
    
    //Getting the equity in loopcoin of an investor
    function equity_in_loopcoin(address investor) external constant returns(uint){
        return equity_loopcoins[investor];
    }
    
    //Getting the equity in USD of an investor
    function equity_in_usd(address investor) external constant returns(uint){
        return equity_usd[investor];
    }
    //Buy Loopcoins
    function buy_loopcoins(address investor, uint usd_invested) external
    can_buy_loopcoins(usd_invested){
        uint loopcoins_bought = usd_invested * usd_to_loopcoin;
        equity_loopcoins[investor] += loopcoins_bought;
        equity_usd[investor] = equity_loopcoins[investor];
        total_loopcoins_bought += loopcoins_bought;
    }
    //sell Loopcoins
    function sell_loopcoins(address investor,uint loopcoins_sold) external{
        equity_loopcoins[investor] -= loopcoins_sold;
        equity_usd[investor] = equity_loopcoins[investor]/1000;
        total_loopcoins_bought -= loopcoins_sold;
    }
}

