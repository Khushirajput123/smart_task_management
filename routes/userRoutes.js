const express = require("express");
const router = express.Router();

const User = require("../models/user");
const {jwtAuthMiddleware,generateToken}=require('./../jwt');



 router.post('/signup',async (req,res)=>{
  try{
    const data=req.body
    const newUser=new User(data);//model
    const response= await newUser.save();
    console.log('datasaved');
const payload ={
        id:response.id,
        username:response.username
      }
      console.log(JSON.stringify(payload))
      const token = generateToken(payload);
      console.log("Token is: ",token);
      res.status(200).json({response:response, token: token});}


    //res.status(200).json(response);}//200 saved successfully
  catch(err){
    console.log(err);
    res.status(500).json({error:'Internal Server Error'});//500 internal server error
  }})
  
  router.get('/signup',async (req,res)=>{//all data read
    try{
  const data=await User.find();
  console.log('datafetched');
    res.status(200).json(data);
    } catch(err){
      console.log(err);
      res.status(500).json({error:'Internal Server Error'});
    }
    })
  


//login route
router.post('/login',async(req,res)=>{
  try{
    //extract username and password from request body
    const{username,password}=req.body;
    //find the user by username
    const user=await User.findOne({username:username});
    //if user does not exist or passord does not matvh ,return error
    if(!user||!(await user.comparePassword(password))){
      return res.status(401).json({error:'Invalid username or password'});
    }
    //generate token 
    const payload={
      id:user.id,
      username:user.username
    }
    const token = generateToken(payload);
    //return token as response
    // res.json({token})
    res.json({
      token,
      user: {
        _id: user._id,
        username: user.username,
        email: user.email
      }
    });
  }
   catch(err){
   // console.log(err);
   console.log('Signup Error:', err);
    res.status(500).json({error:'Internal Server Error'});//500 internal server error
  }
})
module.exports = router;

