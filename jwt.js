// const jwt = require('jsonwebtoken');
// const jwtAuthMiddleware = (req,res,next) =>{
//     //first check request headers has authorization or not 
//     const authorization =req.headers.authorization
//     if(!authorization) return res.status(401).json({error:"Token not found"});
//     //extract the jwt token from the request headers
//     const token =req.headers.authorization.split(' ')[1];
//     if(!token) return res.status(401).json({error: 'Unauthorized'});
//     try{
//         //verify the jwt token 
//         const decoded = jwt.verify(token, process.env.JWT_SECRET);
//         //ATTACH USER INFROMATION TO THE REQUEST OBJECT
//         req.user=decoded;
//         next();
//     } catch(err){
//         console.error(err);
//         res.status(401).json({error:'Invalid token'});
//     }
// }
// //function to geneate jwt token 
// const generateToken=(userData) =>{
//     //generate a new jwt token using user data
//     return jwt.sign(userData,process.env.JWT_SECRET);
// }
// module.exports={jwtAuthMiddleware,generateToken};



const jwt = require('jsonwebtoken');

// JWT Authentication Middleware
const jwtAuthMiddleware = (req, res, next) => {
  const authorization = req.headers.authorization;
  if (!authorization) return res.status(401).json({ error: "Token not found" });

  const token = authorization.split(' ')[1];
  if (!token) return res.status(401).json({ error: 'Unauthorized' });

  try {
    console.log("Verifying token:", token); // Log the token
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.user = decoded;  // Attach the decoded user data to the request object
    next();  // Proceed to the next middleware/route handler
  } catch (err) {
    console.error("Token verification error:", err);
    res.status(401).json({ error: 'Invalid token' });
  }
};

// Function to generate JWT token
const generateToken = (userData) => {
  return jwt.sign(userData, process.env.JWT_SECRET, { expiresIn: '1h' }); // Optionally set expiration
};

module.exports = { jwtAuthMiddleware, generateToken };
