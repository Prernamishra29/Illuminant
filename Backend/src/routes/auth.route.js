import express from "express";
import {
    registerUser,
    loginUser,
    logoutUser,
    getUserProfile,
    updateUserProfile,
    updatePassword,
    forgotPassword
} from "../controllers/auth.controller.js";
import { authenticate } from "../middlewares/authMiddleware.js";

const router = express.Router();

// Public Routes
router.post("/signup", registerUser);
router.post("/login", loginUser);
router.post("/forgot-password", forgotPassword);

// Protected Routes
router.post("/logout", authenticate, logoutUser);
router.get("/me", authenticate, getUserProfile);
router.put("/me/update", authenticate, updateUserProfile);
router.put("/me/password", authenticate, updatePassword);

export default router;
