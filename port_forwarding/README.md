# Port Forwarding
Port forwarding allows, among other things, users to access the Jupyter Notebook
server from an AWS EC2 instance from the browser of the user's local machine.

Francois Chollet's deep learning book (publisher: Manning) indicates a way to do
that. However, it seems to me too lengthy, his instructions -- Maybe his is more
secure, I don't know.

But here's a quick and tested way to do port forwarding:

1. SSH into the remote EC2 instance (or any remote machine) by specifying the ports you want to forward. For instance,
  ```
  $ ssh -i .ssh/top_secret.cer -L 4321:127.0.0.1:8888 ubuntu@13.158.16.4
  ```
  where
  - `-i .ssh/top_secret.cer` specifies the key to do SSH
  - `-L 4321:127.0.0.1:8888` specifies that
    - `127.0.0.1`, I don't know how to explain this, but use it most of the time, and you'll find that it works. It seems to be sth called remote host
    - `4321` represents the local port on our local machine. You may change this to your likings.
    - `8888` is the remote port and is also Jupyter Notebook's default port
  - `ubuntu@13.158.16.4` is the username and public IP of the EC2 instance that you want to log in
1. Once inside the EC2 instance, install Juypter Notebook and then run an instance of it: The stdout message will show the token to log into the Jupyter Notebook server, which is simply a long alphanumeric string and resembles sth like this `b2752988acb1223ea4fck123945bd01234b182384832dea02`. Copy this token for the next step.
1. Now that the remote Juypter Notebook server is running, open your browser on your local machine, and type in the url **`http://127.0.0.1:4321/?token=b2752988acb1223ea4fck123945bd01234b182384832dea02`**, where the token is the one you obtained in the previous step. Once typing this in and press Enter, you'll find you using the Jupyter Notebook of the remote machine! It's that easy

**Rmk.** I don't know whether this simple method has any security issues. I may ask around and update what information I collect here again.
