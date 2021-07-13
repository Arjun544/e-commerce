const Category = require("../models/Category");
const mongoose = require("mongoose");

exports.addCategory = async (req, res) => {
  try {
    const { name, icon, color } = req.body;

    if (!name || !icon || !color) {
      return res.json("All fields are required");
    }

    if (name.length < 2) {
      return res.json("Name can't be less than 2 characters");
    }

    const newCategory = Category({
      name,
      icon,
      color,
    });
    await newCategory.save();
    return res.json({
      success: true,
      message: "New category has been added",
    });
  } catch (error) {
    return res.json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.getCategories = async (req, res) => {
  try {
    const categoryList = await Category.find();

    if (!categoryList) {
      return res.json({
        success: false,
        message: "categories not found",
      });
    }

    res.json({
      success: true,
      caegories: categoryList,
    });
  } catch (error) {
    return res.json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.getCategoryById = async (req, res) => {
  try {
    // if (!mongoose.isValidObjectId(req.params.id)) {
    //   return res.status(400).send("Invalid category id");
    // }

    const category = await Category.findById(req.params.id);

    if (!category) {
      return res.json({
        success: false,
        message: "category not found",
      });
    }

    res.json({
      success: true,
      caegories: category,
    });
  } catch (error) {
    return res.json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.updateCategory = async (req, res) => {
  // update only those value passed from req.body
  try {
    // if (!mongoose.isValidObjectId(req.params.id)) {
    //   return res.status(400).send("Invalid category id");
    // }

    const category = await Category.findByIdAndUpdate(
      req.params.id,
      { $set: req.body },
      { new: true }
    );

    if (!category) return res.status(400).send("category not found");

    res.json({
      success: true,
      caegories: category,
    });
  } catch (error) {
    return res.json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.count = async (req, res) => {
 try {
    const categoryCount = await Category.countDocuments((count) => count);

    if (!categoryCount) {
      res.status(500).json({ success: false });
    }
    res.json({
      categoryCount: categoryCount,
    });
 } catch (error) {
   console.log(error);
   return res.json({
     success: false,
     message: "Something went wrong",
   });
 }
};

exports.deleteCategory = async (req, res) => {
  try {
    // if (!mongoose.isValidObjectId(req.params.id)) {
    //   return res.status(400).send("Invalid category id");
    // }

    const category = await Category.findByIdAndRemove(req.params.id);
    if (!category) {
      res.status(403).send({ success: false, msg: "category not found" });
    } else {
      return res.status(200).json({
        success: true,
        message: "Deleted category",
      });
    }
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: "Something went wrong",
    });
  }
};
