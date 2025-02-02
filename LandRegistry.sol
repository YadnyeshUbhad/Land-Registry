// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract LandRegistry is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _landIdCounter;
    
    struct Land {
        uint256 id;
        string ownerName;
        string location;
        uint256 area;
        address owner;
        bool registered;
        uint256 price;
        bool isForSale;
        bool isMortgaged;
        string geoTag;
        uint256 leaseExpiry;
    }
    
    struct Lease {
        address lessee;
        uint256 leaseEnd;
        uint256 rent;
    }
    
    struct Dispute {
        address complainant;
        string reason;
        bool resolved;
    }
    
    mapping(uint256 => Land) public lands;
    mapping(uint256 => address[]) public ownershipHistory;
    mapping(uint256 => Lease) public leases;
    mapping(uint256 => Dispute) public disputes;
    mapping(address => uint256[]) public userLands;
    
    event LandRegistered(uint256 indexed landId, string ownerName, string location, uint256 area, address indexed owner);
    event OwnershipTransferred(uint256 indexed landId, address indexed oldOwner, address indexed newOwner);
    event LandListedForSale(uint256 indexed landId, uint256 price);
    event LandLeased(uint256 indexed landId, address indexed lessee, uint256 leaseEnd, uint256 rent);
    event DisputeRaised(uint256 indexed landId, address indexed complainant, string reason);
    event DisputeResolved(uint256 indexed landId);
    event BidPlaced(uint256 indexed landId, address indexed bidder, uint256 amount);
    event SaleFinalized(uint256 indexed landId, address indexed buyer, uint256 price);
    
    modifier onlyLandOwner(uint256 _id) {
        require(ownerOf(_id) == msg.sender, "Only owner can perform this action");
        _;
    }
    
    constructor() ERC721("LandRegistryNFT", "LAND") {}
    
    function registerLand(uint256 _landId, string memory _ownerName, string memory _location, uint256 _area, string memory _geoTag, string memory _tokenURI) public onlyOwner {
        require(lands[_landId].registered == false, "Land ID already exists");
        
        lands[_landId] = Land(_landId, _ownerName, _location, _area, msg.sender, true, 0, false, false, _geoTag, 0);
        _mint(msg.sender, _landId);
        _setTokenURI(_landId, _tokenURI);
        
        ownershipHistory[_landId].push(msg.sender);
        userLands[msg.sender].push(_landId);
        
        emit LandRegistered(_landId, _ownerName, _location, _area, msg.sender);
    }
    
    function transferOwnership(uint256 _id, address _newOwner) public onlyLandOwner(_id) {
        require(lands[_id].registered, "Land not registered");
        require(!lands[_id].isMortgaged, "Cannot transfer mortgaged land");
        require(block.timestamp > lands[_id].leaseExpiry, "Land is currently leased");
        
        _transfer(msg.sender, _newOwner, _id);
        lands[_id].owner = _newOwner;
        ownershipHistory[_id].push(_newOwner);
        userLands[_newOwner].push(_id);
        
        emit OwnershipTransferred(_id, msg.sender, _newOwner);
    }
    
    function leaseLand(uint256 _id, address _lessee, uint256 _duration, uint256 _rent) public onlyLandOwner(_id) {
        leases[_id] = Lease(_lessee, block.timestamp + _duration, _rent);
        lands[_id].leaseExpiry = block.timestamp + _duration;
        emit LandLeased(_id, _lessee, block.timestamp + _duration, _rent);
    }
    
    function raiseDispute(uint256 _id, string memory _reason) public {
        disputes[_id] = Dispute(msg.sender, _reason, false);
        emit DisputeRaised(_id, msg.sender, _reason);
    }
    
    function resolveDispute(uint256 _id) public onlyOwner {
        require(!disputes[_id].resolved, "Dispute already resolved");
        disputes[_id].resolved = true;
        emit DisputeResolved(_id);
    }
    
    function listLandForSale(uint256 _id, uint256 _price) public onlyLandOwner(_id) {
        lands[_id].isForSale = true;
        lands[_id].price = _price;
        emit LandListedForSale(_id, _price);
    }
    
    function buyLand(uint256 _id) public payable {
        require(lands[_id].isForSale, "Land is not for sale");
        require(msg.value >= lands[_id].price, "Insufficient payment");
        
        address previousOwner = lands[_id].owner;
        payable(previousOwner).transfer(msg.value);
        
        lands[_id].isForSale = false;
        lands[_id].price = 0;
        transferOwnership(_id, msg.sender);
        
        emit SaleFinalized(_id, msg.sender, msg.value);
    }
    
    function placeBid(uint256 _id) public payable {
        require(lands[_id].isForSale, "Land is not for sale");
        require(msg.value > lands[_id].price, "Bid must be higher than current price");
        
        lands[_id].price = msg.value;
        emit BidPlaced(_id, msg.sender, msg.value);
    }
    
    function getLandDetails(uint256 _id) public view returns (Land memory) {
        return lands[_id];
    }
    
    function getOwnershipHistory(uint256 _id) public view returns (address[] memory) {
        return ownershipHistory[_id];
    }
    
    function getUserLands(address _user) public view returns (uint256[] memory) {
        return userLands[_user];
    }
}
