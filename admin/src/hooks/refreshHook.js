import { useState, useEffect } from "react";
import axios from "axios";
import { useDispatch } from "react-redux";
import { setAuth } from "../redux/authSlice";
export function RefreshHook() {
  const api = axios.create();
  const [loading, setLoading] = useState(true);
  const dispatch = useDispatch();
  useEffect(() => {
    (async () => {
      try {
        const { data } = await api.get("/api/admin/refresh", {
          withCredentials: true,
        });
        dispatch(setAuth(data));
        setLoading(false);
      } catch (err) {
        setLoading(false);
      }
    })();
  }, []);

  return { loading };
}
