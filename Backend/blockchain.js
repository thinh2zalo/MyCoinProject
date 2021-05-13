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
