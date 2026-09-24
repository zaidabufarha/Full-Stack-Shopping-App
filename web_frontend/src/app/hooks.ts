import { useDispatch, useSelector } from "react-redux";
import type { AppDispatch, RootState } from "./store";

// Pre-typed versions so components never repeat the RootState cast.
export const useAppDispatch = useDispatch.withTypes<AppDispatch>();
export const useAppSelector = useSelector.withTypes<RootState>();
