import React, { useState, useEffect } from "react";
import CustomButon from "../../components/custom_button";
import { useSnackbar } from "notistack";
import { useForm } from "react-hook-form";
import Logo from "../../components/icons/Logo";
import Loader from "react-loader-spinner";
import { useDispatch } from "react-redux";
import { setAuth } from "../../redux/reducers/authSlice";
import { login } from "../../api/userApi";

const Login = () => {
  const dispatch = useDispatch();
  const { enqueueSnackbar } = useSnackbar();
  const [loading, setLoading] = useState(false);
  const [unMounted, setUnMounted] = useState(false);
  const {
    register,
    handleSubmit,
    setValue,
    formState: { errors },
  } = useForm();

  const onSignIn = async (data) => {
    try {
      setLoading(true);
      const response = await login(data.email, data.password);
      if (response.data.auth) {
        if (!unMounted) {
          JSON.stringify(
            localStorage.setItem("accessToken", response.data.accessToken)
          );
          dispatch(
            setAuth({
              auth: response.data.auth,
              user: response.data.user,
              accessToken: response.data.accessToken,
            })
          );
        }
      }

      setLoading(false);
    } catch (error) {
      enqueueSnackbar(error.response.data.message, {
        variant: "error",
        autoHideDuration: 2000,
      });
    } finally {
      setLoading(false);
    }
  };

  const handleCopy = (e, data) => {
    e.preventDefault();
    setValue("email", "admin@admin.com");
    setValue("password", "adminadmin");
  };

  useEffect(() => {
    return () => {
      setUnMounted(true);
    };
  }, []);

  return (
    <div className="flex flex-col items-center justify-center w-full h-full bg-white">
      <div
        className="flex w-full items-center justify-center 
         mb-20"
      >
        <Logo color={"#EC981A"} />
        <div>
          <span className="text-lg font-semibold ml-2 tracking-wider text-black">
            Sell
          </span>
          <span className="text-lg font-semibold text-customYellow-light tracking-wider">
            Corner
          </span>
        </div>
      </div>
      <form
        className="flex flex-col"
        onSubmit={handleSubmit((data) => onSignIn(data))}
      >
        <div className="flex flex-col">
          <input
            type="email"
            className="h-14 w-80 rounded-2xl text-black bg-bgColor-light pl-4 mb-4 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent "
            placeholder="Email"
            {...register("email", {
              required: true,
              pattern: /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$/i,
            })}
          />
          {errors?.email?.type === "required" && (
            <span className="flex mb-2 text-red-500 text-xs">
              Email is required
            </span>
          )}

          {errors?.email?.type === "pattern" && (
            <span className="flex mb-2 text-red-500 text-xs">
              Enter a valid email
            </span>
          )}
          <input
            type="password"
            className="h-14 w-80 rounded-2xl text-black bg-bgColor-light pl-4 mb-4 shadow-sm focus:outline-none focus:ring-2 focus:ring-purple-600 focus:border-transparent"
            placeholder="Password"
            {...register("password", {
              required: true,
              minLength: 8,
            })}
          />
          {errors?.password?.type === "required" && (
            <span className="flex mb-2 text-red-500 text-xs">
              Password is required
            </span>
          )}
          {errors?.password?.type === "minLength" && (
            <span className="flex mb-2 text-red-500 text-xs">
              Password must have at least 8 characters
            </span>
          )}
          <span className="flex justify-end font-semibold text-xs cursor-pointer text-Grey-dark mt-4 mb-16">
            Forget password?
          </span>
        </div>

        {loading ? (
          <div className="flex items-center justify-center">
            <Loader
              type="Puff"
              color="#00BFFF"
              height={50}
              width={50}
            />
          </div>
        ) : (
          <CustomButon
            text={"Sign in"}
            color={"bg-darkBlue-light"}
            width={80}
            onPressed={handleSubmit((data) => onSignIn(data))}
          />
        )}
      </form>
      {/* <span className=" font-semibold text-xs text-Grey-dark mt-10">OR</span>
      <div className="flex mt-10">
        <SocialButton img={"assets/google.png"} text={"Continue with Google"} />
        <SocialButton
          img={"assets/facebook.png"}
          text={"Continue with Facebook"}
        />
      </div> */}

      <div className="flex  h-20 w-80 items-center justify-around bg-bgColor-light mt-10 rounded-2xl">
        <div className="flex flex-col">
          <span className="text-black text-sm font-semibold">
            Email : admin@admin.com
          </span>
          <span className="text-black text-sm font-semibold">
            Password : adminadmin
          </span>
        </div>
        <button
          onClick={(e) => handleCopy(e)}
          className="bg-green-500 h-10 rounded-lg px-4 text-white font-semibold text-sm tracking-widest hover:bg-green-400"
        >
          Copy
        </button>
      </div>
    </div>
  );
};

export default Login;
