## Licensing system for MATLAB apps
> *This project is still a work in progress 🚧. Issues and pull requests are highly appreciated*

*Do you have an developed using MATLAB App Designer that you want to distribute but wish to control who can use it?\
In simple words, you wish to grant app licenses to specific users.*

### Important notes
- This system is dependent on GitHub. You will need to have a GitHub account and a private repository dedicated for your app.
- By integrating this licensing system, your app will need to be connected to the Internet every time the user starts it (during the startup only).

### Step 1: Setting up the license database
1. Create a GitHub account if you don't have one yet.
2. Create a private repository. If you already have a repository specified for the codebase of the app development, you can use that instead. This repository will be referred to as `app-development`.
3. Add `matlab-app-licensing` repository as a submodule of `app-development` ([further reading](https://www.mathworks.com/help/matlab/matlab_prog/add-git-submodules.html)).
4. Add the submodule folder to MATLAB path.
5. Run [`LicenseManager.mlapp`](LicenseManager.mlapp) and follow the instructions in the app.

### Step 2: License database  

### Step 3



