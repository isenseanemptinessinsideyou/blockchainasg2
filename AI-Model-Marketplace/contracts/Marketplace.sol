// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Marketplace {
    struct Model {
        string name;
        string description;
        uint256 price;
        address creator;
        uint8 totalRatings;
        uint8 ratingSum;
    }

    mapping(uint256 => Model) public models;
    uint256 public modelCount;

    function listModel(string memory name, string memory description, uint256 price) public {
        models[modelCount] = Model(name, description, price, msg.sender, 0, 0);
        modelCount++;
    }

    function purchaseModel(uint256 modelId) public payable {
        require(modelId < modelCount, "Model does not exist");
        Model storage model = models[modelId];
        require(msg.value == model.price, "Incorrect payment");
        payable(model.creator).transfer(msg.value);
    }

    function rateModel(uint256 modelId, uint8 rating) public {
        require(modelId < modelCount, "Model does not exist");
        require(rating >= 1 && rating <= 5, "Invalid rating");
        Model storage model = models[modelId];
        model.ratingSum += rating;
        model.totalRatings++;
    }

    function getModelDetails(uint256 modelId) public view returns (string memory, string memory, uint256, address, uint256) {
        require(modelId < modelCount, "Model does not exist");
        Model storage model = models[modelId];
        uint256 averageRating = model.totalRatings > 0 ? model.ratingSum / model.totalRatings : 0;
        return (model.name, model.description, model.price, model.creator, averageRating);
    }
}