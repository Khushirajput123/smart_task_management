const mongoose=require('mongoose');
require('dotenv').config();

const mongoURL=process.env.MONGO_URL;
mongoose.connect(mongoURL);

const db=mongoose.connection; 
db.on('connected',()=>{
    console.log('connected to MongoDbversion');//listener
})

db.on('error',(err)=>{
    console.log('connected to MongoDb error:',err);//listener
})

db.on('disconnected',()=>{
    console.log('disconnected');//listener


})

module.exports=db;//export