// SPDX-License-Identifier: MIT

/*
⢸⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⡷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠢⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠈⠑⢦⡀⠀⠀⠀⠀⠀
⢸⠀⠀⠀⠀⢀⠖⠒⠒⠒⢤⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠙⢦⡀⠀⠀⠀⠀
⢸⠀⠀⣀⢤⣼⣀⡠⠤⠤⠼⠤⡄⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠙⢄⠀⠀⠀⠀
⢸⠀⠀⠑⡤⠤⡒⠒⠒⡊⠙⡏⠀⢀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠑⠢⡄⠀
⢸⠀⠀⠀⠇⠀⣀⣀⣀⣀⢀⠧⠟⠁⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀
⢸⠀⠀⠀⠸⣀⠀⠀⠈⢉⠟⠓⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸
⢸⠀⠀⠀⠀⠈⢱⡖⠋⠁⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸
⢸⠀⠀⠀⠀⣠⢺⠧⢄⣀⠀⠀⣀⣀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸
⢸⠀⠀⠀⣠⠃⢸⠀⠀⠈⠉⡽⠿⠯⡆⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸
⢸⠀⠀⣰⠁⠀⢸⠀⠀⠀⠀⠉⠉⠉⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸
⢸⠀⠀⠣⠀⠀⢸⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸
⢸⠀⠀⠀⠀⠀⢸⠀⢇⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸
⢸⠀⠀⠀⠀⠀⡌⠀⠈⡆⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸
⢸⠀⠀⠀⠀⢠⠃⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸
⢸⠀⠀⠀⠀⢸⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠷
*/

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

/**
 * @title DadMfers contract
 * @dev Extends ERC721 Non-Fungible Token Standard basic implementation
 */
contract DadMfersV2 is ERC721, ERC721Enumerable, Ownable {

    string public PROVENANCE;
    bool public saleIsActive = false;
    string private _baseURIextended;
    address payable public immutable shareholderAddress;

    uint256 public constant freeMintNumber = 3; // 1000
    uint256 public constant maxMintsPerTx = 20;

    uint256 public constant maxTokens = 5560;
    uint256 public constant publicMax = 5000;

    uint256 public publicTokenPrice = 0.0269 ether;
    bool public burnAllRemainingSupplyForever = false;

    // The actual goat
    address payable public immutable sartoshiAddress = payable(0xF7DcF798971452737f1E6196D36Dd215b43b428D);

    constructor(address payable shareholderAddress_) ERC721("dadmfer", "DADMFER") {
        require(shareholderAddress_ != address(0));
        shareholderAddress = shareholderAddress_;
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721, ERC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function setBaseURI(string memory baseURI_) external onlyOwner() {
        _baseURIextended = baseURI_;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseURIextended;
    }

    function setProvenance(string memory provenance) public onlyOwner {
        PROVENANCE = provenance;
    }

    function setSaleState(bool newState) public onlyOwner {
        saleIsActive = newState;
    }

    function isSaleActive() external view returns (bool) {
        return saleIsActive;
    }

    function updatePublicPrice(uint256 newPrice) public onlyOwner {
        publicTokenPrice = newPrice;
    }

    function setBurnAllRemainingSupplyForever() public onlyOwner {
        burnAllRemainingSupplyForever = true;
    }

    function freeMintForFirst1000(uint numberOfTokens) public {
        require(!burnAllRemainingSupplyForever, "Remaining supply has been burned");
        require(saleIsActive, "Sale must be active to mint Tokens");
        require(numberOfTokens <= maxMintsPerTx, "Exceeded max token purchase");
        require(totalSupply() + numberOfTokens <= freeMintNumber, "Purchase would exceed free mint allowance");
        for(uint i = 0; i < numberOfTokens; i++) {
            uint mintIndex = totalSupply();
            if (totalSupply() < publicMax) {
                _safeMint(msg.sender, mintIndex);
            }
        }
    }

    // this is to mint 1/1s to airdrop to holders
    function devMintForAirdropToV1(uint256 [] memory specialId) external onlyOwner {       
        require(!burnAllRemainingSupplyForever, "Remaining supply has been burned"); 
        for (uint256 i = 0; i < specialId.length; i++) {
            require (specialId[i]!=0);
            require (specialId[i] > publicMax);
            require (specialId[i] < maxTokens);
            _mint(msg.sender, specialId[i]);
        }
    }

    function mint(uint numberOfTokens) public payable {
        require(!burnAllRemainingSupplyForever, "Remaining supply has been burned");
        require(saleIsActive, "Sale must be active to mint Tokens");
        require(numberOfTokens <= maxMintsPerTx, "Exceeded max token purchase");
        require(totalSupply() + numberOfTokens <= publicMax, "Purchase would exceed max supply of tokens");
        require(publicTokenPrice * numberOfTokens <= msg.value, "Ether value sent is not correct");

        for(uint i = 0; i < numberOfTokens; i++) {
            uint mintIndex = totalSupply();
            if (totalSupply() < publicMax) {
                _safeMint(msg.sender, mintIndex);
            }
        }
    }

    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        Address.sendValue(sartoshiAddress, ((balance * 1) / 10));
        Address.sendValue(shareholderAddress, ((balance * 9) / 10));
    }

}