// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract DecentralizedFreightShipping {
    struct Shipment {
        uint256 id;
        string origin;
        string destination;
        uint256 timestamp;
        address carrier;
        bool delivered;
    }

    mapping(uint256 => Shipment) public shipments;
    uint256 public shipmentCount;
    
    event ShipmentCreated(uint256 id, string origin, string destination, address carrier);
    event ShipmentDelivered(uint256 id);

    function createShipment(string memory _origin, string memory _destination, address _carrier) public {
        shipmentCount++;
        shipments[shipmentCount] = Shipment(shipmentCount, _origin, _destination, block.timestamp, _carrier, false);
        emit ShipmentCreated(shipmentCount, _origin, _destination, _carrier);
    }

    function markDelivered(uint256 _id) public {
        require(shipments[_id].carrier == msg.sender, "Only the assigned carrier can mark delivery");
        require(!shipments[_id].delivered, "Shipment is already delivered");
        shipments[_id].delivered = true;
        emit ShipmentDelivered(_id);
    }
}
