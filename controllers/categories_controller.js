const Category = require("../models/Category");
const mongoose = require("mongoose");
const cloudinary = require("cloudinary");
const socket = require("../app");

exports.addCategory = async (req, res) => {
  try {
    const { name, icon } = req.body;

    if (name.length < 2) {
      return res.json("Name can't be less than 2 characters");
    }

    if (!icon) {
      return res.json("All fields are required");
    }
    // Upload image to cloudinary
    const result = await cloudinary.uploader.upload(icon);

    const newCategory = Category({
      name,
      icon: result.secure_url,
      iconId: result.public_id,
    });
    await newCategory.save();
    const categories = await Category.find();
    socket.socket.emit("add-category", categories);
    return res.json("New category has been added");
  } catch (error) {
    console.log(error);
    return res.json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.addSubCategory = async (req, res) => {
  try {
    const { name } = req.body;

    if (!name) {
      return res.json("All fields are required");
    }

    if (name.length < 2) {
      return res.json("Name can't be less than 2 characters");
    }
    await Category.findByIdAndUpdate(
      req.params.id,
      {
        $push: {
          subCategories: {
            id: mongoose.Types.ObjectId(),
            name,
          },
        },
      },

      { new: true }
    );
    const categories = await Category.find();
    socket.socket.emit("add-subCategory", categories);
    return res.json({
      success: true,
      message: "Sub category has been added",
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
    const categoryList = await Category.find({ status: true });

    if (!categoryList) {
      return res.json({
        success: false,
        message: "categories not found",
      });
    }

    res.json({ categoryList });
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
  try {
    // delete image
    await cloudinary.uploader.destroy(req.body.iconId, (error, result) => {
      console.log(result, error);
    });
    // upload new again
    const result = await cloudinary.uploader.upload(
      req.body.icon,
      (error, result) => {
        console.log(result, error);
      }
    );

    const category = await Category.findByIdAndUpdate(
      req.params.id,
      {
        $set: {
          name: req.body.name,
          icon: result.secure_url,
          iconId: result.public_id,
          status: req.body.status,
        },
      },
      { new: true }
    );
    const categories = await Category.find();
    socket.socket.emit("edit-category", categories);
    if (!category) return res.status(400).send("category not found");

    res.json({
      success: true,
      categories: category,
    });
  } catch (error) {
    console.log(error);
    return res.json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.updateStatus = async (req, res) => {
  try {
    const category = await Category.findOneAndUpdate(
      req.params.id,
      {
        status: req.params.status,
      },
      { new: true }
    );
    socket.socket.emit("update-categoryStatus", category.status);
    res.send({
      success: true,
      message: "status has been updated",
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      success: false,
      message: "Something went wrong",
    });
  }
};

exports.updateSubCategory = async (req, res) => {
  try {
    const category = await Category.updateOne(
      {
        _id: req.params.id,
        "subCategories.id": mongoose.Types.ObjectId(req.body.subCategoryId),
      },
      {
        $set: {
          "subCategories.$.name": req.body.name,
        },
      }
    );
    const categories = await Category.find();
    socket.socket.emit("edit-subCategory", categories);
    if (!category) return res.status(400).send("Category not found");

    res.json("Sub category has beem updated");
  } catch (error) {
    console.log(error);
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

    // delete image
    await cloudinary.uploader.destroy(req.body.iconId, (error, result) => {
      console.log(result, error);
    });

    const category = await Category.findByIdAndRemove(req.params.id);

    const categories = await Category.find();
    socket.socket.emit("delete-category", categories);

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

exports.deleteSubCategory = async (req, res) => {
  try {
    const category = await Category.findByIdAndUpdate(req.params.id, {
      $pull: {
        subCategories: {
          id: mongoose.Types.ObjectId(req.body.subCategoryId),
        },
      },
    });
    const categories = await Category.find();
    socket.socket.emit("delete-subCategory", categories);

    if (!category) return res.status(400).send("Category not found");

    res.json("Sub category has beem deleted");
  } catch (error) {
    console.log(error);
    return res.json({
      success: false,
      message: "Something went wrong",
    });
  }
};
