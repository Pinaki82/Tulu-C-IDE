# GIT + SSH + GPG, and Code Signing

![git_ssh_github](https://user-images.githubusercontent.com/16861933/107740857-0d11e100-6d32-11eb-9de0-c0cd08104e00.png)


* _This document is a constituent chapter of the help file of [Tulu-C-IDE](https://github.com/Pinaki82/Tulu-C-IDE.git)._


* _[Tulu-C-IDE](https://github.com/Pinaki82/Tulu-C-IDE.git) is a Vim Text Editor 'configuration' for writing C/C++ codes._


Setting up Git on a PC is not as scary as it seems. It's much easier once you discover how to do that. Operate Git repositories from the terminal, you'll harness the full potential of the Git Version Control System. It's more straightforward to configure SSH on a machine than you might have ever imagined.


First, we will create a GnuPG identity key pair (GPG) for code signing and verification of Git commits to ensure whether a particular commit was made by the repository owner/contributor/genuine GitHub user or not.


And we know, Version Control Systems are Time Machines to rollback changes if ever anything goes wrong with the codebase. A coder can retrieve the work from any given point in time with the help of the VCS. Without VCS, keeping track of continuous development processes and maintaining stability would be a nightmare. We will touch Git VCS shortly; it also pays.


We will learn:
  - To create a GPG key for code signing
  - Configure SSH on a system
  - Operate a Git repository remotely via SSH using terminal/bash


# GnuPG


Let's set up GnuPG and create a new GPG key.
On windows, download [Gpg4win](https://www.gpg4win.org/). Follow the [instructions](https://www.gpg4win.org/doc/en/gpg4win-compendium_11.html) while installing. Click all the checkboxes to install everything. Although, you can skip Claws-Mail.


We are going to do the following:


 - Generate a GPG key
 - Write down the passphrase for the GPG key
 - Save a backup copy of the revocation certificate
 - Export an encrypted blob of the GPG key for future use
 - Upload our newly generated key to public GPG keyservers to let other people know our GPG identity so that they can encrypt and send messages/files to us
 - Add our Secret Key ID to the global Git configuration
 - Configure Git for code signing with GPG using our Secret Key ID


### Programs we need:
 - Linux (*ubuntu)


```
sudo apt install git
```


First, try out the default installation of SSH


```
ssh -V
```

If it is not installed, install OpenSSH Server package by issuing the command below:
You can also follow the [link](https://www.ubuntupit.com/how-to-install-configure-and-enable-ssh-service-in-linux/) if needed. Usually, you'll never need to install SSH on your own.

```
sudo apt install openssh-server
```

Install GPG:

```
sudo apt install gnupg
sudo apt install gpa
sudo apt install kleopatra
sudo apt install xclip
```


If you use a Smartcard like [Gnuk](https://wiki.debian.org/GNUK), you'll also need the following packages on Linux:


[![N|Image of a DIY Gnuk](https://storage.sbg.cloud.ovh.net/v1/AUTH_09eb860780a34c9b959e3eebbf15da7f/storage/blog/2020/06/IMG_20200608_033954.jpg)](https://blog.thestaticturtle.fr/lets-make-a-diy-gpg-usb-key/)


```
sudo apt install libccid
sudo apt install opensc-pkcs11
sudo apt install pcsc-tools
sudo apt install pcscd
sudo apt install opensc
sudo apt install scdaemon
```

 - Windows 10
 
[Gpg4win](https://www.gpg4win.org/)
[git-scm](https://git-scm.com/download/win)

You are ready to proceed with the setup process.


* _I will demonstrate the methods on Windows 10. Results can be reproduced on Linux._


Open the system terminal (cmd.exe on Windows) and check the installed version of `gpg`.


```
gpg --version
```

![2021-02-11 18_31_00-Command Prompt](https://user-images.githubusercontent.com/16861933/107742054-5b27e400-6d34-11eb-98cd-7f19d57f4c98.png)


Generate a GPG key.

```
gpg --full-gen-key
```

![2021-02-11 18_31_32-Command Prompt - gpg  --full-gen-key](https://user-images.githubusercontent.com/16861933/107742928-f3729880-6d35-11eb-97b3-b74067462d5e.png)


GnuPG will guide you till the end of the process. You'll see something like this:

```
  Please select what kind of key you want:

   (1) RSA and RSA (default)

   (2) DSA and Elgamal

   (3) DSA (sign only)

   (4) RSA (sign only)

Your selection? 1
```

![2021-02-11 18_31_44-Command Prompt - gpg  --full-gen-key](https://user-images.githubusercontent.com/16861933/107742987-14d38480-6d36-11eb-9925-deeea351f210.png)

```
RSA keys may be between 1024 and 4096 bits long.
What keysize do you want? (3072)
```

![2021-02-11 18_32_07-Command Prompt - gpg  --full-gen-key](https://user-images.githubusercontent.com/16861933/107743027-274dbe00-6d36-11eb-8ea0-a07f64e8ff00.png)


The default is 3072.

```
Requested keysize is 3072 bits
Please specify how long the key should be valid.
 0 = key does not expire
 <n> = key expires in n days
 <n>w = key expires in n weeks
 <n>m = key expires in n months
 <n>y = key expires in n years
Key is valid for? (0)2y 
```


I set the validity for two years. Two years is fine. You can set the validity period as long as you want. Zero means the key will never expire. You can even set it to four days, just saying!


![2021-02-11 18_32_56-Command Prompt - gpg  --full-gen-key](https://user-images.githubusercontent.com/16861933/107743079-3f254200-6d36-11eb-8de9-34a76f2f9e2f.png)

![2021-02-11 18_33_32-Command Prompt - gpg  --full-gen-key](https://user-images.githubusercontent.com/16861933/107743498-fb7f0800-6d36-11eb-96bc-883972c0632c.png)

Type your real name and email address when prompted.

![2021-02-11 18_34_10-Command Prompt - gpg  --full-gen-key](https://user-images.githubusercontent.com/16861933/107743539-118cc880-6d37-11eb-932a-38ba197c0805.png)

![2021-02-11 18_34_38-Command Prompt - gpg  --full-gen-key](https://user-images.githubusercontent.com/16861933/107743679-531d7380-6d37-11eb-9d48-5b0e6ff99290.png)

![2021-02-11 18_35_15-Command Prompt - gpg  --full-gen-key](https://user-images.githubusercontent.com/16861933/107743915-c7f0ad80-6d37-11eb-8931-aabcd7d8b90e.png)


```
GnuPG needs to construct a user ID to identify your key.
 Real name: XXXXXXXXXX
 Email address: XXXXXXXXXXXX@gyopt.com
 Comment:
```


![2021-02-11 18_35_30-Command Prompt - gpg  --full-gen-key_01](https://user-images.githubusercontent.com/16861933/107743980-e8206c80-6d37-11eb-9ec4-21691bc529a9.png)


Plan a short but effective passphrase beforehand and write it down on a piece of paper. Mix special characters (&%^$@# etc.), uppercase letters, lowercase letters, numbers with memorable + pronounceable words. Don't lose the paper.


![2021-02-11 18_35_30-Command Prompt - gpg  --full-gen-key_02](https://user-images.githubusercontent.com/16861933/107744062-04bca480-6d38-11eb-8126-dc25a741362a.png)

![2021-02-11 18_35_30-Command Prompt - gpg  --full-gen-key_03](https://user-images.githubusercontent.com/16861933/107744110-1bfb9200-6d38-11eb-8d47-34257e0f60cd.png)

![2021-02-11 18_36_35-Command Prompt](https://user-images.githubusercontent.com/16861933/107744171-3cc3e780-6d38-11eb-8017-aed39bd2123a.png)


Copy the revocation certificate to a safe place, for instance, a USB thumb drive.


---------------------------------------------------------

In order to use our GPG key, we must tell Git about the Key ID of the secret key stored on the system or a physical smartcard like Gnuk.


Let's copy that Key ID (secret) from the private key.
**WARNING:** Never reveal your private key to anyone. Never upload it anywhere or publish it to any server, be it GitHub, BitBucket, GitLab or somewhere else. You'll need the Key ID, not the entire key. Remember that.

```
gpg --list-secret-keys --keyid-format LONG
```


![2021-02-11 18_39_40-Command Prompt](https://user-images.githubusercontent.com/16861933/107744507-cf648680-6d38-11eb-9827-f7d0435b45b1.png)


---------------------------------------------------------


It's time to create a backup of your GPG key. In case you need the key later, you can restore it from the backup.


```
gpg --armor --gen-random 1 20
```


GPG will generate a random password for you. Copy the generated password to the system clipboard, also write down the same on another piece of paper, then type the following command. It's not very difficult, though a little long.


**NOTE:** Saving passphrases and passwords to a text file on any digital storage medium (HDDs, USB Drives) is not encouraged.


An example of a generated password:

```
xe3D4jR6pq+Vdy7VrLoTltwxLXk=
```


Type the command to export a backup of the GPG key pair:


```
gpg --armor --export-secret-keys axxxxxxxxxx7@gmail.com | gpg --armor --symmetric --output backup-2021-02-11-05-43-pm.sec.asc
```


![2021-02-11 18_42_21-Command Prompt](https://user-images.githubusercontent.com/16861933/107744620-09358d00-6d39-11eb-855a-cff49da66a4b.png)


---------------------------------------------------------


Assuming you have a backup and you want to restore it, do the following:
 - Download the backup to a newly created folder (e.g., `~/pgp_key_dump` or `%userprofile%\Documents\pgp_key_dump`)
 - Restore the key pair

```
gpg --decrypt backup_20yy-mm-dd.sec.pgp | gpg --import
```
 - Type out the password when prompted
 - Delete the folder along with the content (on Windows, use a file shredder like [Eraser](https://eraser.heidi.ie/))

```
shred -fuz pgp_key_dump/backup_20yy-mm-dd.sec.pgp
```


---------------------------------------------------------

**Copy your GPG public key.**

Open a terminal (or cmd.exe) and type:


```
gpg --export -a axxxxxxxxxx7@gmail.com > %userprofile%\Desktop\axxxxxxxxxx7@gmail.com.publickey.asc.txt
```


Open the file with any advanced text editor program and see how it looks like. It should be something like this:


```
-----BEGIN PGP PUBLIC KEY BLOCK-----

mQGNBF+JP/IBDADDLAlM5l50awl......................
.................................................
.................................................
.................................................
.................................................
.....................QBx0k=
=iabR
-----END PGP PUBLIC KEY BLOCK-----
```


Change the Line Endings (EOL convention) to Linux (for some editors, UNIX).


---------------------------------------------------------

Now you need to upload your GPG key to some public GPG keyservers.

Here's a list:

 - https://keyserver1.pgp.com/vkd/GetWelcomeScreen.event
 - https://pgp.mit.edu/
 - https://pgp.key-server.io/
 - http://keys.gnupg.net/
 - https://keyserver.2ndquadrant.com/
 - https://keyserver.ubuntu.com/


Visit the sites above and publish your PUBLIC KEY. Some of them will send you an email to confirm your identity. If you receive an email from them, verify yourself. **WARNING:** Sometimes, scammers steal your email address to impersonate you. If you think that you haven't uploaded any GPG Public Key to any keyserver recently, do not click on any link sent to your mailbox.

---------------------------------------------------------


Let's add your GPG key to the global Git configuration on your machine. At this time, you might get some error message since you haven't configured SSH yet. Alright! We will repeat the steps later from terminal history.


If you're on Windows 10, open command prompt and repeat some earlier steps.


```
gpg --list-secret-keys --keyid-format LONG
```

![2021-02-11 18_39_40-Command Prompt](https://user-images.githubusercontent.com/16861933/107744507-cf648680-6d38-11eb-9827-f7d0435b45b1.png)


Copy the Secret Key ID (encircled in the red box above). On Windows, select the text you need then hit `<Enter>` to copy the selection.


 - Windows 10 Git Bash


```
where gpg
```


 - Linux Terminal (not needed in Linux)

```
whereis gpg
```


Fire up your Git Bash (on Windows 10) or a Linux Terminal of your choice. Xubuntu comes with the default XFCE Terminal which should be fine.


![2021-02-12 13_56_38-Greenshot](https://user-images.githubusercontent.com/16861933/107749700-02127d00-6d41-11eb-822a-638545c783b6.png)

Type the following commands:

 - Windows 10 Git Bash

```
git config --global gpg.program 'C:\Program Files (x86)\GnuPG\bin\gpg.exe'
```

 - Linux Terminal & Windows 10 Git Bash both

```
git config --global user.signingkey THESECRETKEYIDYOUCOPIEDBEFOREINTHE1STLINE
```


I told you that you'll need the Key ID, not the entire key.

Now tell Git about how it should sign your future commits (with your GPG key) to a remote Git Repository over SSH (or even, over HTTPS).


```
git config --global  commit.gpgsign true
```


Add your GPG configuration to the global Git profile on your machine.


```
test -r ~/.bash_profile && echo 'export GPG_TTY=$(tty)' >> ~/.bash_profile
```


```
echo 'export GPG_TTY=$(tty)' >> ~/.profile
```


Add your name and email to the global Git config.


```
git config --global user.name "Pxxxxx Gupta"
```

```
git config --global user.email axxxxxxxxxx7@example.com
```


Change the global editor (example).


```
git config --global core.editor "'C:\Program Files\Notepad2\Notepad2.exe'"
```

Reference: https://stackoverflow.com/questions/10564/how-can-i-set-up-an-editor-to-work-with-git-on-windows


Add a few ornaments to Git configuration such as how Git should display colours in its terminal, your preferred Diff/Merge Tool etc.:


```
git config --global color.ui true
```


```
git config --global color.status auto
```


```
git config --global color.branch auto
```


Change the default Diff/Merge Tool:


```
git config --global merge.tool 'C:\Program Files (x86)\WinMerge\WinMergeU.exe'
```


Reference: https://www.tutorialspoint.com/git/git_environment.htm


Do a final check:


```
git config --global --edit
```

Your preferred text editor will open, loaded with the `~/.gitconfig` (or, `%userprofile%\.gitconfig`) file.

---------------------------------------------------------


Tell GitHub about your GPG signing key.


Sign in to GitHub and find the 'Settings' from the drop-down menu after clicking at the top-right corner of your profile.

![2021-02-11 22_09_30-GitHub - Brave](https://user-images.githubusercontent.com/16861933/107767235-b076ec00-6d5a-11eb-8af2-ef87ecac87ba.png)

![2021-02-11 22_10_47-Greenshot](https://user-images.githubusercontent.com/16861933/107767279-c2588f00-6d5a-11eb-90fb-864cc5e7d71e.png)


You will see a section for GPG and SSH keys at the left pane.

Click on the 'New GPG key' button (green).


Copy the contents of your GPG Public Key from the text file `axxxxxxxxxx7@gmail.com.publickey.asc.txt` you saved earlier.


Paste the copied contents to the 'Key' field.

![2021-02-12 17_47_18-Greenshot](https://user-images.githubusercontent.com/16861933/107767403-e4521180-6d5a-11eb-9af3-fd6ac6761850.png)

![2021-02-11 22_19_23-Window](https://user-images.githubusercontent.com/16861933/107767805-938ee880-6d5b-11eb-829b-74cd065fa272.png)

Now GitHub knows your GPG Public Key. From now on, whenever you'll make changes to a remote GitHub repository, GitHub will keep a record of whether you've digitally signed your commits with your Private Key or not.


---------------------------------------------------------

### **Configure your machine with SSH:**

Let's come to the SSH section. Without it, we won't be able to push a commit remotely from the system terminal.

Fire up Git Bash and type:

```
ls -al ~/.ssh
```


If you don't see an output that looks something like this, chances are there that your system needs to be configured with an SSH key pair.


![2021-02-12 18_01_26-MINGW64__c_Users_AppuRaja](https://user-images.githubusercontent.com/16861933/107768868-1a909080-6d5d-11eb-80d8-71f0b868f369.png)


The following command will give you an idea of the location where the program `ssh-add` can be found on the system.


 - Linux

```
whereis ssh-add
```

 - Windows 10 Git Bash

```
where ssh-add
```

![2021-02-12 14_50_35-MINGW64__c_Users_AppuRaja](https://user-images.githubusercontent.com/16861933/107750347-e9ef2d80-6d41-11eb-98fb-62bfff709f2a.png)


Make a new folder `.ssh` in the `HOME` (`%userprofile%\.ssh` or `~/.ssh`) directory.


```
mkdir $HOME/.ssh
```


#### Generate an SSH keypair:


```
ssh-keygen -t rsa -b 4096 -C axxxxxxxxxx7@gmail.com
```

Issue this command again:


```
ls -al ~/.ssh
```


Check whether the SSH agent is running. Type the following command, if the SSH agent is not running, it will be started with a Process ID (PID).


```
eval "$(ssh-agent -s)"
```

Or,

```
eval `ssh-agent -s`
```

#### Add your SSH private key to the `ssh-agent`.


```
ssh-agent sh -c 'ssh-add; ssh-add -L'
```


Or,


```
ssh-add ~/.ssh/id_rsa
```

![2021-02-12 18_37_50-MINGW64__c_Users_AppuRaja](https://user-images.githubusercontent.com/16861933/107772045-adcbc500-6d61-11eb-8e53-e67dc31cad71.png)

Type the passphrase when prompted.


Copy your SSH public key to the system clipboard.

 - Linux (Xclip required. Xubuntu: `sudo apt install xclip`)

```
cat ~/.ssh/id_rsa.pub | xclip -sel clip
```

Or,
Dump the SSH public key to a text file for ease of access.

```
cat ~/.ssh/id_rsa.pub > id_rsa.pub.txt
```

 - Windows 10

```
clip < ~/.ssh/id_rsa.pub
```

```
touch.exe id_rsa.pub.txt
```

Now open the file `id_rsa.pub.txt` in a text editor and paste the clipboard contents.

Alternatively, you can open it with `notepad.exe` by issuing:

```
notepad id_rsa.pub.txt
```


Let GitHub know your SSH public key. Otherwise, how would GitHub authenticate the communications from your PC to GitHub's Git servers?


Steps are quite similar to what we did while adding our GPG public key to GitHub. Now we will be adding our SSH public key. See the screenshots below.


Sign in to GitHub and find the 'Settings' from the drop-down menu after clicking at the top-right corner of your profile as before.


Locate the section for GPG and SSH keys at the left pane.


Click the 'New SSH key' button.


Copy the contents of your SSH Public Key from the text file `id_rsa.pub.txt` and paste it there.


Fill the field 'Title' with a recognisable name so that you can identify the device later.


GitHub will allow you to establish a secure connection through the SSH protocol from your machine. If you change your machine, revoke the key and add a new one.

Test your connection.

``
ssh -T git@github.com
``

You'll be asked to add GitHub to known hosts, allow it. Type the passphrase when needed.


After that, you'll be greeted with the following message:


```
Hi Pxxxxxx2! You've successfully authenticated, but GitHub does not provide shell access.
```


## You're SSH ready!


---------------------------------------------------------
---------------------------------------------------------

#### Repeat some GPG steps if necessary.


Repeat the following steps if necessary. These are some of the old GPG related small steps.


```
gpg --list-secret-keys --keyid-format LONG
```

![2021-02-11 18_39_40-Command Prompt](https://user-images.githubusercontent.com/16861933/107744507-cf648680-6d38-11eb-9827-f7d0435b45b1.png)


Copy the Secret Key ID (encircled in the red box above). On Windows, select the text you need then hit `<Enter>` to copy the selection.


 - Windows 10 Git Bash


```
where gpg
```


 - Linux Terminal (not needed in Linux)

```
whereis gpg
```


Fire up your Git Bash (on Windows 10) or a Linux Terminal of your choice. Xubuntu comes with the default XFCE Terminal which should be fine.


![2021-02-12 13_56_38-Greenshot](https://user-images.githubusercontent.com/16861933/107749700-02127d00-6d41-11eb-822a-638545c783b6.png)

Type the following commands:

 - Windows 10 Git Bash

```
git config --global gpg.program 'C:\Program Files (x86)\GnuPG\bin\gpg.exe'
```

 - Linux Terminal & Windows 10 Git Bash both

```
git config --global user.signingkey THESECRETKEYIDYOUCOPIEDBEFOREINTHE1STLINE
```


I told you that you'll need the Key ID, not the entire key.

Now tell Git about how it should sign your future commits (with your GPG key) to a remote Git Repository over SSH (or even, over HTTPS).


```
git config --global  commit.gpgsign true
```


Add your GPG configuration to the global Git profile on your machine.


```
test -r ~/.bash_profile && echo 'export GPG_TTY=$(tty)' >> ~/.bash_profile
```


```
echo 'export GPG_TTY=$(tty)' >> ~/.profile
```


Add your name and email to the global Git config.


```
git config --global user.name "Pxxxxx Gupta"
```

```
git config --global user.email axxxxxxxxxx7@example.com
```


Change the global editor (example).


```
git config --global core.editor "'C:\Program Files\Notepad2\Notepad2.exe'"
```

Reference: https://stackoverflow.com/questions/10564/how-can-i-set-up-an-editor-to-work-with-git-on-windows


Change the default Diff/Merge Tool.


```
git config --global merge.tool 'C:\Program Files (x86)\WinMerge\WinMergeU.exe'
```


Do a final check:


```
git config --global --edit
```


The global config file should look somewhat similar to what you see below:


```
[winUpdater]
	recentlySeenVersion = 2.20.1.windows.1
[user]
	email = axxxxxxxxxx7@gmail.com
	name = Pxxxxx Gupta
	signingkey = JKGHVSDTOFGEWLGH
[commit]
	gpgsign = true
[gpg]
	program = C:\\Program Files (x86)\\GnuPG\\bin\\gpg.exe
[core]
	editor = 'C:\\Program Files\\Notepad2\\Notepad2.exe'
```

You can also give the following a try. See the output.


```
~/.gitconfig
```


Follow the suit and add your SSH public key to your BitBucket and GitLab profiles.

Test your connection.

```
ssh -T git@github.com
```

```
ssh -T git@bitbucket.org
```

```
ssh -T git@gitlab.com
```

---------------------------------------------------------


It's time to control your Git repository from the terminal when everything is ready.


Now we will move to the usage.


Create a new private repository for test purpose that you will delete after a while.

I named it `testprivate`, you may choose a different name.


The link to the private repository is `https://github.com/Pinaki82/testprivate.git`, in our present instance.



We will be working with the **SSH** protocol, not the _HTTPS_ one. So, let's change a few things before cloning it into a hard drive folder. If you clone via HTTPS protocol directly, you are going to face some other hassles, and your SSH key pair is of no use in that HTTPS protocol. If you accidentally clone the HTTPS version, you'll have to type your GitHub username and the 'App Password' every time you'll try to push a commit, and for God knows why you'll also have to type out the complete SSH passphrase alongside in a situation where you are not even using SSH. Not to mention, you need to generate an 'App Password' in your GitHub profile for that. So, forget about HTTPS, and utilise a more conventional SSH setup.


Link to the git repository is `https://github.com/Pinaki82/testprivate.git`.


We cannot clone it with the command `git clone https://github.com/Pinaki82/testprivate.git` since we will always be avoiding the _HTTPS_ protocol. We need the SSH alternative.


Here's the trick:


`https://github.com/` must always be replaced with `git@github.com:`


Thus the right way of cloning the GitHub repository will be:


```
git clone git@github.com:Pinaki82/testprivate.git
```

Now enter the directory. It contains the tracking database in a hidden folder `.git`.


```
cd testprivate/
```


If you've accidentally cloned the _HTTPS_ version of the 'GitHub' repository, here's the way to fix it:

```
git remote set-url origin git@github.com:Pinaki82/testprivate.git
```


Notice the part `git remote set-url origin git@github.com:` before `YourGitHub_Username/YourRepo.git`. Type the command and everything will be fixed.


The folder `.git` contains a file called `config`, aka., `.git/config`. Open that file `config` with a text editor, it should look something as shown below:


```
[core]
	repositoryformatversion = 0
	filemode = false
	bare = false
	logallrefupdates = true
	symlinks = false
	ignorecase = true
[remote "origin"]
	url = git@github.com:Pinaki82/testprivate.git
	fetch = +refs/heads/*:refs/remotes/origin/*
[branch "main"]
	remote = origin
	merge = refs/heads/main

```


Notice the section `[remote "origin"]` and the field `url`. If the `url` doesn't contain any _HTTPS_ link, you're good to go, like,



```
[remote "origin"]
    url = git@github.com:Pinaki82/testprivate.git
```


Look at the screenshots, they are pretty self-explanatory.


First, I'll add a C file after cloning the barebone repository I initiated online from the browser.


```
git add test.c
```

![2021-02-12 21_40_21-MINGW64__g_GitHubSSHTest_testprivate](https://user-images.githubusercontent.com/16861933/107803910-47f33380-6d89-11eb-9e09-413694267879.png)


Now I'll push a commit to the local repo on my hard drive by issuing the command


```
git commit -a
```


GnuPG will be put into action by the Git program. I need my GPG passphrase to sign the commit.


![2021-02-12 21_40_41-How to Add Files to Git _ InMotion Hosting - Brave](https://user-images.githubusercontent.com/16861933/107804373-d49df180-6d89-11eb-9b6e-4b2943bf5b48.png)


After reloading the repo page in my browser,


![2021-02-12 21_42_28-Greenshot](https://user-images.githubusercontent.com/16861933/107804533-fbf4be80-6d89-11eb-9962-c226b7b50e8f.png)


![2021-02-12 21_43_48-Greenshot](https://user-images.githubusercontent.com/16861933/107804656-25ade580-6d8a-11eb-976d-bdb6b7193d27.png)


![2021-02-12 21_46_09-Greenshot](https://user-images.githubusercontent.com/16861933/107804737-46763b00-6d8a-11eb-9f10-b8119bd9e10e.png)


This commit is signed by a verified user's GPG private key. It comes from a verified user.


A brief history of what I did.


![2021-02-12 21_52_21-MINGW64__g_GitHubSSHTest_testprivate](https://user-images.githubusercontent.com/16861933/107805105-e0d67e80-6d8a-11eb-8028-556badbd5ff0.png)


![2021-02-12 21_52_34-MINGW64__g_GitHubSSHTest_testprivate](https://user-images.githubusercontent.com/16861933/107805221-0c596900-6d8b-11eb-9f2c-b993b123035c.png)


Let's add another file to complete the code. I'll add the header file without which the code will remain incomplete.


![2021-02-12 21_49_45-testprivate](https://user-images.githubusercontent.com/16861933/107805847-f39d8300-6d8b-11eb-9fc4-9551ebc9212e.png)


After each commit, Git program will instruct me to provide a brief note about the commit. The preferred text editor will load a file. At the end line (the line that doesn't start with `#`) the note should be added.


![2021-02-12 21_53_36-Window](https://user-images.githubusercontent.com/16861933/107805767-dc5e9580-6d8b-11eb-87ff-5480745fa1b1.png)


GnuPG will ask for the GPG passphrase followed by the immediate update of the note.


![2021-02-12 21_53_55-Window](https://user-images.githubusercontent.com/16861933/107806105-5e4ebe80-6d8c-11eb-9381-6174528f910a.png)


![2021-02-12 21_54_53-MINGW64__g_GitHubSSHTest_testprivate](https://user-images.githubusercontent.com/16861933/107806155-745c7f00-6d8c-11eb-8e92-896eaea7c543.png)


![2021-02-12 21_55_27-Pinaki82_testprivate - Brave](https://user-images.githubusercontent.com/16861933/107806226-8e965d00-6d8c-11eb-8911-5afb8ba4c0bb.png)


Some Git commands:


```
git remote -v
```


```
git config -l
```


![2021-02-12 23_15_44-MINGW64__g_GitHubSSHTest_testprivate](https://user-images.githubusercontent.com/16861933/107806301-a837a480-6d8c-11eb-90d0-b80189257b14.png)


Depending on the situation, we might work with a codebase on a different machine or edit the code online on our phone from a phone browser. After returning to the main workhorse, we will have to synchronise the codebase. `git pull` is very useful in such cases to download the latest developments from the central GitHub repo.


```
git pull origin main
```


`git checkout` and `git status` are for querying any out-of-sync issue.


```
git checkout
```


```
git status
```


`git commit -a` push changes to the local repo on the hard drive.


```
git commit -a
```


To push the changes to the central (remote) GitHub repository servers, we need to issue,


```
git push origin main
```


`git push --delete origin 'a_release_tag'` deletes a particular release. The tag name must be supplied. It's a dangerous command, so not advisable to try.


Here is an example that demonstrates how to clone a BitBucket repository.


```
git clone git@bitbucket.org:Easter_Bucket/test_n_del.git
```


'Easter_Bucket' is my BitBucket profile name.


Dump the Bash History to a text file for future reference:


```
history > bashhisttxtfile.txt
```


---------------------------------------------------------


**Tip:** On Windows, Git comes with some useful utilities. `git-gui` and `gitk` are such notable mentions. These tools occasionally come in handy when you do not want to deal with the command-line utilities for some reason. How to reap the benefits of `gitk` and `git-gui` is something that you must know even if you rarely use them.


`gitk` is a graphical Git commit viewer for tracking changes more tangibly through its simple GUI. `git-gui` is a built-in GUI tool for Git, for committing changes to the repository.


Here, in our example of a private test repository, we cloned our repo with the command


```
git clone git@github.com:Pinaki82/testprivate.git
```


Let's assume we cloned it into "E:\myfirsttesgithubtrepo". Enter the directory and right-click on any blank area inside 'Windows Explorer' and select `Git Bash Here`, then issue the command

```
git clone git@github.com:Pinaki82/testprivate.git
```

And, type `ls`. It will give you an overview of the contents of the directory. The subfolder `testprivate` was cloned from GitHub servers. Git keeps its configurations and tracking database inside a folder called `.git` which can be found in the cloned repo folder. So let's enter that cloned folder `testprivate` as well, `cd testprivate/` and make a few changes, say, add a comment to a `C` file, return to Git Bash and type the commands `gitk` and `git-gui` consecutively. See what happens. The default Git tools are pretty self-explanatory and intuitive.


How would you get those tools on Linux?


```
sudo apt install git
sudo apt install gitk
sudo apt install git-gui
```


```
sudo apt install gitg
```


`gitg` is another simple yet excellent Git GUI tool from GNOME.


---------------------------------------------------------


### Type your SSH passphrase only once on Windows


On MS Windows, you have an option to save some typing efforts. Create a file `.bashrc` in your `$HOME` directory (`%userprofile%`) and fill the file with the following contents. You'll have to type your SSH passphrase only once, at every reboot.


```
# https://web.archive.org/web/20200921190557/https://docs.github.com/en/github/authenticating-to-github/working-with-ssh-key-passphrases

# ~/.profile or ~/.bashrc (~/ means %userprofile%) (i.e., %userprofile%\.profile or, %userprofile%\.bashrc)

env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi

unset env

```


---------------------------------------------------------


## Use KeePassXC as an SSH agent on Linux


KeePassXC can be served as an SSH agent on Linux. This approach has some obvious advantages over storing SSH keypair on hard drives. KeePassXC will take care of the SSH passphrase which is the greatest advantage, plus, storing SSH keypairs on hard drives is less-secure than keeping them inside encrypted password database vaults which can take advantage of multifactor authentication. A KDBX vault can be protected further with a key file. The master password of a vault will unlock the database and add an SSH agent to the system keyring till a session ends. Nobody will be able to use the SSH keys until the vault gives them access to the SSH private key. Hence, nobody will be able to intercept the SSH connection without your involvement in cavalier security practises.


So, let's checkout.


Type the command below as usual. It will tell us whether an SSH keypair exists or not.


```
ls -al ~/.ssh
```


![2021-02-14_00-19](https://user-images.githubusercontent.com/16861933/107861590-cd034900-6e6c-11eb-8a47-0f617aefa5e1.png)


Make sure whether the ssh-agent is running.


```
eval "$(ssh-agent -s)"
```


Or,


```
eval `ssh-agent -s`
```


![2021-02-14_00-20](https://user-images.githubusercontent.com/16861933/107861631-223f5a80-6e6d-11eb-852b-07010589f718.png)


We need the output of the command `ssh-add -l`. See https://superuser.com/questions/1595123/how-do-i-use-keepassxc-as-an-ssh-agent


```
ssh-add -l
```

For the first time, you might get a warning that says the agent has not identities.


![2021-02-14_00-20_1](https://user-images.githubusercontent.com/16861933/107861740-c0332500-6e6d-11eb-9eb6-2c117cc364cb.png)


Well! Try to connect to a Git server as usual.


```
ssh -T git@github.com
```


Type your SSH passphrase.


![2021-02-14_00-23](https://user-images.githubusercontent.com/16861933/107861835-831b6280-6e6e-11eb-89da-91a475ebf940.png)


You'll be asked to type your SSH passphrase. Type it, too.


![2021-02-14_00-25](https://user-images.githubusercontent.com/16861933/107861855-a0e8c780-6e6e-11eb-9b1d-84b74a59c4bd.png)


Try again to get the identity of the SSH agent because that identity will be your Username in KeePassXC's SSH key vault.


```
ssh-add -l
```


You may have to add your SSH private key to the ssh-agent once again, but it doesn't harm anything.


```
ssh-agent sh -c 'ssh-add; ssh-add -L'
```


With some trial and error, you will eventually be there to get an output of the command `ssh-add -l`.


Copy the SSH-agent ID as shown in the screenshot below. It's marked by the yellow box.


![2021-02-14_00-29](https://user-images.githubusercontent.com/16861933/107862036-ea85e200-6e6f-11eb-86d6-7937bf2ecd05.png)


Test your connection again.


```
ssh -T git@github.com
```


![2021-02-14_00-31](https://user-images.githubusercontent.com/16861933/107862076-3d5f9980-6e70-11eb-86ef-0cbfdb04fc1a.png)


Install KeePassXC DEB package from the Ubuntu repository. Snap or AppImage versions will not work with the SSH agent. Ubuntu repository might contain an outdated version of the password manager so try the repository that KeePassXC team provides. The Ubuntu repo versions will also be fine for our use case.


```
sudo add-apt-repository ppa:phoerious/keepassxc
sudo apt install keepassxc
```


After finishing the installation, open the program and follow the steps captured as screenshots.


![2021-02-14_00-32](https://user-images.githubusercontent.com/16861933/107862237-7f3d0f80-6e71-11eb-8e0e-04111cda29f0.png)


Go to Application Settings then enable SSH integration.


![2021-02-14_00-33](https://user-images.githubusercontent.com/16861933/107862280-bad7d980-6e71-11eb-9384-895d3466a646.png)


Now create a new vault. Don't use your personal password database. Create a New Entry and fill the fields as shown below. Give this entry a unique name, e.g., 'SSH-Lenovo-Y410' or 'SSH-Xubuntu-HP-Pavilion-X360' or 'SSH-DESKTOP-i5-4570S' etc. The ID of the SSH agent you copied will go to the Username field. The SSH passphrase will go to the Password field. Attach both the private and the public SSH keys to the database. You'll only need the SSH private key. As a backup, you can retain a copy of the SSH public key in the database as well. In the SSH Agent section of the vault, select `id_rsa` from the attached files and add it to the system keyring (system SSH agent). After applying changes to the database, right-click on the entry and choose 'Add Key to SSH Agent'. KeePassXC will save the database on its own. Move your private SSH key to somewhere else (it has to be a safe place), just leave the public one on the drive. Reboot your system, start the SSH-agent, open the vault, select the entry and repeat choosing 'Add Key to SSH Agent'. You are almost ready to use KeePassXC as an SSH agent at the moment. Try to get the output of the SSH-agent with `ssh-add -l` and test your connection `ssh -T git@github.com`. The demonstration may exactly not match the steps that you may have to take on your setup, however, it will be more or less similar to how I configured KeePassXC as an SSH agent on my Xubuntu laptop. KeePassXC outperforms every password managers when it comes to feature set and the ease of use. Nothing can beat KeePassXC's flexibility.


![2021-02-14_00-35](https://user-images.githubusercontent.com/16861933/107862858-ee1c6780-6e75-11eb-9a08-35efff3da56f.png)


![2021-02-14_00-36](https://user-images.githubusercontent.com/16861933/107862868-faa0c000-6e75-11eb-8603-3f7d18bc63a4.png)


![2021-02-14_00-38](https://user-images.githubusercontent.com/16861933/107862874-05f3eb80-6e76-11eb-9621-4639ab883a88.png)


![2021-02-14_00-39](https://user-images.githubusercontent.com/16861933/107862891-10ae8080-6e76-11eb-972f-f54aea2d1184.png)


![2021-02-14_00-39-2](https://user-images.githubusercontent.com/16861933/107862897-1b691580-6e76-11eb-8fdb-9a781484294c.png)


![photo_2021-02-14_01-09-00](https://user-images.githubusercontent.com/16861933/107862913-36d42080-6e76-11eb-94d9-80d540f01fbd.jpg)


![2021-02-14_01-04](https://user-images.githubusercontent.com/16861933/107862904-29b73180-6e76-11eb-8d30-2ad1720e5329.png)


---------------------------------------------------------


Git is extremely versatile thus this document doesn't intend to be a documentation of Git itself. A comprehensive guide to Git would have been a subject to another Markdown file. Many Git tutorials can be found online. I'd request the readers to learn Git from online resources after setting up SSH and GPG with their Git server profiles.


Have a nice Git-SSH journey ahead!


* **NOTE:** _A PDF copy of this document can be generated from [Markdown2PDF
](https://md2pdf.netlify.app/) for an offline reference._


### Further references:

https://www.freecodecamp.org/news/git-ssh-how-to/

https://support.atlassian.com/bitbucket-cloud/docs/set-up-an-ssh-key/

https://github.community/t/how-to-delete-release-completely/1466/3

https://dev.to/shostarsson/how-to-use-pgp-to-sign-your-commits-on-github-gitlab-bitbucket-3dae

https://docs.github.com/en/github/authenticating-to-github/telling-git-about-your-signing-key

https://stackoverflow.com/questions/36810467/git-commit-signing-failed-secret-key-not-available

https://support.atlassian.com/bitbucket-cloud/docs/copy-your-git-repository-and-add-files/

https://codex.so/gpg-verification-github

https://medium.com/@ginnyfahs/github-error-authentication-failed-from-command-line-3a545bfd0ca8

https://docs.github.com/en/github/authenticating-to-github/working-with-ssh-key-passphrases

https://unix.stackexchange.com/questions/369038/how-to-stop-github-always-asking-for-username-password

https://www.freecodecamp.org/news/how-to-fix-git-always-asking-for-user-credentials/

https://github.com/dolmen/github-keygen

https://www.openkeychain.org/faq/

https://kb.b3networks.com/article/h4h804k2q1-generate-public-and-private-key

https://blog.thestaticturtle.fr/lets-make-a-diy-gpg-usb-key/

https://blog.danman.eu/2-usb-crypto-token-for-use-with-gpg-and-ssh/

https://blog.dan.drown.org/gnuk-open-source-gpg-ssh-hardware-key-storage/

https://www.drewgreen.net/converting-a-cheap-2-st-link-v2-clone-into-a-hardware-gpg-key/


* _This document has been edited with the online markdown editor at https://dillinger.io/_

