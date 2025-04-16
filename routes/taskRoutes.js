const express = require("express");
const router = express.Router();
const Task = require("../models/task");

// Create a task
router.post("/tasks", async (req, res) => {
  try {
    const newTask = new Task(req.body);
    const savedTask = await newTask.save();
    console.log("Task saved");
    res.status(200).json(savedTask);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

// Get all tasks
router.get("/tasks", async (req, res) => {
  try {
    //const tasks = await Task.find().populate("userId", "username email");
    const data=await Task.find();
    console.log("Tasks fetched");
    res.status(200).json(data);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Internal Server Error" });
  }
});




router.put('/tasks/:id',async(req,res)=>{
          try{
            const TaskId=req.params.id;//extracttheid from the url parameter
            const updatedTaskData=req.body;//data send by user to update(json)
            const response= await Task.findByIdAndUpdate(TaskId,updatedTaskData,{
  new:true,//return the updated document
  runValidators:true,//run mongoose validation
            })
            if(!response){
              return res.status(404).json({error:'Task not found'});
            }
            console.log('data updated');
            res.status(200).json(response);
          }catch(err){
            console.log(err);
            res.status(500).json({error:'Internal Server Error'});//500 internal server error
          }
        })
  
  
        //delete
        
  
  
        router.delete('/tasks/:id', async (req, res) => {
          try {
              const TaskId = req.params.id;
             // const response = await Person.findByIdAndRemove(personId);
             const response = await Task.findByIdAndDelete(TaskId);
  
      
              if (!response) {
                  return res.status(404).json({ error: 'Task not found' });
              }
      
              console.log('Data deleted');
              res.status(200).json({ message: 'Task deleted successfully' });
          } catch (err) {
              console.log(err);
              res.status(500).json({ error: 'Internal Server Error' }); // 500 internal server error
          }
      });
      
  
     
module.exports = router;
