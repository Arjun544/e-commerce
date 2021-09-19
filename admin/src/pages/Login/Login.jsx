import React from "react";
import CustomButon from "../../components/custom_button";
import SocialButton from "./components/social_button";
import { useSnackbar } from "notistack";
import { useForm } from "react-hook-form";
import Logo from "../../components/icons/Logo";
import Loader from "react-loader-spinner";
import { useLoginMutation } from "../../api/userApi";
import { useDispatch } from "react-redux";
import { setAuth } from "../../redux/authSlice";
import { useHistory } from "react-router-dom";

const Login = () => {
  const dispatch = useDispatch();
  const history = useHistory();
  const { enqueueSnackbar, closeSnackbar } = useSnackbar();
  const [login, { isLoading }] = useLoginMutation();
  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm();

  const onSignIn = async (data) => {
    const body = {
      email: data.email,
      password: data.password,
    };
    try {
      const { data } = await login(body);
      dispatch(setAuth({ auth: data.auth, user: data.user }));

      if (data.error) {
        enqueueSnackbar(data.error.data.message, {
          variant: "error",
          autoHideDuration: 2000,
        });
      }
    } catch (error) {
      enqueueSnackbar(error.message, {
        variant: "error",
        autoHideDuration: 2000,
      });
    }
  };

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

        {isLoading ? (
          <div className="flex items-center justify-center">
            <Loader
              type="Puff"
              color="#00BFFF"
              height={50}
              width={50}
              timeout={3000} //3 secs
            />
          </div>
        ) : (
          <CustomButon
            text={"Sign in"}
            color={"bg-darkBlue-light"}
            width={72}
            onPressed={handleSubmit((data) => onSignIn(data))}
          />
        )}
      </form>
      <span className=" font-semibold text-xs text-Grey-dark mt-10">OR</span>
      <div className="flex mt-10">
        <SocialButton img={"assets/google.png"} text={"Continue with Google"} />
        <SocialButton
          img={"assets/facebook.png"}
          text={"Continue with Facebook"}
        />
      </div>
    </div>
  );
};

export default Login;
