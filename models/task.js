
const mongoose = require("mongoose");

const taskSchema = new mongoose.Schema(
  {
    title: {
      type: String,
      required: true,
      trim: true
    },

    description: {
      type: String,
      default: "",
      trim: true
    },

    // status: {
    //   type: String,
    //   enum: ["pending", "in progress", "completed"],
    //   default: "pending"
    // },

    dueDate: {
      type: Date
    },

    priority: {
      type: String,
      enum: ["low", "medium", "high"],
      default: "medium"
    },

    category: {
      type: String,
      enum: ["Default", "Personal", "Shopping", "Wishlist", "Work", "Finished"],
      default: "Default"
    },

    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true
    },
    // userId: { type: mongoose.Schema.Types.ObjectId, ref: "User" },

    isQuickTask: {
      type: Boolean,
      default: false
    },

    completedAt: {
      type: Date
    },

    isArchived: {
      type: Boolean,
      default: false
    },

    reminderTime: {
      type: Date
    },

    isDeleted: {
      type: Boolean,
      default: false
    }
  },
  {
    timestamps: true
  }
);

const Task = mongoose.model("Task", taskSchema);
module.exports = Task;
