## Licensing system for MATLAB apps
> *This project is still a work in progress 🚧. Issues and pull requests are highly appreciated*

*Do you have an app developed using MATLAB App Designer that you want to distribute but wish to control who can use it?*\
*In simple words, you wish to grant app licenses to specific users.*

### Important notes
- This system is dependent on GitHub. You will need to have a GitHub account and a private repository dedicated for your app.
- By integrating this licensing system, your app will need to be connected to the Internet every time the user starts it (during the startup only).

### Step 1: Set up license database
1. Create a GitHub account if you don't have one yet.
2. Create a private repository. If you already have a repository that you use as the codebase of the app development, you can use that instead. This repository will be referred to as `app-development`.
3. Add `matlab-app-licensing` repository as a submodule of `app-development` ([read more](https://www.mathworks.com/help/matlab/matlab_prog/add-git-submodules.html)).
4. Run [`LicenseManager.mlapp`](LicenseManager.mlapp) and follow the instructions in the app (**note: you must have MATLAB installed**).

### Step 2: Integrate license activation component
1. In your app's `mlapp` file, add the following code block at the very beginning of the `StartupFcn(app)` function:

   ```octave
   addpath(genpath('matlab-app-licensing'));
   IsCloseSelected = checkDeviceRegistration(app, 'my-username', 'my-repo-name', 'my-personal-access-token');
   if IsCloseSelected
       delete(app);
       return;
   end
   ```
   Replace `my-username`, `my-repo-name` and `my-personal-access-token` with your username, the `app-development` repository's name and your Personal Access Token (PAT, see no. 2), respectively.
2. Refer [here](https://docs.github.com/en/enterprise-cloud@latest/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) for the guide to generate a PAT. Only `repo` needs to be selected. **Set the PAT to never expires.**
   
   <img width="434" alt="image" src="https://user-images.githubusercontent.com/70192529/162581517-fad41347-7fb9-439b-860e-635dec555b0a.png">
   
### Step 3: Integrate license deactivation component
1. In the App Designer, add a Button or Menu, name/label it as *License Info* or something similar. 
2. Add the following code block at the very beginning of the Button/Menu's callback function:
   
   ```octave
   AppDeactivation(app, 'my-username', 'my-repo-name', 'my-personal-access-token');
   ```
   The same PAT can be used.
