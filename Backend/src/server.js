
const express = require('express');
const app = express();
const Blockchain = require('./blockchain');
const uuid = require('uuid/v1');
const rp = require('request-promise');
const sha256 = require('sha256');
const fs = require('fs');
const http = require('http');
var server = http.createServer(app);
var forge = require('node-forge');
process.env.NODE_TLS_REJECT_UNAUTHORIZED = "0";


const blockchain = new Blockchain();
const privateKey = uuid().split('-').join(''); 
const public_key = sha256(privateKey);
const master = blockchain.createTransaction(1000000, "system", public_key);
blockchain.chain[0].transactions.push(master);



fs.appendFileSync('masterKeys.txt', '\nprivateKey: ' + privateKey);
fs.appendFileSync('masterKeys..txt', '\npublicKey: ' + public_key);



app.set('view engine', 'ejs');

const port = process.env.PORT || process.argv[2];


app.use(express.json());
app.use(express.urlencoded());

var server = app.listen(port, function () {
    console.log('listening to port: ' + port);
});



function search(nameKey, myArray) {
    for (var i = 0; i < myArray.length; i++) {
        if (myArray[i].socketId === nameKey) {
            return i;
        }
    }
}


const nodes = [];
var io = require('socket.io')(server);

io.on('connection', (socket) => {

    nodes.push(new Blockchain(socket.id));
    socket.emit('PT', blockchain.pendingTransactions);
    console.log('New user connected');
    console.log(socket.id);

    app.post('/new-wallet', (req, res) => {

        const privateKey = uuid().split('-').join('');
        const public_key = sha256(privateKey); 
        const master = blockchain.createTransaction(120.0, "system", public_key);
        var id = Math.floor(Math.random() * 1000000);
        fs.appendFileSync('masterKeys.txt', '\nid: ' + id);
        fs.appendFileSync('masterKeys.txt', '\nprivateKey: ' + privateKey);
        fs.appendFileSync('masterKeystxt', '\npublicKey: ' + public_key);
        fs.appendFileSync('masterKeys.txt', '\naccountName: ' + req.body.accountName);

        blockchain.chain[blockchain.chain.length - 1].transactions.push(master);
        res.json({items:
            [{  userId: id,
                privateKey: privateKey,
                publicKey: public_key,
                account: req.body.account,
                amount: 120,
            }]}
        );
    });


    app.post('/transaction-broadcast', (req, res) => {

        const amount = parseFloat(req.body.amount);
        const newTransaction = nodes[nodes.length - 1].createTransaction(amount, req.body.sender, req.body.recipient);
        let flag = true;

        let sender = req.body.sender;
        if ((sender !== "system") && (sender !== "system: new user") && (sender !== "system: invitation confirmed")) {
            const privateKey_Is_Valid = sha256(req.body.privKey) === req.body.sender;
            if (!privateKey_Is_Valid) {
                flag = false;
                res.json({
                    data: false
                });
            }
            const addressInfor = blockchain.getAddressInfor(req.body.sender);
            const addressInfor1 = blockchain.getAddressInfor(req.body.recipient);
            if (addressInfor.addressBalance < amount || addressInfor === false || addressInfor1 === false) {
                flag = false;
                res.json({
                    data: false
                });
            }
            if (req.body.amount.length === 0 || amount === 0 || amount < 0 || req.body.sender.length === 0 || req.body.recipient.length === 0) {
                flag = false;
                res.json({
                    data: false
                });
            }
        }

        if (amount > 0 && flag === true) {
            var pt = null;
            blockchain.addTransactionToQueue(newTransaction);//put new transaction in global object
            nodes.forEach(socketNode => {
                socketNode.addTransactionToPendingTransactions(newTransaction);
                io.clients().sockets[(socketNode.socketId).toString()].pendingTransactions = socketNode.pendingTransactions;//add property to socket
                pt = socketNode.pendingTransactions;
            });
            io.clients().emit('pending transaction', pt);
            res.json({
                data: `Transaction successfully!`
            });
        }
    });

    app.get('/mine', (req, res) => {
        const lastBlock = blockchain.getLastBlock();
        const previousBlockHash = lastBlock['hash'];

        const currentBlockData = {
            transactions: blockchain.pendingTransactions,
            index: lastBlock['index'] + 1
        }

        const nonce = blockchain.POW(previousBlockHash, currentBlockData);
        const blockHash = blockchain.hashBlock(previousBlockHash, currentBlockData, nonce);
        const newBlock = blockchain.genesisNewBlock(nonce, previousBlockHash, blockHash);
        const requestOptions = {//a promise to make a new block
            uri: blockchain.currentNodeUrl + '/receive-new-block',
            method: 'POST',
            body: { newBlock: newBlock },
            json: true
        };
        rp(requestOptions)
            .then(data => {
                const requestOptions = {
                    uri: blockchain.currentNodeUrl + '/transaction-broadcast',
                    method: 'POST',
                    body: {
                        amount: 12,
                        sender: "system",
                        recipient: public_key
                    },
                    json: true
                };
                return rp(requestOptions);
            })
            .then(data => {
                res.json({
                    data: "New block mined and broadcast successfully",
                    block: newBlock
                });
            });
    });


    app.post('/receive-new-block', (req, res) => {
        const newBlock = req.body.newBlock;
        const lastBlock = blockchain.getLastBlock();
        const correctHash = lastBlock.hash === newBlock.previousBlockHash;
        const correctIndex = lastBlock['index'] + 1 === newBlock['index'];

        if (correctHash && correctIndex) {
            blockchain.chain.push(newBlock);
            blockchain.pendingTransactions = [];
            res.json({
                data: 'New block received and accepted.',
                newBlock: newBlock
            });
        }
        else {
            res.json({
                data: 'New block rejected',
                newBlock: newBlock
            });
        }
    });


    app.get('/emitMiningSuccess', (req, res) => {
        io.clients().emit('mineSuccess', true);
    });


    app.get('/pendingTransactions', (req, res) => {
        const transactionsData = blockchain.getTransactionsInQueue();
        res.json({ items: transactionsData

        });
    });

    app.get('/blockchain', (req, res) => {
        res.send(blockchain);
    });

    
    var keyPair = forge.pki.rsa.generateKeyPair(1024);
    app.get('/generateKeyPair', (req, res) => {
        res.send(keyPair.publicKey);
    });


    app.post('/hashKeys', (req, res) => {
        const k1 = req.body.key1;

        const k2 = req.body.key2;
        const privateKey_Is_Valid = sha256(k1) === k2;

        const addressInfor = blockchain.getAddressInfor(k2);
        if (addressInfor === false) {
            res.json({
                data: false
            });
        }

        else if (!privateKey_Is_Valid) {
            res.json({
                data: false
            });
        }
        else {
            res.json({
                data: true
            });
        }

    });


  
    socket.on('disconnect', () => {
        console.log(`User: ${socket.id} was disconnected`)
        nodes.splice(search((socket.id).toString(), nodes), 1);
    });

});




app.get('/block/:blockHash', (req, res) => {
    const blockHash = req.params.blockHash;
    const correctBlock = blockchain.getBlock(blockHash);
    res.json({
        block: correctBlock
    });
});

app.get('/transaction/:transactionId', (req, res) => {
    const transactionId = req.params.transactionId;
    const trasactionData = blockchain.getTransaction(transactionId);
    res.json({
        transaction: trasactionData.transaction,
        block: trasactionData.block
    });
});

app.get('/address/:address', (req, res) => {
    const address = req.params.address;
    const addressInfor = blockchain.getAddressInfor(address);
    res.json({
        items: [
            addressInfor

        ]
    });
});



