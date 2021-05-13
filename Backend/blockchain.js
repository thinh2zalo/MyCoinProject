const uuid = require('uuid/v1'); 
const currentNodeUrl = process.argv[3];
const sha256 = require('sha256');


function Blockchain(IDSocket) {
    this.IDSocket = IDSocket;
    this.pendingTransactions = [];
    this.currentNodeUrl = currentNodeUrl;
    this.networkNodes = [];
    this.chain = [];
    this.genesisNewBlock(120, '0', '0'); 
}

Blockchain.prototype.hashBlock = function (previousBlockHash, currentBlockData, nonce) {
    const dataAsString = previousBlockHash + nonce.toString() + JSON.stringify(currentBlockData);
    const hash = sha256(dataAsString);
    return hash;
}

Blockchain.prototype.getLastBlock = function () {
    return this.chain[this.chain.length - 1];
}

Blockchain.prototype.genesisNewBlock = function (nonce, previousHashBlock, hash) {
    const newBlock = {
        index: this.chain.length + 1,
        transactions: this.pendingTransactions,
        date: new Date().toString(),
        previousBlockHash: previousHashBlock,
        timestamp: Date.now(),
        nonce: nonce,
        hash: hash,
    }
    this.chain.push(newBlock); 
    this.pendingTransactions = []; 
    return newBlock;
}

Blockchain.prototype.addTransactionToQueue = function (transactionObject) {
    this.pendingTransactions.push(transactionObject); 
    return this.getLastBlock()['index'] + 1;
}

Blockchain.prototype.chainIsValid = function (blockchain) {

    let validChain = true;

    for (var i = 1; i < blockchain.length; i++) {
        const currentBlock = blockchain[i];
        const prevBlock = blockchain[i - 1];
        const blockHash = this.hashBlock(prevBlock['hash'], { transactions: currentBlock['transactions'], index: currentBlock['index'] }, currentBlock['nonce']);
        if (blockHash.substring(0, 4) !== '0000') validChain = false;
        if (currentBlock['previousBlockHash'] !== prevBlock['hash']) validChain = false;
    };

    const genesisBlock = blockchain[0];
    const correctNonce = genesisBlock['nonce'] === 100;
    const correctPreviousBlockHash = genesisBlock['previousBlockHash'] === '0';
    const correctHash = genesisBlock['hash'] === '0';
    const correctTransactions = genesisBlock['transactions'].length === 0;

    if (!correctNonce || !correctPreviousBlockHash || !correctHash || !correctTransactions) validChain = false;

    return validChain;
};

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

Blockchain.prototype.getTransactionsInQueue = function () {
    return this.pendingTransactions;
};


module.exports = Blockchain;
