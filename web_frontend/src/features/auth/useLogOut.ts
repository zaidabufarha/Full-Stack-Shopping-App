import { useNavigate } from "react-router-dom";
import { useAppDispatch } from "../../app/hooks";
import { baseApi } from "../../app/service/baseApi";
import { logOut } from "./authSlice";

/**
 * The one way to sign out. Clears the token AND the RTK Query cache — cached
 * data is per-user (cart, favorites, is_favorite on products), so without the
 * reset the next person to log in on this browser would see the last one's.
 */
export function useLogOut() {
  const dispatch = useAppDispatch();
  const navigate = useNavigate();

  return () => {
    dispatch(logOut());
    dispatch(baseApi.util.resetApiState());
    navigate("/");
  };
}
