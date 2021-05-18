const uuid = require('uuid/v1'); 
const sha256 = require('sha256');
const currentNodeUrl = process.argv[3];


function Blockchain(socketID) {
    this.socketId = socketID;
    this.chain = [];
    this.pendingTransactions = [];
    this.currentNodeUrl = currentNodeUrl;
    this.networkNodes = [];
    this.genesisNewBlock(120, '0', '0'); 
}

Blockchain.prototype.createTransaction = function (amount, sender, recipient) {
    const newTransaction = {
        amount: amount,
        transactionId: uuid().split('-').join(''),
        date: new Date().getDay().toString() + "/" + new Date().getMonth().toString() + "/" + new Date().getFullYear().toString(),
        sender: sender,
        recipient: recipient
    }

    return newTransaction;
}

Blockchain.prototype.genesisNewBlock = function (nonce, previousBlockHash, hash) {
    const newBlock = {
        index: this.chain.length + 1,
        previousBlockHash: previousBlockHash,
        timestamp: Date.now(),
        date: new Date().toString(),
        transactions: this.pendingTransactions,
        nonce: nonce,
        hash: hash,
    }
    this.pendingTransactions = []; 
    this.chain.push(newBlock);
    return newBlock;
}

Blockchain.prototype.getLastBlock = function () {
    return this.chain[this.chain.length - 1];
}



Blockchain.prototype.addTransactionToQueue = function (transactionObject) {
    this.pendingTransactions.push(transactionObject); 
    return this.getLastBlock()['index'] + 1;
}

Blockchain.prototype.hashBlock = function (previousBlockHash, currentBlockData, nonce) {
    const dataAsString = previousBlockHash + nonce.toString() + JSON.stringify(currentBlockData);
    const hash = sha256(dataAsString);
    return hash;
}

Blockchain.prototype.POW = function (previousBlockHash, currentBlockData) {
    let nonce = 0;
    let hash = this.hashBlock(previousBlockHash, currentBlockData, nonce);
    while (hash.substring(0, 4) !== '2140') { 
        nonce++;
        hash = this.hashBlock(previousBlockHash, currentBlockData, nonce);
    }
    return nonce;
}

Blockchain.prototype.getBlock = function (blockHash) {
    let correctBlock = null;
    this.chain.forEach(block => {
        if (block.hash === blockHash)
            correctBlock = block;
    });
    return correctBlock;
};

Blockchain.prototype.getTransaction = function (transactionId) {
    let correctTransaction = null;
    let correctBlock = null;

    this.chain.forEach(block => {
        block.transactions.forEach(transaction => {
            if (transaction.transactionId === transactionId) {
                correctTransaction = transaction;
                correctBlock = block;
            };
        });
    });

    return {
        transaction: correctTransaction,
        block: correctBlock
    };
};

Blockchain.prototype.getTransactionsInQueue = function () {
    return this.pendingTransactions;
};

Blockchain.prototype.getAddressInfor = function (address) {
    const addressTransactions = [];
    this.chain.forEach(block => {
        block.transactions.forEach(transaction => {
            if (transaction.sender === address || transaction.recipient === address) {
                addressTransactions.push(transaction); 
            };
        });
    },);

    if (addressTransactions == null) {
        return false;
    }

    var amountArr = [];
    
    let balance = 0;
    addressTransactions.forEach(transaction => {
        if (transaction.recipient === address) {
            balance += transaction.amount;
            amountArr.push(balance);
        }
        else if (transaction.sender === address) {
            balance -= transaction.amount;
            amountArr.push(balance);
        }
    
    });

    return {
        addressTransactions: addressTransactions,
        addressBalance: balance,
        amountArr: amountArr
    };
};


module.exports = Blockchain;